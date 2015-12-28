package com.easylife.web.interceptor;

import java.util.Arrays;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.easylife.base.BaseAction;
import com.easylife.domain.User;
import com.easylife.util.LoggerManager;
import com.easylife.web.action.CostRecordAction;
import com.easylife.web.action.UserAction;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

/**
 * 权限拦截器
 * 
 * @author john
 * 
 */
@SuppressWarnings("all")
public class AuthInterceptor extends AbstractInterceptor {
	private static final long serialVersionUID = 1L;
	private String authUser = "authUser";

	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		Action action = (Action) invocation.getAction();
		String method = invocation.getProxy().getMethod();
		// 如果是com.demo.ssh.action.UnAuthedResourceAction则直接放行：公共访问区域
		Map<String, Object> session = invocation.getInvocationContext().getSession();
		if (action instanceof UserAction) {
			return invocation.invoke();
		}
		User user = (User) session.get(authUser);
		if(user == null){
			return "login";
		}
		if(action instanceof CostRecordAction && "statisticsForEmail".endsWith(method)){
			return invocation.invoke();
		}
		return invocation.invoke();
	}

}
