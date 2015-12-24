package com.easylife.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.easylife.base.BaseDao;
import com.easylife.domain.GroupMember;

@Repository
public class MemberDao extends BaseDao<GroupMember>{
	public List<GroupMember> findByGroupId(Long groupId){
		return getSession().createQuery("from GroupMember gm where gm.group.id = "+groupId).list();
	}
}
