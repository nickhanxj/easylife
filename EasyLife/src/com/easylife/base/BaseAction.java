package com.easylife.base;

import java.text.SimpleDateFormat;

import com.easylife.domain.User;
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
