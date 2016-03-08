package com.easylife.quartz;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;

import com.easylife.domain.CostRecord;
import com.easylife.domain.SystemLog;
import com.easylife.service.CostRecordService;
import com.easylife.service.SystemLogService;
import com.easylife.util.LoggerManager;

/**
 * 定时任务：每晚00:30执行--检测前一天是否有消费记录，若没有，则往数据库添加一条消费为0的记录（只有消费金额与消费时间），用于消费走势图做统计
 * @author john
 *
 */
public class CheckPreDayCostQuartz {
	@Resource
	private CostRecordService recordService;
	@Resource
	SystemLogService logService;
	public void checkCost(){
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
		Date dateBefore = getPreDay(new Date());
		boolean recordDayBeforeExist = recordService.hasPreDayRecord(dateFormat.format(dateBefore));
		if(!recordDayBeforeExist){
			CostRecord costRecord = new CostRecord();
			costRecord.setCostdate(dateBefore);
			costRecord.setCost(0f);
			costRecord.setStatus(null);
			costRecord.setDeleted(null);
			costRecord.setMark("当日无消费记录，此记录为系统自动生成，供消费走势图做统计使用。");
			recordService.addRecord(costRecord);
			LoggerManager.info("经检测，[ "+dateFormat.format(dateBefore)+"] 无消费记录，系统已自动生成一条记录供消费走势图做统计使用。");
			addLog("系统", "新增消费记录", "成功", "当日无任何消费记录，系统新增一条做统计图");
		}
	}
	
	private Date getPreDay(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.DAY_OF_MONTH, -1);
		date = calendar.getTime();
		return date;
	}
	
	private void addLog(String user, String operation, String operationResult, String causation){
		SystemLog log = new SystemLog();
		log.setOperation(operation);
		log.setOperationResult(operationResult);
		log.setUser(user);
		log.setOperationIp("服务器");
		if(StringUtils.isNotBlank(causation)){
			log.setCausation(causation);
		}
		logService.addLog(log);
	}
}
