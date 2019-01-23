package com.yr.dao;

import java.util.List;

import com.yr.entity.Resource;

public interface ResourceDao {
	public void add(Resource resource);
	
	public void update(Resource resource);
	
	public Long delete(Resource resource);
	
	public List<Resource> query();
	
	public Resource get(Long id);
	
}	
