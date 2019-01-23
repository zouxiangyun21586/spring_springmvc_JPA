package com.yr.handly;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yr.entity.Resource;
import com.yr.service.ResourceService;
import com.yr.util.JsonUtils;

@Controller
public class ResourceHandly {

	@Autowired
	private ResourceService resourceService;

	/**
	 * 添加
	 * 
	 * @author zxy
	 * @param user
	 * @return 2018年4月11日 下午10:16:12
	 *
	 */
	@Transactional
	@RequestMapping(value = "/resource", method = RequestMethod.POST)
	public String add(Resource resource, ModelMap map) {
		Boolean boo = resourceService.add(resource);
		if (boo) {
			map.put("addSu", 2);
			return "show";
		} else {
			map.put("addSu", 1);
			return "show";
		}
	}

	/**
	 * 删除
	 * 
	 * @author zxy
	 * @param user
	 * @return 2018年4月11日 下午10:16:07
	 *
	 */
	@Transactional
	@RequestMapping(value = "/resource/{id}", method = RequestMethod.DELETE)
	public String del(Resource resource, ModelMap map) {
		Boolean bool = resourceService.delete(resource);
		if (bool) {
			map.put("dlt", 2);
			return "show";
		} else {
			map.put("dlt", 1);
			return "show";
		}
	}

	/**
	 * 修改
	 * 
	 * @author zxy
	 * @param id
	 * @param modelMap
	 * @return 2018年3月12日 下午7:47:00
	 *
	 */
	@Transactional
	@RequestMapping(value = "/resource", method = RequestMethod.PUT)
	public String upd(Resource resource, ModelMap map) {
		Boolean bool = resourceService.update(resource);
		if (bool) {
			map.put("upd", 2);
			return "show";
		} else {
			map.put("upd", 1);
			return "show";
		}
	}

	@RequestMapping(value = "/getResource", method = RequestMethod.GET)
	public @ResponseBody String get(Long id, ModelMap map) {
		Resource listUser = resourceService.get(id);
		String str = JsonUtils.beanToJson(listUser, new String[] { "roleList" }, false);
		return str;
	}

	/**
	 * 查询
	 * 
	 * @author zxy
	 * @return 2018年3月12日 下午7:51:37
	 *
	 */
	@RequestMapping(value = "/resource", method = RequestMethod.GET)
	public @ResponseBody String sel(HttpServletResponse response, HttpServletRequest request) {
		List<Resource> listUser = resourceService.query();
		String aa = "";
		try {
			// false表示数组中的属性不需要转成json,如果是true代表只将数组中的属性转成json格式
			aa = JsonUtils.beanListToJson(listUser, new String[] { "roleList" }, false);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return aa;
		
	}

}
