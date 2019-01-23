package com.yr.dao.impl;

import java.math.BigInteger;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Repository;

import com.yr.dao.ResourceDao;
import com.yr.entity.Resource;

@Repository
public class ResourceDaoImpl implements ResourceDao {
	
	@PersistenceContext
	private EntityManager entityManager;

	@Override
	public void add(Resource resource) {
		entityManager.persist(resource);
	}

	@Override
	public void update(Resource resource) {
		Resource r = entityManager.find(Resource.class, resource.getId());
		
		Long id = resource.getId();
		String name = resource.getResourceName();
		String http = resource.getHttpUrl();
		entityManager.remove(r);
		
		Resource re = new Resource();
		re.setId(id);
		re.setResourceName(name);
		re.setHttpUrl(http);
		entityManager.merge(re);
	}

	@Override
	public Long delete(Resource resource) {
		Query query = entityManager.createNativeQuery("select count(role_id) from zxy_resource_role where resource_id =" + resource.getId());
		BigInteger big = (BigInteger) query.getSingleResult();
		int uid = big.intValue();
		if(query != null && uid != 0){ // 权限有角色关联不能删除
			return 1L;
		}else{
			Query qu = entityManager.createNativeQuery("delete from zxy_resource where id =" + resource.getId());
			qu.executeUpdate();
			return 2L;
		}
	}

	@Override
	public List<Resource> query() {
		Query q = entityManager.createQuery("from Resource");
		List<Resource> listResource = q.getResultList();
		return listResource;
	}

	@Override
	public Resource get(Long id) {
		Query q = entityManager.createQuery("from Resource where id = "+id);
		Resource listUser = (Resource)q.getSingleResult();
		return listUser;
	}
	
}
