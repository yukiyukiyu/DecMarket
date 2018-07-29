package com.yuki.decmarket.service;

import com.yuki.decmarket.mapper.FavlistsMapper;
import com.yuki.decmarket.mapper.UserInfoMapper;
import com.yuki.decmarket.mapper.UsersMapper;
import com.yuki.decmarket.model.Favlists;
import com.yuki.decmarket.model.UserInfo;
import com.yuki.decmarket.model.Users;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UserService {
	@Autowired
	private UsersMapper usersMapper;

	@Autowired
	private UserInfoMapper userInfoMapper;

	@Autowired
	private FavlistsMapper favlistsMapper;

	public Users getUserByID(int user_id) {
		return usersMapper.getUserByID(user_id);

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

	public UserInfo getUserInfoByID(int user_id) {
		return userInfoMapper.selectByPrimaryKey(user_id);
	}

	public void editUserInfo(UserInfo userInfo) {
		userInfoMapper.updateByPrimaryKey(userInfo);
	}

	public List<Favlists> getFavListByID(int user_id) {
		return favlistsMapper.getFavListByUserID(user_id);
	}
}
