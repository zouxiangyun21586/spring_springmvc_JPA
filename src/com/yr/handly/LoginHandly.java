package com.yr.handly;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class LoginHandly {

	@RequestMapping(value = "/login_ssj", method = RequestMethod.GET)
	public String selectAllReuse(Map<String, Object> map, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String account = request.getParameter("account"); // 获取页面输入的参数,用来进行查询是否有权限操作
		String password = request.getParameter("password");
		String randomCode = request.getParameter("randomCode");// 得到验证码
		System.out.println(account);
		System.out.println(password);
		System.out.println(randomCode);
		
		String yanzhengma = request.getSession().getAttribute("rand") == null ? ""
				: request.getSession().getAttribute("rand").toString(); // 生成的正确验证码
		// 界面没有输入验证码，我们相当于为第一次登陆
		if (randomCode == null || randomCode.equals("")) {
			// 判断用户名与密码是否正确
			if (account.equals("") && account == null || password.equals("") && password == null)
			{
				request.setAttribute("err", 0);// 提示 请输入用户名或密码
				return "login";
			} else if("zxy".equals(account) && "8866".equals(password)){
				return "show";
			} else {
				request.setAttribute("err", 1);// 提示请输入用户名或密码
				return "login";
			}
		}
		if (yanzhengma.toLowerCase().equals(randomCode.toLowerCase())) {
			if ("zxy".equals(account) && "8866".equals(password))// 判断用户名与密码是否正确
			{
				return "show";
			} else {// 否则提示用户名或密码错误，这里还有一种可能，就是验证码正确，用户名或密码为null，可以判断null，也可以直接提示用户名或密码错误，是null也是错误
				request.setAttribute("err", 0);// 用户名或密码错误
				return "login";
			}
		} else {// 提示验证码输入错误
			request.setAttribute("err", 2);// 验证码错误
			return "login";
		}

	}
}
