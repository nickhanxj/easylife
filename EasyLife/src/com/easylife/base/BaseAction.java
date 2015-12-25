package com.easylife.base;

import java.text.SimpleDateFormat;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;

import com.easylife.domain.SystemLog;
import com.easylife.domain.User;
import com.easylife.service.SystemLogService;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class BaseAction extends ActionSupport {
	private static final long serialVersionUID = 1L;

	public static final String REGISTER = "register";
	public static final String LIST = "list";
	public static final String DETAIL = "detail";
	public static final String JSON = "json";
	public static final String JSONDATA = "jsonData";

	public static final String STATUS = "status";
	public static final String STATUS_SUCCESS = "1";
	public static final String STATUS_ERROR = "2";
	public static final String MESSAGE = "message";
	protected SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy年MM月dd日");
	@Resource
	protected SystemLogService logService;
	
	protected void addLog(String user, String operation, String operationResult, String causation){
		String ip = ServletActionContext.getRequest().getRemoteAddr();
		SystemLog log = new SystemLog();
		log.setOperation(operation);
		log.setOperationResult(operationResult);
		log.setUser(user);
		log.setOperationIp(ip);
		if(StringUtils.isNotBlank(causation)){
			log.setCausation(causation);
		}
		logService.addLog(log);
	}

	protected User getSessionUser() {
		User currentUser = (User) ActionContext.getContext().getSession()
				.get("authUser");
		return currentUser;
	}

	protected void putContext(String key, Object value) {
		ActionContext.getContext().put(key, value);
	}

	protected void putJson(Object value) {
		ActionContext.getContext().put(JSONDATA, value);
	}

}
