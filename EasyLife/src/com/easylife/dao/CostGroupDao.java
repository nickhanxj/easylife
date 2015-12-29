package com.easylife.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.easylife.base.BaseDao;
import com.easylife.domain.CostGroup;

@Repository
public class CostGroupDao extends BaseDao<CostGroup>{
	public List<CostGroup> findByUserId(String userId){
		String hql = "from CostGroup cg where cg.signUser like '%-"+userId+"-%'";
		return getSession().createQuery(hql).list();
	}
}
