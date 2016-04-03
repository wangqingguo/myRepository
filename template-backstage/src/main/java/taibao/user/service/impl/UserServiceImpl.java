package taibao.user.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import taibao.user.mapper.UserMapper;
import taibao.user.service.UserService;
@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private UserMapper userMapper;
public int queryUserCount(){
	return this.userMapper.queryUserCount();
}
}
