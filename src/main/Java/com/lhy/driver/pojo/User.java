package com.lhy.driver.pojo;

import java.util.Date;

/**
 * Created by lhy on 2017/3/1.
 */
public class User {
    private Long id;
    private String username;
    private String email;
    private String phone;
    private String password;
    private String aviator;
    private Date createtime;
    private Date lastlogin;

    public User() {
    }

    public User(Long id, Date lastlogin) {
        this.id = id;
        this.lastlogin = lastlogin;
    }

    public User(Long id, String aviator) {
        this.id = id;
        this.aviator = aviator;
    }

    public User(Long id, String username, String email, String phone, String password, String aviator, Date createtime, Date lastlogin) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.aviator = aviator;
        this.createtime = createtime;
        this.lastlogin = lastlogin;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAviator() {
        return aviator;
    }

    public void setAviator(String aviator) {
        this.aviator = aviator;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public Date getLastlogin() {
        return lastlogin;
    }

    public void setLastlogin(Date lastlogin) {
        this.lastlogin = lastlogin;
    }
}
