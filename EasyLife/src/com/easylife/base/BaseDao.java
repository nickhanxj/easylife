package com.easylife.base;

import java.io.Serializable;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.easylife.util.Page;

@SuppressWarnings("all")
public class BaseDao<T> {
	@Resource
	private SessionFactory sessionFactory;

	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	public Serializable save(T t) {
		return getSession().save(t);
	}

	public void update(T t) {
		getSession().update(t);
	}

	public void delete(T t) {
		getSession().delete(t);
	}
	
	public void excuteHqlQuery(String hql){
		getSession().createQuery(hql);
	}

	public List<T> selectAll(Class clz) {
		String hql = "from " + clz.getSimpleName();
		Query query = getSession().createQuery(hql);
		return query.list();
	}

	public T getById(Class clz, Long id) {
		String hql = "from " + clz.getSimpleName() + " t where t.id = " + id;
		List list = getSession().createQuery(hql).list();
		if (list.size() > 0) {
			return (T) list.get(0);
		} else {
			return null;
		}
	}
	
	public Page<T> selectByPage(Page<T> page, Class clz) {
		String customizedHql = page.getCustomizedHql();
		int currentPage = page.getCurrentPage();
		int pageSize = page.getPageSize();
		if (customizedHql == null || customizedHql == "") {
			customizedHql = "from " + clz.getSimpleName();
		}
		Query query = getSession().createQuery(customizedHql);
		List<T> list = query
					.setFirstResult((currentPage - 1) * pageSize)
					.setMaxResults(pageSize)
					.list();
		//封装page对象用于返回
		page.setRows(list);
		page.setTotalRow(countTotal(clz, customizedHql));
		page.setFirstPage(isFirstPage(currentPage));
		page.setLastPage(isLastPage(page));
		page.setTotalPage(countTotalPage(page.getTotalRow(), pageSize));
		return page;
	}

	//总记录数
	private int countTotal(Class clz, String customizedHql) {
		if (customizedHql == null || customizedHql == "") {
			return getSession().createQuery("from " + clz.getSimpleName()).list().size();
		}
		return getSession().createQuery(customizedHql).list().size();

	}
	
	//总页数
	private int countTotalPage(int totalRow, int pageSize){
		int totalPage = 1;
		if(totalRow%pageSize == 0){
			totalPage = totalRow / pageSize;
		}else{
			totalPage = (totalRow / pageSize) + 1;
		}
		return totalPage;
	}

	//是否是当前页
	private boolean isFirstPage(int currentPage) {
		if (currentPage == 1) {
			return true;
		}
		return false;
	}
	
	//是否是最后一页
	private boolean isLastPage(Page page){
		int currentPage = page.getCurrentPage();
		int pageSize = page.getPageSize();
		int totalRow = page.getTotalRow();
		int totalPage = 1;
		if(totalRow % pageSize == 0){
			totalPage = totalRow / pageSize;
		}else{
			totalPage = totalRow / pageSize + 1;
		}
		if(currentPage == totalPage){
			return true;
		}
		return false;
	}
}
