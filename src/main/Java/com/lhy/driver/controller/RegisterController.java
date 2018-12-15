package com.lhy.driver.controller;

import com.alibaba.fastjson.JSON;
import com.lhy.driver.pojo.User;
import com.lhy.driver.service.UserService;
import com.lhy.driver.utils.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by lhy on 2017/3/11.
 */
@Controller
public class RegisterController {

    @Autowired
    private UserService userService;

    /**
     * 注册页面
     * @return
     */
    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String registerPage() {
        return "register/register";
    }

    /**
     * 注册操作
     * @param user
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/register/registerUser",produces = {"application/json;charset=UTF-8"}, method = RequestMethod.POST)
    @ResponseBody
    public String saveUser(User user,HttpServletRequest request, Model model) {
        Map<String,Object> map = new HashMap<String, Object>();
        User existUser = userService.getUserByName(user.getUsername());
        if(existUser != null){
            map.put("result",false);
            map.put("message","用户名已存在！");
        }else{
            user.setPassword(MD5Util.getMD5Str(user.getPassword()));
            user.setCreatetime(new Date());
            if(userService.saveUser(user,"user")){
                map.put("result",true);
                map.put("message","注册成功");
            }else{
                map.put("result",false);
                map.put("message","注册失败，请重新尝试！");
            }

        }
        return JSON.toJSONString(map);
    }
}
