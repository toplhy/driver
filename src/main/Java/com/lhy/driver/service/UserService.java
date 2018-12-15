package com.lhy.driver.service;

import com.lhy.driver.pojo.ExamHistory;
import com.lhy.driver.pojo.Role;
import com.lhy.driver.pojo.User;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by lhy on 2017/3/1.
 */
public interface UserService {

    User getUserById(Long id);

    void updateUser(User user);

    User getUserByName(String username);

    boolean saveUser(User user,String role);

    Integer getUsersCount(String name,String role);

    List<User> getUsersList(String name,String role, int page, int size);

    Role getUserRole(Long id);

    Integer getCountByCreateDate(Date date);

    Integer getCountByRole(String role);

    void saveExamHistory(ExamHistory examHistory);

    List<Map<String,Object>> getHistoryList(Long user,String type);

    List<ExamHistory> getHistoryByItemAndUser(Long itemId, Long user);
}
