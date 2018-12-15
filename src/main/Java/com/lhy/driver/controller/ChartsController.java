package com.lhy.driver.controller;

import com.alibaba.fastjson.JSON;
import com.lhy.driver.pojo.*;
import com.lhy.driver.pojo.Dictionary;
import com.lhy.driver.service.DictionaryService;
import com.lhy.driver.service.ItemBankService;
import com.lhy.driver.service.QuestionService;
import com.lhy.driver.service.UserService;
import com.lhy.driver.utils.DateUtil;
import com.lhy.driver.utils.security.UserInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.ParseException;
import java.util.*;

/**
 * Created by lhy on 2017/4/5.
 */
@Controller
public class ChartsController {

    @Autowired
    private UserService userService;
    @Autowired
    private DictionaryService dictionaryService;
    @Autowired
    private QuestionService questionService;

    /**
     * 用户情况统计，生成折线图和饼图
     * @param model
     * @return
     * @throws ParseException
     */
    @RequestMapping(value = "/admin/charts/userCon",method = {RequestMethod.GET,RequestMethod.POST})
    public String userCon(Model model) throws ParseException {
        //折线图
        List<Integer> xvalue = new ArrayList<Integer>();
        String[] xkey = DateUtil.getLast12Months(6);
        for (int i=0; i<6; i++){
            Date date = DateUtil.addMonth(xkey[i]);
            xvalue.add(userService.getCountByCreateDate(date));
        }
        //饼图
        List<Integer> userNum = new ArrayList<Integer>();
        userNum.add(userService.getCountByRole("ROLE_ADMIN"));
        userNum.add(userService.getCountByRole("ROLE_USER"));
        model.addAttribute("xkey",xkey);
        model.addAttribute("xvalue",xvalue);
        model.addAttribute("userNum",userNum);
        return "/admin/charts/userCon";
    }

    /**
     * 试题情况统计，生成折线图和饼图
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/charts/questionCon",method = {RequestMethod.GET,RequestMethod.POST})
    public String questionCon(Model model){
        List<Map<String, Object>> items = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> types = new ArrayList<Map<String, Object>>();
        List<Dictionary> drivertypes = dictionaryService.getDicByCode("SYCX");
        List<Dictionary> questiontypes = dictionaryService.getDicByCode("STLX");
        for (Dictionary dictionary : drivertypes) {
            Map<String ,Object> map = new HashMap<String, Object>();
            map.put("label",dictionary.getName());
            map.put("value1",questionService.getCountByDrivertypeAndType(dictionary.getName(),questiontypes.get(0).getId()));
            map.put("value2",questionService.getCountByDrivertypeAndType(dictionary.getName(),questiontypes.get(1).getId()));
            items.add(map);
        }
        for (Dictionary dictionary : questiontypes) {
            Map<String ,Object> map = new HashMap<String, Object>();
            map.put("label",dictionary.getName());
            map.put("value",questionService.getQuestionCount(dictionary.getId(),0L));
            types.add(map);
        }
        model.addAttribute("items", JSON.toJSONString(items));
        model.addAttribute("types", JSON.toJSONString(types));
        return "/admin/charts/questionCon";
    }

}
