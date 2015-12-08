package com.easylife.web.action;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;

import com.easylife.base.BaseAction;
import com.easylife.domain.CostRecord;
import com.easylife.service.CostRecordService;
import com.easylife.util.Page;
import com.opensymphony.xwork2.ActionContext;

@SuppressWarnings("all")
public class CostRecordAction extends BaseAction {
	private static final long serialVersionUID = 1L;
	@Resource
	private CostRecordService recordService;
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
	private Integer pageSize = 100;
	private Integer currentPage = 1;

	// 记录列表
	public String list() {
		return "list";
	}
	
	public String listData(){
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
		Page<CostRecord> all = recordService.selectListByPage(currentPage, pageSize, params);
		for (CostRecord record : all.getRows()) {
			if(StringUtils.isNotBlank(record.getAttachment())){
				String attachment = record.getAttachment();
				String img = "'<img src='"+attachment.substring(1, attachment.length())+"' width='25px' style='cursor:pointer;'>'";
				record.setAttachment(img);
			}
		}
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("total", all.getTotalRow());
		data.put("rows", all.getRows());
		putJson(data);
		return JSON;
	}

	// 附件上传
	public String uploadPhoto() {
		Map<String, Object> rMap = new HashMap<String, Object>();
		String targetFolder = ServletActionContext.getServletContext()
				.getRealPath("/upload/costrecord");
		File destFile = new File(targetFolder, UUID.randomUUID().toString()
				+ getExtention(fileName));
		System.out.println("targetFolder: "+targetFolder);
		try {
			FileUtils.copyFile(file, destFile);
			rMap.put(STATUS, STATUS_SUCCESS);
			String imgUrl = "/upload/costrecord/" + destFile.getName();
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
		CostRecord costRecord = recordService.getById(recordId);
		costRecord.setDeleted(1);
		try {
			recordService.updateRecord(costRecord);
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
		CostRecord costRecord = recordService.getById(recordId);
		costRecord.setStatus(1);
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			recordService.updateRecord(costRecord);
			rMap.put(STATUS, STATUS_SUCCESS);
			String userName = "";
			if ("1".equals(costRecord.getUser())) {
				userName = "韩晓军";
			} else if ("2".equals(costRecord.getUser())) {
				userName = "胡丰盛";
			} else if ("3".equals(costRecord.getUser())) {
				userName = "李洪亮";
			}
			String msg = "【" + userName + "】发生于["
					+ dateFormat.format(costRecord.getCostdate()) + "]的消费为 "
					+ costRecord.getCost() + " 元的消费记录已结帐！";
			rMap.put("msg", msg);
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
	public String statistics() {
		Map<String, Object> monthTotal = recordService.monthTotal(year, month);
		putContext("monthTotal", monthTotal);
		List<Map<String, Object>> rList = new ArrayList<Map<String, Object>>();
		for (int i = 1; i <= 3; i++) {
			Map<String, Object> rMap = new HashMap<String, Object>();
			Map<String, Object> statisticResult = recordService.statisticPerson(year, month, i + "");
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
	
	// 统计信息
	public String statisticsForEmail() {
		Map<String, Object> monthTotal = recordService.monthTotal(year, month);
		putContext("monthTotal", monthTotal);
		List<Map<String, Object>> rList = new ArrayList<Map<String, Object>>();
		for (int i = 1; i <= 3; i++) {
			Map<String, Object> rMap = new HashMap<String, Object>();
			Map<String, Object> statisticResult = recordService.statisticPerson(year, month, i + "");
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
		for (int i = 1; i <= 3; i++) {
			Map<String, Object> rMap = new HashMap<String, Object>();
			String username = "";
			if (i == 1) {
				username = "韩晓军";
			} else if (i == 2) {
				username = "胡丰盛";
			} else if (i == 3) {
				username = "李洪亮";
			}
			Object[] data = new Object[12];
			for(int j = 1; j <= 12; j++){
				Map<String, Object> statisticResult = recordService.dailyCosyByPerson(year, j+"", i + "");
				Map<String, Object> costTotal = (Map<String, Object>) statisticResult.get("costTotal");
				Object total = costTotal.get("csum");
				if(total == null){
					total = 0;
				}
				data[j-1] = total;
			}
			rMap.put("data", data);
			rMap.put("name", username);
			rList.add(rMap);
		}
		putJson(rList);
		return JSON;
	}
	
	//时间轴统计图数据
	public String timing(){
		ArrayList day = recordService.statisticCostByDay(year, month);
		putJson(day);
		return JSON;
	}

	// 新增
	public String add() {
		// 保存
		recordService.addRecord(record);
		return "redirectList";
	}

	// 编辑
	public String update() {
		recordService.updateRecord(record);
		return "redirectList";
	}
	
	//时间走势图
	public String timeChart(){
		return "timeChart";
	}
	
	//个人消费图
	public String perPersonCostChart(){
		return "perPersonCostChart";
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

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public Integer getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}

}
