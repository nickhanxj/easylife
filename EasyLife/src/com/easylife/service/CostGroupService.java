package com.easylife.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.easylife.dao.CostGroupDao;
import com.easylife.dao.MemberDao;
import com.easylife.domain.CostGroup;
import com.easylife.domain.GroupMember;
import com.easylife.util.Page;

@Service
@Transactional
public class CostGroupService {
	@Resource
	private CostGroupDao groupDao;
	@Resource
	private MemberDao memberDao;
	
	public List<CostGroup> findAll(){
		List<CostGroup> selectAll = groupDao.selectAll(CostGroup.class);
		return selectAll;
	}
	
	public CostGroup getById(Long groupId){
		return groupDao.getById(CostGroup.class, groupId);
	}
	
	public Page<CostGroup> selectPage(int currentPage, int pageSize, Map<String, String> params){
		StringBuffer baseHql = new StringBuffer("from CostGroup cg order by cg.createTime desc");
		Page<CostGroup> page = new Page<CostGroup>();
		page.setCurrentPage(currentPage);
		page.setPageSize(pageSize);
		page.setCustomizedHql(baseHql.toString());
		Page<CostGroup> resultPage = groupDao.selectByPage(page, CostGroup.class);
		return resultPage;
	}
	
	public void save(CostGroup group, List<GroupMember> selectedMembers){
		Serializable groupId = groupDao.save(group);
		for (GroupMember groupMember : selectedMembers) {
			groupMember.setGroup_id((Long) groupId);
			memberDao.save(groupMember);
		}
	}
	
	public void update(CostGroup group, List<GroupMember> selectedMembers){
		CostGroup foundgroup = groupDao.getById(CostGroup.class, group.getId());
		if(selectedMembers != null && selectedMembers.size() > 0){
			List<GroupMember> foundMember = memberDao.findByGroupId(foundgroup.getId());
			for (GroupMember groupMember : foundMember) {
				memberDao.delete(groupMember);
			}
			
			for (GroupMember groupMember : selectedMembers) {
				groupMember.setGroup_id(foundgroup.getId());
				memberDao.save(groupMember);
			}
			foundgroup.setGroupName(group.getGroupName());
			foundgroup.setMark(group.getMark());
		}
		groupDao.update(foundgroup);
	}
	
	public void delete(CostGroup group){
		List<GroupMember> foundMember = memberDao.findByGroupId(group.getId());
		for (GroupMember groupMember : foundMember) {
			memberDao.delete(groupMember);
		}
		groupDao.delete(group);
	}
	
	public List<CostGroup> findByUserId(String userId){
		return groupDao.findByUserId(userId);
	}
}
