package com.lhy.driver.controller;

import com.alibaba.fastjson.JSON;
import com.lhy.driver.pojo.ItemBank;
import com.lhy.driver.pojo.Point;
import com.lhy.driver.service.ItemBankService;
import com.lhy.driver.service.PointService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by lhy on 2017/3/18.
 */
@Controller
public class PointController {

    @Autowired
    private PointService pointService;
    @Autowired
    private ItemBankService itemBankService;

    /**
     * 知识点列表页面
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/point/list",method = {RequestMethod.GET,RequestMethod.POST})
    public String list(Model model){
        List<ItemBank> itemList = itemBankService.getItemBankList(0,100000);
        model.addAttribute("itemList",itemList);
        return "/admin/point/list";
    }

    /**
     * 知识点列表：知识点分页展示
     * @param ibid
     * @param name
     * @param size
     * @param page
     * @return
     */
    @RequestMapping(value = "/admin/point/pointJson",produces = {"application/json;charset=UTF-8"}, method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody
    public String pointJson(Long ibid, String name, int size, int page){
        Map<String,Object> map = new HashMap<String, Object>();
        if(null != name && !"".equals(name)){
            name = "%" + name + "%";
        }else{
            name = "%%";
        }
        Integer total = pointService.getPointCount(name,ibid);
        List<Map<String,Object>> list = pointService.getPointList(name,ibid,page,size);
        map.put("total",total);
        map.put("rows",list);
        return JSON.toJSONString(map);
    }

    /**
     * 创建知识点页面
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/point/create",method = {RequestMethod.GET,RequestMethod.POST})
    public String create(Long id,Model model){
        if(id != null){
            Point point = pointService.getPointById(id);
            model.addAttribute("point",point);
        }
        List<ItemBank> itemList = itemBankService.getItemBankList(0,100000);
        model.addAttribute("itemList",itemList);
        return "/admin/point/create";
    }

    /**
     * 保存、更新知识点信息操作
     * @param point
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/point/savePoint",produces = {"application/json;charset=UTF-8"},method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody
    public String savePoint(Point point, HttpServletRequest request, Model model){
        Map<String,Object> map = new HashMap<String, Object>();
        if(point.getId() == null){
            if(pointService.savePoint(point)){
                map.put("result",true);
                map.put("message","保存成功");
            }else{
                map.put("result",false);
                map.put("message","保存失败");
            }
        }else{
            if(pointService.updatePoint(point)){
                map.put("result",true);
                map.put("message","修改成功");
            }else{
                map.put("result",false);
                map.put("message","修改失败");
            }
        }
        return JSON.toJSONString(map);
    }

    /**
     * 删除知识点操作
     * @param ids
     * @return
     */
    @RequestMapping(value = "/admin/point/delPoint",produces = {"application/json;charset=UTF-8"},method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody
    public String delPoint(String ids){
        Map<String,Object> map = new HashMap<String, Object>();
        if(pointService.deletePoint(ids)){
            map.put("result",true);
            map.put("message","删除成功");
        }else{
            map.put("result",false);
            map.put("message","删除失败");
        }
        return JSON.toJSONString(map);
    }
}
