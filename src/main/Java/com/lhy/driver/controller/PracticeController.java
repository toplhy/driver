package com.lhy.driver.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.lhy.driver.pojo.ExamHistory;
import com.lhy.driver.pojo.ItemBank;
import com.lhy.driver.pojo.Point;
import com.lhy.driver.pojo.User;
import com.lhy.driver.service.ItemBankService;
import com.lhy.driver.service.PointService;
import com.lhy.driver.service.QuestionService;
import com.lhy.driver.service.UserService;
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
import java.util.logging.SimpleFormatter;

/**
 * Created by lhy on 2017/4/22.
 */
@Controller
public class PracticeController {

    @Autowired
    private ItemBankService itemBankService;
    @Autowired
    private QuestionService questionService;
    @Autowired
    private PointService pointService;
    @Autowired
    private UserService userService;

    /**
     * 试题联系总页面
     * @param ibid
     * @param model
     * @return
     */
    @RequestMapping(value = "/user/practice/main",method = {RequestMethod.GET,RequestMethod.POST})
    public String mainPage(Long ibid,Model model){
        ItemBank itemBank = itemBankService.getItemBankById(ibid);
        model.addAttribute("item",itemBank);
        return "/user/practice/main";
    }

    /**
     * 试题评论页面
     * @param qid
     * @param value
     * @param model
     * @return
     */
    @RequestMapping(value = "/user/practice/comments",method = {RequestMethod.GET,RequestMethod.POST})
    public String comments(Long qid, Integer value, Model model){
        List<Map<String, Object>> comments = questionService.getCommentsBuQuestion(qid);
        model.addAttribute("comments",comments);
        model.addAttribute("question",qid);
        model.addAttribute("value",value);
        return "/user/practice/comments";
    }

    /**
     * 试题评论操作
     * @param qid
     * @param content
     * @return
     */
    @RequestMapping(value = "/user/practice/publish",produces = {"application/json;charset=UTF-8"}, method = {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public String publish(Long qid, String content) {
        Map<String, Object> map = new HashMap<String, Object>();
        UserInfo userInfo = (UserInfo) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if(questionService.saveComment(qid,userInfo.getId(),content)){
            map.put("result",true);
            map.put("message","评论成功");
        }else{
            map.put("result",false);
            map.put("message","出了点小问题");
        }
        return JSON.toJSONString(map);
    }

    /**
     * 专项练习页面
     * @param pid
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/user/practice/special",method = {RequestMethod.GET,RequestMethod.POST})
    public String special(Long pid, HttpServletRequest request, Model model){
        Point point = pointService.getPointById(pid);
        ItemBank itemBank = itemBankService.getItemBankById(point.getIbid());
        UserInfo userInfo = (UserInfo) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        List<Map<String, Object>> questions = questionService.getSpecialQuestionsByItemAndPoint(point.getIbid(), "%"+point.getName()+"%");
        for (Map question: questions) {
            JSONArray options = JSONArray.parseArray(question.get("options").toString());
            question.put("options",options);
            if(questionService.hasCollected(Long.parseLong(question.get("id").toString()),userInfo.getId())){
                question.put("isCollected",true);
            }else{
                question.put("isCollected",false);
            }
        }
        Collections.shuffle(questions);
        model.addAttribute("questions",questions);
        model.addAttribute("item",itemBank);
        model.addAttribute("point",point);
        return "/user/practice/special";
    }

    /**
     * 随机练习页面
     * @param itemId
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/user/practice/random",method = {RequestMethod.GET,RequestMethod.POST})
    public String random(Long itemId, HttpServletRequest request, Model model){
        ItemBank itemBank = itemBankService.getItemBankById(itemId);
        UserInfo userInfo = (UserInfo) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        List<Map<String, Object>> questions = questionService.getRandomQuestionsByItem(itemId);
        for (Map question: questions) {
            JSONArray options = JSONArray.parseArray(question.get("options").toString());
            question.put("options",options);
            if(questionService.hasCollected(Long.parseLong(question.get("id").toString()),userInfo.getId())){
                question.put("isCollected",true);
            }else{
                question.put("isCollected",false);
            }
        }
        Collections.shuffle(questions);
        model.addAttribute("questions",questions);
        model.addAttribute("item",itemBank);
        return "/user/practice/random";
    }

    /**
     * 难题练习页面
     * @param itemId
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/user/practice/diff",method = {RequestMethod.GET,RequestMethod.POST})
    public String diff(Long itemId, HttpServletRequest request, Model model){
        ItemBank itemBank = itemBankService.getItemBankById(itemId);
        UserInfo userInfo = (UserInfo) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        List<Map<String, Object>> questions = questionService.getDiffQuestionsByItem(itemId);
        for (Map question: questions) {
            JSONArray options = JSONArray.parseArray(question.get("options").toString());
            question.put("options",options);
            if(questionService.hasCollected(Long.parseLong(question.get("id").toString()),userInfo.getId())){
                question.put("isCollected",true);
            }else{
                question.put("isCollected",false);
            }
        }
        model.addAttribute("questions",questions);
        model.addAttribute("item",itemBank);
        return "/user/practice/diff";
    }

    /**
     * 错题练习页面
     * @param itemId
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/user/practice/wrongs",method = {RequestMethod.GET,RequestMethod.POST})
    public String wrongs(Long itemId, HttpServletRequest request, Model model){
        ItemBank itemBank = itemBankService.getItemBankById(itemId);
        UserInfo userInfo = (UserInfo) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        List<Map<String, Object>> questions = questionService.getWrongsByItemAndUser(itemId,userInfo.getId());
        for (Map question: questions) {
            JSONArray options = JSONArray.parseArray(question.get("options").toString());
            question.put("options",options);
            if(questionService.hasCollected(Long.parseLong(question.get("id").toString()),userInfo.getId())){
                question.put("isCollected",true);
            }else{
                question.put("isCollected",false);
            }
        }
        model.addAttribute("questions",questions);

        model.addAttribute("item",itemBank);
        return "/user/practice/wrongs";
    }

    /**
     * 我的收藏页面
     * @param itemId
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/user/practice/collections",method = {RequestMethod.GET,RequestMethod.POST})
    public String collections(Long itemId, HttpServletRequest request, Model model){
        ItemBank itemBank = itemBankService.getItemBankById(itemId);
        UserInfo userInfo = (UserInfo) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        List<Map<String, Object>> questions = questionService.getCollectionsByItemAndUser(itemId,userInfo.getId());
        for (Map question: questions) {
            JSONArray options = JSONArray.parseArray(question.get("options").toString());
            question.put("options",options);
        }


        model.addAttribute("questions",questions);
        model.addAttribute("item",itemBank);
        return "/user/practice/collections";
    }

    /**
     * 模拟考试页面
     * @param itemId
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/user/practice/exam",method = {RequestMethod.GET,RequestMethod.POST})
    public String exam(Long itemId, HttpServletRequest request, Model model){
        ItemBank itemBank = itemBankService.getItemBankById(itemId);
        UserInfo userInfo = (UserInfo) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        User user = userService.getUserById(userInfo.getId());
        List<Map<String, Object>> questions = questionService.getExamQuestions(itemBank);
        if(questions != null){
            for (Map question: questions) {
                JSONArray options = JSONArray.parseArray(question.get("options").toString());
                question.put("options",options);
            }
            Collections.shuffle(questions);
        }
        model.addAttribute("questions",questions);
        model.addAttribute("item",itemBank);
        model.addAttribute("user",user);
        return "/user/practice/exam";
    }

    /**
     * 练习做错试题的操作
     * @param qid
     * @return
     */
    @RequestMapping(value = "/user/practice/wrong",produces = {"application/json;charset=UTF-8"}, method = {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public String wrong(Long qid) {
        UserInfo userInfo = (UserInfo) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if(questionService.getWrongByQuestionAndUser(qid,userInfo.getId())){
            questionService.saveWrong(qid,userInfo.getId());
        }
        return JSON.toJSONString("");
    }

    /**
     * 收藏操作
     * @param qid
     * @return
     */
    @RequestMapping(value = "/user/practice/collect",produces = {"application/json;charset=UTF-8"}, method = {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public String collect(Long qid) {
        Map<String, Object> map = new HashMap<String, Object>();
        UserInfo userInfo = (UserInfo) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if(questionService.saveCollection(qid,userInfo.getId())) {
            map.put("result", true);
            map.put("message", "收藏成功");
        }else{
            map.put("result", false);
            map.put("message", "收藏失败，请重新尝试。");
        }
        return JSON.toJSONString(map);
    }

    /**
     * 取消收藏的操作
     * @param qid
     * @return
     */
    @RequestMapping(value = "/user/practice/cancelCollect",produces = {"application/json;charset=UTF-8"}, method = {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public String cancelCollect(Long qid) {
        Map<String, Object> map = new HashMap<String, Object>();
        UserInfo userInfo = (UserInfo) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if(questionService.deleteCollection(qid,userInfo.getId())) {
            map.put("result", true);
            map.put("message", "成功取消收藏");
        }else{
            map.put("result", false);
            map.put("message", "取消收藏失败，请重新尝试。");
        }
        return JSON.toJSONString(map);
    }

    /**
     * 专项练习：获取知识点
     * @param ibid
     * @return
     */
    @RequestMapping(value = "/user/practice/showPoints",produces = {"application/json;charset=UTF-8"}, method = {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public String showPoints(Long ibid) {
        List<Point> points = pointService.getPointByItemId(ibid);
        return JSON.toJSONString(points);
    }

    /**
     * 模拟考试：交卷操作
     * @param history
     * @param begintime
     * @param model
     * @return
     */
    @RequestMapping(value = "/user/practice/commit", method = {RequestMethod.GET,RequestMethod.POST})
    public String commit(ExamHistory history,String begintime,Model model) {
        ItemBank itemBank = itemBankService.getItemBankById(history.getItem());
        UserInfo userInfo = (UserInfo) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        User user = userService.getUserById(userInfo.getId());
        history.setUser(userInfo.getId());
        userService.saveExamHistory(history);
        model.addAttribute("history",history);
        model.addAttribute("item",itemBank);
        model.addAttribute("user",user);
        return "/user/practice/result";
    }
}
