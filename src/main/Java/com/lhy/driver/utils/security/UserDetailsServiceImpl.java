package com.lhy.driver.utils.security;

import com.lhy.driver.dao.RoleDao;
import com.lhy.driver.dao.UserDao;
import com.lhy.driver.pojo.Role;
import com.lhy.driver.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by Administrator on 2017/3/4.
 */
public class UserDetailsServiceImpl implements UserDetailsService {
    @Autowired
    private UserDao userDao;
    @Autowired
    private RoleDao roleDao;

    public UserDetails loadUserByUsername(String username) throws AuthenticationException {
        User user = userDao.getUserByName(username);
        if (null == user) {
            throw new UsernameNotFoundException("用户：" + username + "不存在！");
        }
        userDao.updateUser(new User(user.getId(),new Date()));
        Set<GrantedAuthority> authorities = getAuthorities(user);
        UserInfo userInfo = new UserInfo(user.getUsername(),user.getPassword(),true,true,true,true,authorities);
        userInfo.setId(user.getId());
        return userInfo;
    }

    // 获得用户所有角色的权限
    private Set<GrantedAuthority> getAuthorities(User user) {
        Set<GrantedAuthority> authoritySet = new HashSet<GrantedAuthority>();
        List<Role> roles = roleDao.getUserRoles(user.getId());
        for (Role role : roles) {
            authoritySet.add(new SimpleGrantedAuthority(role.getName()));
        }
        return authoritySet;
    }
}
