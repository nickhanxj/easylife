package com.easylife.web.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.easylife.base.BaseAction;
import com.easylife.domain.CostGroup;
import com.easylife.domain.dto.CostGroupDto;
import com.easylife.service.CostGroupService;
import com.easylife.util.Page;

public class CostGroupAction extends BaseAction {
	private static final long serialVersionUID = 1L;
	@Resource
	private CostGroupService groupService;
	private CostGroup group;
	private String members;
	private int page;
	private int rows;

	public String groupList() {
		return "groupList";
	}

	public String listData() {
		Page<CostGroup> all = groupService.selectPage(page, rows,null);
		List<CostGroupDto> records = new ArrayList<CostGroupDto>();
		for (CostGroup group : all.getRows()) {
			CostGroupDto groupDto = new CostGroupDto();
			groupDto.setCreateTime(dateFormat.format(group.getCreateTime()));
			groupDto.setGroupName(group.getGroupName());
			groupDto.setId(group.getId());
			groupDto.setMark(group.getMark());
			groupDto.setMembers("11");
			records.add(groupDto);
		}
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("total", all.getTotalRow());
		data.put("rows", records);
		putJson(data);
		return JSON;
	}
	
	public String add(){
		try {
			groupService.save(group);
			putJson(1);
		} catch (Exception e) {
			putJson(0);
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

}
