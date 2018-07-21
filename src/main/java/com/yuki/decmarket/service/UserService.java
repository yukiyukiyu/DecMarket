package com.yuki.decmarket.service;

import com.yuki.decmarket.mapper.UsersMapper;
import com.yuki.decmarket.model.Users;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UserService {
	private UsersMapper usersMapper;

	public Users getUserByID(int uid) {
		return usersMapper.getUserByID(uid);

	}

	public Users getUserByUsername(String username) {
		return usersMapper.getUserByUsrname(username);
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
