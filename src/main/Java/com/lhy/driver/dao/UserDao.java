package com.lhy.driver.dao;

import com.lhy.driver.pojo.ExamHistory;
import com.lhy.driver.pojo.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.security.access.method.P;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by lhy on 2017/3/1.
 */
@Repository
public interface UserDao {

    List<User> selectAllUser();

    User getUserByName(String username);

    User getUserById(Long id);

    void updateUser(@Param("user")User user);

    Long saveUser(User user);

    Integer getUsersCount(@Param("name") String name,@Param("role") String role);

    List<User> getUsersList(@Param("name") String name,@Param("role")String role,@Param("page") int page,@Param("size") int size);

    Integer getCountByCreateDate(Date date);

    Integer getCountByRole(String role);

    void saveExamHistory(ExamHistory examHistory);

    List<Map<String,Object>> getHistoryList(@Param("user")Long user, @Param("type")String type);

    List<ExamHistory> getHistoryByItemAndUser(@Param("item")Long item, @Param("user")Long user);
}
