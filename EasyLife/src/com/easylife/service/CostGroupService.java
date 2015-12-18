package com.easylife.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.easylife.dao.CostGroupDao;
import com.easylife.domain.CostGroup;
import com.easylife.util.Page;

@Service
@Transactional
public class CostGroupService {
	@Resource
	private CostGroupDao groupDao;
	
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
	
	public void save(CostGroup group){
		groupDao.save(group);
	}
	
	public void update(CostGroup group){
		groupDao.update(group);
	}
}
