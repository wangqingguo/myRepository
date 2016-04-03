package taibao.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import taibao.user.service.UserService;
@Controller
@RequestMapping("/user/")
public class UserController {
	@Autowired
private UserService userService;
@RequestMapping("queryUser")
public String queryUserCount(){
	this.userService.queryUserCount();
	return "index";
}
}
