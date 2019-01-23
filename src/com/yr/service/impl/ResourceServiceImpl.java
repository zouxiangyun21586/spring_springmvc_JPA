package com.yr.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yr.dao.ResourceDao;
import com.yr.entity.Resource;
import com.yr.service.ResourceService;

@Service
public class ResourceServiceImpl implements ResourceService{

	@Autowired
	private ResourceDao resourceDao;

	@Transactional
	@Override
	public Boolean add(Resource resource) {
		try {
			resourceDao.add(resource);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	@Transactional
	@Override
	public Boolean update(Resource resource) {
		try {
			resourceDao.update(resource);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	@Transactional
	@Override
	public Boolean delete(Resource resource) {
		try {
			Long a = resourceDao.delete(resource);
				return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public List<Resource> query() {
		List<Resource> listResource = resourceDao.query();
		return listResource;
	}

	@Override
	public Resource get(Long id) {
		Resource listResource = resourceDao.get(id);
		return listResource;
	}
	
}
