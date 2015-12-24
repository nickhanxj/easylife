package com.easylife.service;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
		groupDao.save(group);
	}
	
	public void update(CostGroup group, List<GroupMember> selectedMembers){
		CostGroup foundgroup = groupDao.getById(CostGroup.class, group.getId());
		String hql = "delete from GroupMember gm where gm.group.id = "+group.getId();
		memberDao.excuteHqlQuery(hql);
		
		for (GroupMember groupMember : selectedMembers) {
			groupMember.setGroup(foundgroup);
			memberDao.save(groupMember);
		}
		foundgroup.setGroupName(group.getGroupName());
		foundgroup.setMark(group.getMark());
		groupDao.update(foundgroup);
	}
	
	public void delete(CostGroup group){
		groupDao.delete(group);
	}
}
