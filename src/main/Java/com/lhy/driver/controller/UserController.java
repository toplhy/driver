package com.lhy.driver.controller;

import com.alibaba.fastjson.JSON;
import com.lhy.driver.pojo.*;
import com.lhy.driver.service.ItemBankService;
import com.lhy.driver.service.PointService;
import com.lhy.driver.service.QuestionService;
import com.lhy.driver.service.UserService;
import com.lhy.driver.utils.MD5Util;
import com.lhy.driver.utils.security.UserInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by lhy on 2017/3/1.
 */
@Controller
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private ItemBankService itemBankService;
    @Autowired
    private PointService pointService;
    @Autowired
    private QuestionService questionService;

    /**
     * 用户列表页面
     * @return
     */
    @RequestMapping(value = "/admin/users/list",method = {RequestMethod.GET,RequestMethod.POST})
    public String list(){
        return "/admin/users/list";
    }

    /**
     * 用户列表：用户分页展示
     * @param name
     * @param role
     * @param page
     * @param size
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/users/usersJson",produces = {"application/json;charset=UTF-8"}, method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody
    public String usersJson(String name,String role, int page, int size, HttpServletRequest request, Model model){
        Map<String,Object> map = new HashMap<String, Object>();
        if(null != name && !"".equals(name)){
            name = "%" + name + "%";
        }else{
            name = "%%";
        }
        Integer total = userService.getUsersCount(name,role);
        List<User> list = userService.getUsersList(name,role,page,size);
        map.put("total",total);
        map.put("rows",list);
        return JSON.toJSONString(map);
    }

    /**
     * 新建用户页面
     * @return
     */
    @RequestMapping(value = "/admin/users/create",method = {RequestMethod.GET,RequestMethod.POST})
    public String create(){
        return "/admin/users/create";
    }

    /**
     * 用户编辑页面
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/users/edit",method = {RequestMethod.GET,RequestMethod.POST})
    public String edit(Long id,Model model){
        User user = userService.getUserById(id);
        Role role = userService.getUserRole(user.getId());
        model.addAttribute("user",user);
        model.addAttribute("role",role.getName().equals("ROLE_ADMIN")?"管理员":"普通用户");
        return "/admin/users/edit";
    }

    /**
     * 保存用户操作
     * @param user
     * @param role
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/users/saveUser",produces = {"application/json;charset=UTF-8"},method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody
    public String saveUser(User user,String  role, HttpServletRequest request, Model model){
        Map<String,Object> map = new HashMap<String, Object>();
        if(user.getId() == null){
            User existUser = userService.getUserByName(user.getUsername());
            if(existUser != null){
                map.put("result",false);
                map.put("message","用户名已存在！");
            }else {
                user.setPassword(MD5Util.getMD5Str("123456"));
                user.setCreatetime(new Date());
                if (userService.saveUser(user,role)) {
                    map.put("result", true);
                    map.put("message", "保存成功。初始密码为123456");
                } else {
                    map.put("result", false);
                    map.put("message", "保存失败");
                }
            }
        }else{
            userService.updateUser(user);
            map.put("result",true);
            map.put("message","修改成功");
        }
        return JSON.toJSONString(map);
    }

    /**
     * 用户信息展示页面
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/users/show",method = {RequestMethod.GET,RequestMethod.POST})
    public String show(Long id,Model model){
        User user = userService.getUserById(id);
        Role role = userService.getUserRole(user.getId());
        model.addAttribute("user",user);
        model.addAttribute("role",role.getName().equals("ROLE_ADMIN")?"管理员":"普通用户");
        return "/admin/users/show";
    }

    /**
     * 重置密码操作
     * @param user
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/users/reset",produces = {"application/json;charset=UTF-8"},method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody
    public String resetPassword(User user, HttpServletRequest request, Model model){
        Map<String,Object> map = new HashMap<String, Object>();
        user.setPassword(MD5Util.getMD5Str("123456"));
        userService.updateUser(user);
        map.put("result",true);
        map.put("message","操作成功。密码重置为123456");
        return JSON.toJSONString(map);
    }

    /**
     * 获取车型的题库
     * @param name
     * @return
     */
    @RequestMapping(value = "/user/getMenuList",produces = {"application/json;charset=UTF-8"}, method = {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public String getMenuList(String name) {
        List<ItemBank> itemBanks = itemBankService.getItemBankByType(name);
        return JSON.toJSONString(itemBanks);
    }

    /**
     * 用户考试揭露
     * @param type
     * @param model
     * @return
     */
    @RequestMapping(value = "/user/center/history",method = {RequestMethod.GET,RequestMethod.POST})
    public String history(String type,Model model){
        UserInfo userInfo = (UserInfo) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        List<Map<String,Object>> histories = userService.getHistoryList(userInfo.getId(),type);
        model.addAttribute("histories",histories);
        return "/user/center/history";
    }

    /**
     * 用户分析页面
     * @param type
     * @param model
     * @return
     */
    @RequestMapping(value = "/user/center/analysis",method = {RequestMethod.GET,RequestMethod.POST})
    public String analysis(String type,Model model){
        List<ItemBank> itemBanks = itemBankService.getItemBankByType(type);
        model.addAttribute("items",itemBanks);
        return "/user/center/analysis";
    }

    /**
     * 用户图表
     * @param itemId
     * @return
     */
    @RequestMapping(value = "/user/center/charts",produces = {"application/json;charset=UTF-8"}, method = {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public String charts(Long itemId) {
        Map<String, Object> result = new HashMap<String, Object>();
        UserInfo userInfo = (UserInfo) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        List<Point> points = pointService.getPointByItemId(itemId);
        List<ExamHistory> histories = userService.getHistoryByItemAndUser(itemId, userInfo.getId());
        List<Map<String,Object>> wrongs = new ArrayList<Map<String, Object>>();
        for (Point point:points) {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("label",point.getName());
            map.put("value",questionService.getWrongCountByPointAndUser("%" + point.getName() + "%",userInfo.getId()));
            wrongs.add(map);
        }
        boolean falg = true;
        for (Map map:wrongs) {
            if(falg){
                if(Integer.parseInt(map.get("value").toString()) != 0){
                    falg = false;
                }
            }
        }
        List<Map<String,Object>> exam = new ArrayList<Map<String, Object>>();
        for (int i = 0; i < histories.size(); i++){
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("y",new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(histories.get(i).getSubmittime()));
            map.put("a",histories.get(i).getScore());
            exam.add(map);
        }
        result.put("wrongs",wrongs);
        result.put("falg",falg);
        result.put("histories",exam);
        return JSON.toJSONString(result);
    }
}
