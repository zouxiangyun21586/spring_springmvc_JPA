package com.yr.service;

import java.util.List;

import com.yr.entity.Resource;

/**
 * 权限 service 接口
 * @author zxy
 * 2018年4月11日 下午7:23:21 
 *
 */
public interface ResourceService {
	
	public Boolean add(Resource resource);
	
	public Boolean update(Resource resource);
	
	public Boolean delete(Resource resource);
	
	public List<Resource> query();
	
	public Resource get(Long id);
	
}
