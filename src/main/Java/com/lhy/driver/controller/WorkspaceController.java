package com.lhy.driver.controller;

import com.alibaba.fastjson.JSON;
import com.lhy.driver.pojo.Dictionary;
import com.lhy.driver.pojo.User;
import com.lhy.driver.service.DictionaryService;
import com.lhy.driver.service.UserService;
import com.lhy.driver.utils.MD5Util;
import com.lhy.driver.utils.security.UserInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by lhy on 2017/3/5.
 */
@Controller
public class WorkspaceController {

    @Autowired
    private UserService userService;
    @Autowired
    private DictionaryService dictionaryService;

    /**
     * 首页
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/index", method = {RequestMethod.GET,RequestMethod.POST})
    public String index(HttpServletRequest request, Model model) {
        UserInfo userInfo = (UserInfo) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        User user = userService.getUserById(userInfo.getId());
        model.addAttribute("user",user);
        List<Dictionary> items = dictionaryService.getDicByCode("SYCX");
        model.addAttribute("items",items);
        return "/index";
    }

    /**
     * 欢迎页
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/welcome", method = {RequestMethod.GET,RequestMethod.POST})
    public String welcome(HttpServletRequest request, Model model) {
        return "/welcome";
    }

    /**
     * 用户信息管理：展示
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/workspace/showProfile", method = {RequestMethod.GET,RequestMethod.POST})
    public String showProfile(HttpServletRequest request, Model model) {
        UserInfo userInfo = (UserInfo) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        User user = userService.getUserById(userInfo.getId());
        model.addAttribute("user",user);
        return "/profile/show";
    }

    /**
     * 更换头像
     * @param aviator
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/workspace/changeAviator",produces = {"application/json;charset=UTF-8"}, method = RequestMethod.POST)
    @ResponseBody
    public String changeAviator(@RequestParam(value = "aviator") MultipartFile aviator, HttpServletRequest request, Model model){
        Map map = new HashMap();
        UserInfo userInfo = (UserInfo) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String filetype = aviator.getContentType();
        if(!filetype.equals("image/jpeg") && !filetype.equals("image/gif") && !filetype.equals("image/png")){
            map.put("result",false);
            map.put("message","文件类型不正确！");
        }else{
            String fileName = userInfo.getUsername() + new Date().getTime() + aviator.getOriginalFilename();
            String path = request.getSession().getServletContext().getRealPath("aviator");
            File file = new File(path,fileName);
            if(!file.exists()){
                file.mkdirs();
            }
            try {
                aviator.transferTo(file);
                userService.updateUser(new User(userInfo.getId(),fileName));
            } catch (IOException e) {
                e.printStackTrace();
            }
            map.put("result",true);
            map.put("message","更换成功");
            map.put("src",request.getContextPath() + "/aviator/" +fileName);
        }
        return JSON.toJSONString(map);
    }

    /**
     * 修改密码
     * @param id
     * @param password
     * @param model
     * @return
     */
    @RequestMapping(value = "/workspace/resetPass",produces = {"application/json;charset=UTF-8"},method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody
    public String resetPass(Long id,String password, Model model){
        Map<String,Object> map = new HashMap<String, Object>();
        User user = userService.getUserById(id);
        user.setPassword(MD5Util.getMD5Str(password));
        userService.updateUser(user);
        map.put("result",true);
        map.put("message","修改成功。");
        return JSON.toJSONString(map);
    }

    /**
     * 用户信息管理：修改信息
     * @param id
     * @param email
     * @param phone
     * @param model
     * @return
     */
    @RequestMapping(value = "/workspace/updateUser",produces = {"application/json;charset=UTF-8"},method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody
    public String updateUser(Long id,String email,String phone, Model model){
        Map<String,Object> map = new HashMap<String, Object>();
        User user = userService.getUserById(id);
        user.setEmail(email);
        user.setPhone(phone);
        userService.updateUser(user);
        map.put("result",true);
        map.put("message","修改成功。");
        return JSON.toJSONString(map);
    }
}
