package com.easylife.service;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.easylife.dao.SystemLogDao;
import com.easylife.domain.SystemLog;
import com.easylife.util.Page;

@Service
@Transactional
public class SystemLogService {
	@Resource
	private SystemLogDao logDao;
	
	public void addLog(SystemLog log){
		logDao.save(log);
	}
	
	public Page<SystemLog> getLogs(int currentPage, int pageSize, Map<String, String> params){
		String operation = "";
		if(StringUtils.isNotBlank(params.get("operation"))){
			operation = " where sl.operation like '%"+params.get("operation")+"%'";
		}
		StringBuffer baseHql = new StringBuffer("from SystemLog sl "+operation+" order by sl.operationDate desc");
		Page<SystemLog> page = new Page<SystemLog>();
		page.setCurrentPage(currentPage);
		page.setPageSize(pageSize);
		page.setCustomizedHql(baseHql.toString());
		return logDao.selectByPage(page, SystemLog.class);
	}
}
