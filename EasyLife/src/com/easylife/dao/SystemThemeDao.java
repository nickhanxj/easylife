package com.easylife.dao;

import org.springframework.stereotype.Repository;

import com.easylife.base.BaseDao;
import com.easylife.domain.SystemTheme;

@Repository
public class SystemThemeDao extends BaseDao<SystemTheme>{
	public SystemTheme findByUserId(Long userId){
		String hql = "from SystemTheme st where st.userId = "+userId;
		return (SystemTheme) getSession().createQuery(hql).uniqueResult();
	}
}
