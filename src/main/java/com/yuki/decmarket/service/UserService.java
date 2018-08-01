package com.yuki.decmarket.service;

import com.yuki.decmarket.mapper.FavlistsMapper;
import com.yuki.decmarket.mapper.TransactionsMapper;
import com.yuki.decmarket.mapper.UserInfoMapper;
import com.yuki.decmarket.mapper.UsersMapper;
import com.yuki.decmarket.model.Favlists;
import com.yuki.decmarket.model.Transactions;
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

	@Autowired
	private TransactionsMapper transactionsMapper;

	public Users getUserByID(int user_id) {
		return usersMapper.getUserByID(user_id);

	}

	public Users getUserByUsername(String username) {
		return usersMapper.getUserByUsername(username);
	}

	public List<Users> getUserList() {
		return usersMapper.getUserList();
	}

	public List<Users> getUserByQuery(String query) {
		return usersMapper.getUserByQuery(query);
	}

	@Transactional
	public void register(Users user) {
		usersMapper.insert(user);
	}

	public void updateUser(Users user) {
		usersMapper.updateByPrimaryKey(user);
	}

	public UserInfo getUserInfoByID(int user_id) {
		return userInfoMapper.getUserInfoByUserID(user_id);
	}

	public void delUserInfoByID(int id) {
		userInfoMapper.deleteByPrimaryKey(id);
	}

	public void editUserInfo(UserInfo userInfo) {
		userInfoMapper.updateByPrimaryKey(userInfo);
	}

	public List<Favlists> getFavListByID(int user_id) {
		return favlistsMapper.getFavListByUserID(user_id);
	}

	public List<Transactions> getTransByBuyerID(int buyer_id) {
		System.out.println(buyer_id);
		return transactionsMapper.getTransByBuyerID(buyer_id);
	}

	public List<Transactions> getTransBySellerID(int seller_id) {
		return transactionsMapper.getTransBySellerID(seller_id);
	}

	public void createUserInfo(UserInfo userInfo) {
		userInfoMapper.insert(userInfo);
	}

	public int findFavListByID(int user_id, int good_id) {
		return favlistsMapper.findFavListByID(user_id, good_id);
	}

	public void delFavListByID(int id) {
		favlistsMapper.deleteByPrimaryKey(id);
	}

	public Transactions getTranByID(int tran_id) {
		return transactionsMapper.getTranByID(tran_id);
	}

	public void addTranComment(Transactions tran) {
		transactionsMapper.updateByPrimaryKey(tran);
	}

	public void delTranComment(int tran_id) {
		transactionsMapper.delCommentByID(tran_id);
	}

	public List<Transactions> getTransList() {
		return transactionsMapper.getTransList();
	}

	public Users getUserByInfo(String info, int flag) {
		if(flag == 1)
			return usersMapper.getUserByTel(info);
		else
			return usersMapper.getUserByEmail(info);
	}

	public void updateTran(Transactions tran) {
		transactionsMapper.updateByPrimaryKey(tran);
	}
}
