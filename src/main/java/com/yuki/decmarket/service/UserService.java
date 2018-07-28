package com.yuki.decmarket.service;

import com.yuki.decmarket.mapper.UsersMapper;
import com.yuki.decmarket.model.Users;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UserService {
	@Autowired
	private UsersMapper usersMapper;

	public Users getUserByID(int uid) {
		return usersMapper.getUserByID(uid);

	}

	public Users getUserByUsername(String username) {
		return usersMapper.getUserByUsername(username);
	}

	public List<Users> getUserList() {
		return usersMapper.getUserList();
	}

	@Transactional
	public void register(Users user) {
		usersMapper.insert(user);
	}

	public void updateUser(Users user) {
		usersMapper.updateByPrimaryKey(user);
	}
}
