package com.easylife.domain.dto;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * 消费组
 * 
 * @author xiaojun
 * 
 */
@Entity
@Table(name = "costgroup")
public class CostGroupDto {
	private Long id;
	private String groupName;
	private String mark;
	private String createTime;
	private String members;
	private String authUser;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getMembers() {
		return members;
	}

	public void setMembers(String members) {
		this.members = members;
	}

	public String getAuthUser() {
		return authUser;
	}

	public void setAuthUser(String authUser) {
		this.authUser = authUser;
	}

}
