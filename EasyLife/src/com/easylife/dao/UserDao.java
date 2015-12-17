package com.easylife.dao;

import java.util.Iterator;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.easylife.base.BaseDao;
import com.easylife.domain.User;

@Repository
@SuppressWarnings("all")
public class UserDao extends BaseDao<User>{
	private static final long serialVersionUID = 1L;

	public void addUser(User user) {
		getSession().save(user);
	}

	public void updateUser(User user) {
		getSession().update(user);
	}
	
	public User getByName(String userName){
		String hql = "from User u where u.userName = '"+userName+"'";
		List list = getSession().createQuery(hql).list();
		if(list.size() > 0){
			return (User) list.get(0);
		}
		return null;
	}
	
	public User getByTrueName(String trueName){
		String hql = "from User u where u.trueName = '"+trueName+"'";
		List list = getSession().createQuery(hql).list();
		if(list.size() > 0){
			return (User) list.get(0);
		}
		return null;
	}
	
	public boolean trueNameHasExist(String trueName){
		String hql = "from User u where u.trueName = '"+trueName+"'";
		List list = getSession().createQuery(hql).list();
		if(list.size() > 0){
			return true;
		}
		return false;
	}
	
	public boolean validateBaseInfo(String email, String phone, String trueName){
		StringBuffer hql = new StringBuffer("from User u where u.email= '"+email+"' and ");
		if(StringUtils.isBlank(phone) && StringUtils.isBlank(trueName)){
			return false;
		}else{
			hql.append(" (u.phoneNumber = '"+phone+"' or u.trueName = '"+trueName+"')");
		} 
		User user = (User) getSession().createQuery(hql.toString()).uniqueResult();
		if(user == null){
			return false;
		}
		return true;
	}
	
	public User getUserByEmail(String email){
		String hql = "from User u where u.email = '"+email+"'";
		User user = (User) getSession().createQuery(hql).uniqueResult();
		return user;
	}
	
	

	public User getUserByCondition(User user) {
		String password = user.getPassword();
		String userName = user.getUserName();
		String hql = "from User u where (u.email = ? or u.userName = ?) and u.password = ?";
		return (User) getSession().createQuery(hql)
				.setParameter(0, userName)
				.setParameter(1, userName)
				.setParameter(2, password)
				.uniqueResult();
	}

	public User selectUserById(String id) {
		String hql = "from User u where u.id = " + id;
		Query query = getSession().createQuery(hql);
		List list = query.list();
		if (list != null && list.size() > 0) {
			return (User) list.get(0);
		}
		return null;
	}
}
