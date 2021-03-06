package com.yuki.decmarket.mapper;

import com.yuki.decmarket.model.Users;
import com.yuki.decmarket.model.UsersExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface UsersMapper {
	/**
	 * This method was generated by MyBatis Generator.
	 * This method corresponds to the database table users
	 *
	 * @mbggenerated Mon Jul 16 16:46:29 CST 2018package com.yuki.decmarket.mapper;
	 */
	int countByExample(UsersExample example);

	/**
	 * This method was generated by MyBatis Generator.
	 * This method corresponds to the database table users
	 *
	 * @mbggenerated Mon Jul 16 16:46:29 CST 2018
	 */
	int deleteByExample(UsersExample example);

	/**
	 * This method was generated by MyBatis Generator.
	 * This method corresponds to the database table users
	 *
	 * @mbggenerated Mon Jul 16 16:46:29 CST 2018
	 */
	int deleteByPrimaryKey(Integer id);

	/**
	 * This method was generated by MyBatis Generator.
	 * This method corresponds to the database table users
	 *
	 * @mbggenerated Mon Jul 16 16:46:29 CST 2018
	 */
	int insert(Users record);

	/**
	 * This method was generated by MyBatis Generator.
	 * This method corresponds to the database table users
	 *
	 * @mbggenerated Mon Jul 16 16:46:29 CST 2018
	 */
	int insertSelective(Users record);

	/**
	 * This method was generated by MyBatis Generator.
	 * This method corresponds to the database table users
	 *
	 * @mbggenerated Mon Jul 16 16:46:29 CST 2018
	 */
	List<Users> selectByExample(UsersExample example);

	/**
	 * This method was generated by MyBatis Generator.
	 * This method corresponds to the database table users
	 *
	 * @mbggenerated Mon Jul 16 16:46:29 CST 2018
	 */
	Users selectByPrimaryKey(Integer id);

	/**
	 * This method was generated by MyBatis Generator.
	 * This method corresponds to the database table users
	 *
	 * @mbggenerated Mon Jul 16 16:46:29 CST 2018
	 */
	int updateByExampleSelective(@Param("record") Users record, @Param("example") UsersExample example);

	/**
	 * This method was generated by MyBatis Generator.
	 * This method corresponds to the database table users
	 *
	 * @mbggenerated Mon Jul 16 16:46:29 CST 2018
	 */
	int updateByExample(@Param("record") Users record, @Param("example") UsersExample example);

	/**
	 * This method was generated by MyBatis Generator.
	 * This method corresponds to the database table users
	 *
	 * @mbggenerated Mon Jul 16 16:46:29 CST 2018
	 */
	int updateByPrimaryKeySelective(Users record);

	/**
	 * This method was generated by MyBatis Generator.
	 * This method corresponds to the database table users
	 *
	 * @mbggenerated Mon Jul 16 16:46:29 CST 2018
	 */
	int updateByPrimaryKey(Users record);

	/**
	 * something add
	 */
	Users getUserByID(int user_id);

	Users getUserByUsername(String username);

	List<Users> getUserList();

	List<Users> getUserByQuery(String query);

	Users getUserByTel(String tel);

	Users getUserByEmail(String email);
}