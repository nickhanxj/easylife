package com.easylife.web.action;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;

import com.easylife.base.BaseAction;
import com.easylife.domain.CostGroup;
import com.easylife.domain.CostRecord;
import com.easylife.domain.GroupMember;
import com.easylife.domain.dto.CostRecordDto;
import com.easylife.service.CostGroupService;
import com.easylife.service.CostRecordService;
import com.easylife.service.GroupMemberService;
import com.easylife.service.UserService;
import com.easylife.util.Page;
import com.opensymphony.xwork2.ActionContext;

@SuppressWarnings("all")
public class CostRecordAction extends BaseAction {
	private static final long serialVersionUID = 1L;
	private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	@Resource
	private CostRecordService recordService;
	@Resource
	private UserService userService;
	@Resource
	private GroupMemberService memberService;
	@Resource
	private CostGroupService groupService;
	private CostRecord record;
	private String year;
	private String month;
	private String startTime;
	private String endTime;
	private String userName;
	private String costFor;
	private String fileName;
	private File file;
	private Long recordId;
	private int page;
	private int rows;
	private String groupId;
	private String ids;

	// 记录列表
	public String list() {
		List<CostGroup> groups = groupService.findAll();
		putContext("groups", groups);
		List<GroupMember> members = memberService.findByGroupId(groups.get(0).getId());
		putContext("members", members);
		return "list";
	}

	public String listData() {
		Map<String, String> params = new HashMap<String, String>();
		if (StringUtils.isNotBlank(startTime)) {
			params.put("startTime", startTime);
		}
		if (StringUtils.isNotBlank(endTime)) {
			params.put("endTime", endTime);
		}
		if (StringUtils.isNotBlank(userName)) {
			params.put("user", userName);
		}
		if (StringUtils.isNotBlank(costFor)) {
			params.put("costFor", costFor);
		}
		params.put("groupId", groupId+"");
		Page<CostRecord> all = recordService.selectListByPage(page, rows,
				params);
		List<CostRecordDto> records = new ArrayList<CostRecordDto>();
		for (CostRecord record : all.getRows()) {
			CostRecordDto recordDto = new CostRecordDto();
			recordDto.setId(record.getId());
			recordDto.setCost(record.getCost());
			recordDto.setCostdate(dateFormat.format(record.getCostdate()));
			recordDto.setCostFor(record.getCostFor());
			recordDto.setMark(record.getMark());
			if(record.getStatus() == 0){
				recordDto.setStatus("<font color='red'>未结</font>");
			}else if(record.getStatus() == 1){
				recordDto.setStatus("<font color='green'>已结</font>");
			}
			recordDto.setUser(record.getUser());
			if (StringUtils.isNotBlank(record.getAttachment())) {
				String attachment = record.getAttachment();
				String img = "<img src='"
						+ attachment
						+ "' width='25px' style='cursor:pointer;' onclick='showImg(this)'>";
				recordDto.setAttachment(img);
			}
			records.add(recordDto);
		}
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("total", all.getTotalRow());
		data.put("rows", records);
		putJson(data);
		return JSON;
	}
	
	public String getGroupMember(){
		List<GroupMember> members = memberService.findByGroupId(Long.valueOf(groupId));
		List<Map<String, Object>> rtList = new ArrayList<Map<String,Object>>();
		Map<String, Object> m1 = new HashMap<String, Object>();
		m1.put("id", 0);
		m1.put("text", "--请选择--");
		rtList.add(m1);
		putJson(rtList);
		for (GroupMember groupMember : members) {
			Map<String, Object> m = new HashMap<String, Object>();
			m.put("id", groupMember.getId());
			m.put("text", groupMember.getMemberName());
			rtList.add(m);
		}
		return JSON;
	}

	// 附件上传
	public String uploadPhoto() {
		Map<String, Object> rMap = new HashMap<String, Object>();
		String targetFolder = ServletActionContext.getServletContext()
				.getRealPath("/upload/costrecord");
		File destFile = new File(targetFolder, UUID.randomUUID().toString()
				+ getExtention(fileName));
		System.out.println("targetFolder: " + targetFolder);
		try {
			FileUtils.copyFile(file, destFile);
			rMap.put(STATUS, STATUS_SUCCESS);
			String imgUrl = "upload/costrecord/" + destFile.getName();
			rMap.put("url", imgUrl);
			ActionContext.getContext().put(MESSAGE, fileName + "--" + file);
		} catch (Exception e) {
			e.printStackTrace();
			rMap.put(STATUS, STATUS_ERROR);
			rMap.put("url", null);
			ActionContext.getContext().put(MESSAGE, "upload failed!");
		}
		putContext(JSONDATA, rMap);
		return JSON;
	}

	private static String getExtention(String fileName) {
		return ".png";
		// int pos = fileName.lastIndexOf(".");
		// return fileName.substring(pos);
	}

	// 逻辑删除
	public String delete() {
		Map<String, Object> rMap = new HashMap<String, Object>();
		String[] idForDelete = ids.split(",");
		try {
			for (String id : idForDelete) {
				CostRecord costRecord = recordService.getById(Long.valueOf(id));
				costRecord.setDeleted(1);
				recordService.updateRecord(costRecord);
				addLog(getSessionUser().getUserName(),"删除：【"+costRecord.getUser()+"在"+dateFormat.format(costRecord.getCostdate())+"的"+costRecord.getCost()+"元的消费】","成功",null);
			}
			rMap.put(STATUS, STATUS_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			rMap.put(STATUS, STATUS_ERROR);
		}
		putContext(JSONDATA, rMap);
		return JSON;
	}

	// 结账
	public String checkout() {
		Map<String, Object> rMap = new HashMap<String, Object>();
		try {
			String[] idForDelete = ids.split(",");
			for (String id : idForDelete) {
				CostRecord costRecord = recordService.getById(Long.valueOf(id));
				costRecord.setStatus(1);
				recordService.updateRecord(costRecord);
				addLog(getSessionUser().getUserName(),"结账：【"+costRecord.getUser()+"在"+dateFormat.format(costRecord.getCostdate())+"的"+costRecord.getCost()+"元的消费】","成功",null);
			}
			rMap.put(STATUS, STATUS_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			rMap.put(STATUS, STATUS_ERROR);
		}
		putContext(JSONDATA, rMap);
		return JSON;
	}

	// 到新增页面
	public String addRecord() {
		return "add";
	}

	// 到编辑页面
	public String editRecord() {
		CostRecord costRecord = recordService.getById(recordId);
		putContext("record", costRecord);
		return "edit";
	}
	
	// 统计信息
	public String statisticsTable() {
		List<CostGroup> groups = groupService.findAll();
		if(StringUtils.isBlank(year) && StringUtils.isBlank(month)){
			Calendar calendar = Calendar.getInstance();
			year = String.valueOf(calendar.get(Calendar.YEAR));
			month = String.valueOf(calendar.get(Calendar.MONTH)+1);
		}
		if(StringUtils.isBlank(groupId)){
			groupId = groups.get(0).getId()+"";
		}
		putContext("groups", groups);
		Map<String, Object> monthTotal = recordService.monthTotal(year, month, groupId);
		putContext("monthTotal", monthTotal);
		List<Map<String, Object>> rList = new ArrayList<Map<String, Object>>();
		//获取组内成员
		if(StringUtils.isNotBlank(groupId)){
			List<GroupMember> members = memberService.findByGroupId(Long.valueOf(groupId));
			for (GroupMember groupMember : members) {
				Map<String, Object> rMap = new HashMap<String, Object>();
				Map<String, Object> statisticResult = recordService.statisticPerson(year, month, groupMember.getMemberName());
				rMap.put("user", groupMember.getMemberName());
				rMap.put("statisticResult", statisticResult);
				rList.add(rMap);
			}
		}
		putContext("cyear", year);
		putContext("cmonth", month);
		putContext("result", rList);
		putContext("count", rList.size());
		putContext("groups", groups);
		putContext("groupId", groupId);
		return "statistics";
	}

	// 统计信息
	public String statistics() {
		Map<String, Object> monthTotal = recordService.monthTotal(year, month, groupId);
		putContext("monthTotal", monthTotal);
		List<Map<String, Object>> rList = new ArrayList<Map<String, Object>>();
		for (int i = 1; i <= 3; i++) {
			Map<String, Object> rMap = new HashMap<String, Object>();
			Map<String, Object> statisticResult = recordService
					.statisticPerson(year, month, i + "");
			String username = "";
			if (i == 1) {
				username = "韩晓军";
			} else if (i == 2) {
				username = "胡丰盛";
			} else if (i == 3) {
				username = "李洪亮";
			}
			rMap.put("user", username);
			rMap.put("statisticResult", statisticResult);
			rList.add(rMap);
		}
		putContext("cyear", year);
		putContext("cmonth", month);
		putContext("result", rList);
		return "statistics";
	}
	
	
	//首页饼状图
	public String statisticDataForPie(){
		Calendar calendar = Calendar.getInstance();
		year = String.valueOf(calendar.get(Calendar.YEAR));
		month = String.valueOf(calendar.get(Calendar.MONTH)+1);
		List<Map<String, Object>> staticTotalCostByPersonAndMonth = recordService.staticTotalCostByPersonAndMonth(year, month);
		List rtList = new ArrayList();
		for (Map<String, Object> map : staticTotalCostByPersonAndMonth) {
			if(map.get("user") != null){
				List tempList = new ArrayList();
				tempList.add(map.get("user"));
				tempList.add(map.get("totalCost"));
				rtList.add(tempList);
			}
		}
		putJson(rtList);
		return JSON;
	}
	
	//首页折线图
	public String statisticDataForLine(){
		Calendar calendar = Calendar.getInstance();
		year = String.valueOf(calendar.get(Calendar.YEAR));
		month = String.valueOf(calendar.get(Calendar.MONTH)+1);
		List<Map<String, Object>> staticTotalCostByPersonAndMonth = recordService.staticCostByDayAndMonth(year, month);
		Map<String,List> rtMap = new HashMap<String, List>();
		List categories = new ArrayList();
		List categoriesData = new ArrayList();
		for (Map<String, Object> map : staticTotalCostByPersonAndMonth) {
			if(map.get("costdate") != null){
				List tempList = new ArrayList();
				categories.add(map.get("costdate")+"日");
				categoriesData.add(map.get("dailyCost"));
			}
		}
		rtMap.put("categories", categories);
		List categoriesDataList = new ArrayList();
		Map<String,Object> categoriesDataMap = new HashMap<String, Object>();
		categoriesDataMap.put("name", "每日消费");
		categoriesDataMap.put("data", categoriesData);
		categoriesDataList.add(categoriesDataMap);
		rtMap.put("categoriesData", categoriesDataList);
		putJson(rtMap);
		return JSON;
	}
	
	//首页柱状图
	public String statisticDataForColumn(){
		Calendar calendar = Calendar.getInstance();
		year = String.valueOf(calendar.get(Calendar.YEAR));
		List rtList = new ArrayList();
		List<GroupMember> all = memberService.findAll();
		Set<String> members = new HashSet();
		for (GroupMember groupMember : all) {
			members.add(groupMember.getMemberName());
		}
		for (String membername : members) {
			Map datamap = new HashMap();
			datamap.put("name", membername);
			List data = new ArrayList();
			List<Map<String,Object>> byMonth = recordService.staticCostByMonth(year, membername);
			for (Map<String, Object> map : byMonth) {
				data.add(map.get("totalCost"));
			}
			datamap.put("data", data);
			rtList.add(datamap);
		}
		putJson(rtList);
		return JSON;
	}

	// 统计信息
	public String statisticsForEmail() {
		Map<String, Object> monthTotal = recordService.monthTotal(year, month, groupId);
		putContext("monthTotal", monthTotal);
		List<Map<String, Object>> rList = new ArrayList<Map<String, Object>>();
		for (int i = 1; i <= 3; i++) {
			Map<String, Object> rMap = new HashMap<String, Object>();
			Map<String, Object> statisticResult = recordService
					.statisticPerson(year, month, i + "");
			String username = "";
			if (i == 1) {
				username = "韩晓军";
			} else if (i == 2) {
				username = "胡丰盛";
			} else if (i == 3) {
				username = "李洪亮";
			}
			rMap.put("user", username);
			rMap.put("statisticResult", statisticResult);
			rList.add(rMap);
		}
		putContext("cyear", year);
		putContext("cmonth", month);
		putContext("result", rList);
		return "statisticsForEmail";
	}

	// 图形报表
	public String graphic() {
		List<Map<String, Object>> rList = new ArrayList<Map<String, Object>>();
		List<GroupMember> members = memberService.findByGroupId(Long.valueOf(groupId));
		for (GroupMember groupMember : members) {
			Map<String, Object> rMap = new HashMap<String, Object>();
			Object[] data = new Object[12];
			for (int j = 1; j <= 12; j++) {
				Map<String, Object> statisticResult = recordService
						.dailyCosyByPerson(year, j + "", groupMember.getMemberName());
				Map<String, Object> costTotal = (Map<String, Object>) statisticResult
						.get("costTotal");
				Object total = costTotal.get("csum");
				if (total == null) {
					total = 0;
				}
				data[j - 1] = total;
			}
			rMap.put("data", data);
			rMap.put("name", groupMember.getMemberName());
			rList.add(rMap);
			
		}
		putJson(rList);
		return JSON;
	}

	// 时间轴统计图数据
	public String timing() {
		ArrayList day = recordService.statisticCostByDay(year, month);
		putJson(day);
		return JSON;
	}

	// 新增
	public String add() {
		// 保存
		try {
			CostGroup group = new CostGroup();
			group.setId(Long.valueOf(groupId));
			record.setCostGroup(group);
			recordService.addRecord(record);
			putJson(1);
		} catch (Exception e) {
			putJson(0);
		}
		return JSON;
	}

	// 编辑
	public String update() {
		recordService.updateRecord(record);
		return "redirectList";
	}

	// 时间走势图
	public String timeChart() {
		return "timeChart";
	}

	// 个人消费图
	public String personalCostChart() {
		//获取所有的消费组
		List<CostGroup> allGroups = groupService.findAll();
		putContext("groups", allGroups);
		if(allGroups.size() > 0){
			putContext("groupId", allGroups.get(0).getId());
		}
		return "personalCostChart";
	}

	public CostRecord getRecord() {
		return record;
	}

	public void setRecord(CostRecord record) {
		this.record = record;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getCostFor() {
		return costFor;
	}

	public void setCostFor(String costFor) {
		this.costFor = costFor;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public Long getRecordId() {
		return recordId;
	}

	public void setRecordId(Long recordId) {
		this.recordId = recordId;
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

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

}
