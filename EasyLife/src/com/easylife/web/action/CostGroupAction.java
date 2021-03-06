package com.easylife.web.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;

import com.easylife.base.BaseAction;
import com.easylife.domain.CostGroup;
import com.easylife.domain.GroupMember;
import com.easylife.domain.User;
import com.easylife.domain.dto.CostGroupDto;
import com.easylife.service.CostGroupService;
import com.easylife.service.GroupMemberService;
import com.easylife.service.UserService;
import com.easylife.util.Page;

public class CostGroupAction extends BaseAction {
	private static final long serialVersionUID = 1L;
	@Resource
	private CostGroupService groupService;
	@Resource
	private GroupMemberService memberService;
	@Resource
	private UserService userService;
	private CostGroup group;
	private String members;
	private String ids;
	private int page;
	private int rows;
	private String[] checkMember;
	private String signUsers;

	public String groupList() {
		return "groupList";
	}

	public String listData() {
		Page<CostGroup> all = groupService.selectPage(page, rows, null);
		List<CostGroupDto> records = new ArrayList<CostGroupDto>();
		for (CostGroup group : all.getRows()) {
			CostGroupDto groupDto = new CostGroupDto();
			groupDto.setCreateTime(dateFormat.format(group.getCreateTime()));
			groupDto.setGroupName(group.getGroupName());
			groupDto.setId(group.getId());
			groupDto.setMark(group.getMark());
			List<GroupMember> members = memberService.findByGroupId(group
					.getId());
			StringBuffer memberStr = new StringBuffer("");
			for (GroupMember groupMember : members) {
				memberStr.append(groupMember.getMemberName() + " ");
			}
			groupDto.setMembers(memberStr.toString());
			String signUser = group.getSignUser();
			if(StringUtils.isNotBlank(signUser)){
				String[] sUsers = signUser.split("-");
				StringBuffer authUserStr = new StringBuffer("");
				for (String id : sUsers) {
					if(StringUtils.isNotBlank(id)){
						User user = userService.getUserByid(id);
						authUserStr.append(user.getUserName()+" ");
					}
				}
				groupDto.setAuthUser(authUserStr.toString());
			}
			records.add(groupDto);
		}
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("total", all.getTotalRow());
		data.put("rows", records);
		putJson(data);
		return JSON;
	}
	
	public String getAuthUser(){
		CostGroup cGroup = groupService.getById(group.getId());
		String signUser = cGroup.getSignUser();
		List<User> authedUser = new ArrayList<User>();
		if(StringUtils.isNotBlank(signUser)){
			String[] sUsers = signUser.split("-");
			for (String id : sUsers) {
				if(StringUtils.isNotBlank(id)){
					authedUser.add(userService.getUserByid(id));
				}
			}
		}
		List<User> allUsers = userService.getAllUsers();
		allUsers.removeAll(authedUser);
		Map<String, List<User>> data = new HashMap<String, List<User>>();
		data.put("allUsers", allUsers);
		data.put("authedUsers", authedUser);
		putJson(data);
		return JSON;
	}

	public String add() {
		try {
			List<GroupMember> selectedMembers = new ArrayList<GroupMember>();
			if (StringUtils.isNotBlank(members)) {
				String[] gMembers = members.split(",");
				for (String member : gMembers) {
					GroupMember groupMember = new GroupMember();
					groupMember.setMemberName(member);
					selectedMembers.add(groupMember);
				}
			}
			groupService.save(group, selectedMembers);
			putJson(1);
		} catch (Exception e) {
			putJson(0);
		}
		return JSON;
	}

	public String signUser() {
		CostGroup foundGroup = groupService.getById(group.getId());
		foundGroup.setSignUser(signUsers);
		try {
			groupService.update(foundGroup, null);
			putJson(1);
		} catch (Exception e) {
			putJson(0);
		}
		return JSON;
	}

	public String update() {
		try {
			List<GroupMember> selectedMembers = new ArrayList<GroupMember>();
			if (StringUtils.isNotBlank(members)) {
				String[] gMembers = members.split(",");
				for (String member : gMembers) {
					GroupMember groupMember = new GroupMember();
					groupMember.setMemberName(member);
					selectedMembers.add(groupMember);
				}
			}
			if (checkMember != null && checkMember.length > 0) {
				for (String checkd : checkMember) {
					GroupMember groupMember = new GroupMember();
					groupMember.setMemberName(checkd);
					selectedMembers.add(groupMember);
				}
			}
			groupService.update(group, selectedMembers);
			putJson(1);
		} catch (Exception e) {
			e.printStackTrace();
			putJson(0);
		}
		return JSON;
	}

	public String deleteGroup() {
		try {
			String[] sid = ids.split(",");
			for (String id : sid) {
				CostGroup group = new CostGroup();
				group.setId(Long.valueOf(id));
				groupService.delete(group);
			}
			putJson("删除成功！");
		} catch (Exception e) {
			e.printStackTrace();
			putJson("删除失败！");
		}
		return JSON;
	}

	public CostGroup getGroup() {
		return group;
	}

	public void setGroup(CostGroup group) {
		this.group = group;
	}

	public String getMembers() {
		return members;
	}

	public void setMembers(String members) {
		this.members = members;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public String[] getCheckMember() {
		return checkMember;
	}

	public void setCheckMember(String[] checkMember) {
		this.checkMember = checkMember;
	}

	public String getSignUsers() {
		return signUsers;
	}

	public void setSignUsers(String signUsers) {
		this.signUsers = signUsers;
	}

}
