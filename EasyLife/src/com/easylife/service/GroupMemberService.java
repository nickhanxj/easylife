package com.easylife.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.easylife.dao.MemberDao;
import com.easylife.domain.GroupMember;

@Service
@Transactional
public class GroupMemberService {
	@Resource
	private MemberDao memberDao;
	
	public List<GroupMember> findByGroupId(Long groupId){
		return memberDao.findByGroupId(groupId);
	}
}
