package com.lhy.driver.dao;

import com.lhy.driver.pojo.Role;
import com.lhy.driver.pojo.UserRole;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by lhy on 2017/3/4.
 */
@Repository
public interface RoleDao {
    List<Role> getUserRoles(Long uid);

    Role getRoleByName(String name);

    int saveUserRole(UserRole userRole);
}
