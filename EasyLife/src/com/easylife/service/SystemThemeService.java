package com.easylife.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.easylife.dao.SystemThemeDao;
import com.easylife.domain.SystemTheme;

@Service
@Transactional
public class SystemThemeService {
	@Resource
	private SystemThemeDao themeDao;
	
	public SystemTheme findByUserId(Long userId){
		return themeDao.findByUserId(userId);
	}
	
	public void updateTheme(SystemTheme theme){
		themeDao.update(theme);
	}
	
	public void addTheme(SystemTheme theme){
		themeDao.save(theme);
	}
}
