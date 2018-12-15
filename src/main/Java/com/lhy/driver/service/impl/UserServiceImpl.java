package com.lhy.driver.service.impl;

import com.lhy.driver.dao.RoleDao;
import com.lhy.driver.dao.UserDao;
import com.lhy.driver.pojo.ExamHistory;
import com.lhy.driver.pojo.Role;
import com.lhy.driver.pojo.User;
import com.lhy.driver.pojo.UserRole;
import com.lhy.driver.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by lhy on 2017/3/1.
 */
@Service
public class UserServiceImpl implements UserService{

    @Autowired
    private UserDao userDao;
    @Autowired
    private RoleDao roleDao;

    public List<User> getAllUser() {
        return userDao.selectAllUser();
    }

    public User getUserById(Long id) {
        return userDao.getUserById(id);
    }

    public void updateUser(User user) {
        userDao.updateUser(user);
    }

    public User getUserByName(String username) {
        return userDao.getUserByName(username);
    }

    @Transactional
    public boolean saveUser(User user, String role) {
        userDao.saveUser(user);
        Long rid;
        if(role.equals("user")){
            rid = roleDao.getRoleByName("ROLE_USER").getId();
        }else{
            rid = roleDao.getRoleByName("ROLE_ADMIN").getId();
        }
        if(roleDao.saveUserRole(new UserRole(rid,user.getId()))>0){
            return true;
        }else{
            return false;
        }
    }

    public Integer getUsersCount(String name,String role) {
        return userDao.getUsersCount(name,role);
    }

    public List<User> getUsersList(String name,String role, int page, int size) {
        return userDao.getUsersList(name,role,page,size);
    }

    public Role getUserRole(Long id) {
        return roleDao.getUserRoles(id).get(0);
    }

    public Integer getCountByCreateDate(Date date) {
        return userDao.getCountByCreateDate(date);
    }

    public Integer getCountByRole(String role) {
        return userDao.getCountByRole(role);
    }

    public void saveExamHistory(ExamHistory examHistory) {
        userDao.saveExamHistory(examHistory);
    }

    public List<Map<String, Object>> getHistoryList(Long user,String type) {
        return userDao.getHistoryList(user,type);
    }

    public List<ExamHistory> getHistoryByItemAndUser(Long itemId, Long user) {
        return userDao.getHistoryByItemAndUser(itemId, user);
    }
}
