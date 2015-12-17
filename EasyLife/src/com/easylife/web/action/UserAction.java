package com.easylife.web.action;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.struts2.ServletActionContext;

import com.easylife.base.BaseAction;
import com.easylife.domain.User;
import com.easylife.service.UserService;
import com.opensymphony.xwork2.ActionContext;

public class UserAction extends BaseAction {
	private static final long serialVersionUID = 1L;
	@Resource
	private UserService userService;
	private User user;

	public String list() {
		return "list";
	}

	public String listData() {
		List<User> users = userService.getAllUsers();
		putJson(users);
		return JSON;
	}

	public String login() {
		user.setPassword(DigestUtils.md5Hex(user.getPassword()));
		User authUser = userService.authUser(user);
		if (authUser == null) {
			putJson("用户名或密码错误！");
			return JSON;
		}
		ActionContext.getContext().getSession().put("authUser", authUser);
		// 更新用户信息
		authUser.setLastLoginDate(authUser.getCurLoginDate());
		authUser.setCurLoginDate(new Date());
		authUser.setLastLoginIp(authUser.getCurLoginIp());
		HttpServletRequest request = ServletActionContext.getRequest();
		authUser.setCurLoginIp(request.getRemoteAddr());
		userService.updateUser(authUser);
		putJson("SUCCESS");
		return JSON;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}
