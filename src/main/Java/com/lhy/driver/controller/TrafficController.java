package com.lhy.driver.controller;

import com.alibaba.fastjson.JSON;
import com.lhy.driver.pojo.TrafficContent;
import com.lhy.driver.pojo.TrafficMenu;
import com.lhy.driver.service.TrafficService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by lhy on 2017/3/6.
 */
@Controller
public class TrafficController {

    @Autowired
    private TrafficService trafficService;

    /**
     * 交规目录页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/traffic/menu",method = RequestMethod.POST)
    public String menu(HttpServletRequest request, Model model){
        return "/admin/traffic/trafficMenu";
    }

    /**
     * 交规内容页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/traffic/content",method = RequestMethod.POST)
    public String content(HttpServletRequest request, Model model){
        TrafficMenu trafficMenu = trafficService.getMenuByPIdIsNull().get(0);
        List<TrafficMenu> list = trafficService.getMenuByPId(trafficMenu.getId());
        model.addAttribute("menus",list);
        return "/admin/traffic/trafficContent";
    }

    /**
     * 交规目录JSON
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/traffic/menuJson",produces = {"application/json;charset=UTF-8"},method = {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public String menuJson(HttpServletRequest request, Model model){
        List<Map<String,Object>> list = new ArrayList<Map<String, Object>>();
        List<TrafficMenu> trafficMenus = new ArrayList<TrafficMenu>();
        if(request.getParameter("pid").equals("#")){
            trafficMenus = trafficService.getMenuByPIdIsNull();
            if(trafficMenus == null || trafficMenus.isEmpty()){
                trafficService.addTrafficMenu(new TrafficMenu("交规解读",null));
                trafficMenus = trafficService.getMenuByPIdIsNull();
            }
        }else{
            trafficMenus = trafficService.getMenuByPId(Long.parseLong(request.getParameter("pid")));
        }
        for (TrafficMenu trafficmenu:trafficMenus) {
            Map<String,Object> map = new HashMap<String, Object>();
            map.put("id",trafficmenu.getId());
            map.put("text",trafficmenu.getName());
            map.put("children",true);
            Map<String,Object> map1 = new HashMap<String, Object>();
            map1.put("opened",true);
            map.put("state",map1);
            list.add(map);
        }
        return JSON.toJSONString(list);
    }

    /**
     * 编辑交规目录操作：新建、修改、删除
     * @param type
     * @param text
     * @param pid
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/traffic/editTraffic",produces = {"application/json;charset=UTF-8"},method = {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public String editTraffic(String type, String text, Long pid,HttpServletRequest request, Model model){
        Map<String,Object> map = new HashMap<String, Object>();
        if(type.equals("r")){
            if(request.getParameter("id").contains("_")){
                if(trafficService.addTrafficMenu(new TrafficMenu(text,pid))){
                    map.put("result",true);
                    map.put("message","创建成功");
                }else{
                    map.put("result",false);
                    map.put("message","创建失败");
                }
            }else{
                if(trafficService.updateTrafficMenu(new TrafficMenu(Long.parseLong(request.getParameter("id")),text))){
                    map.put("result",true);
                    map.put("message","修改成功");
                }else{
                    map.put("result",false);
                    map.put("message","修改失败");
                }
            }
        }else if(type.equals("d")){
            if(trafficService.deleteTrafficMenu(Long.parseLong(request.getParameter("id")))){
                map.put("result",true);
                map.put("message","删除成功");
            }else{
                map.put("result",false);
                map.put("message","删除失败");
            }
        }
        return JSON.toJSONString(map);
    }

    /**
     * 获取下一级目录
     * @param pid
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/traffic/nextMenu",produces = {"application/json;charset=UTF-8"},method = {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public String nextMenu(Long pid, HttpServletRequest request, Model model){
        List<TrafficMenu> list = trafficService.getMenuByPId(pid);
        return JSON.toJSONString(list);
    }

    /**
     * 获取交规内容
     * @param tid
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/traffic/getTrafficContent",produces = {"application/json;charset=UTF-8"},method = {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public String getTrafficContent(Long tid, HttpServletRequest request, Model model){
        TrafficContent trafficContent = trafficService.findContentByTId(tid);
        return JSON.toJSONString(trafficContent);
    }

    /**
     * 交规内容保存
     * @param tid
     * @param content
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/traffic/saveTrafficContent",produces = {"application/json;charset=UTF-8"},method = {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public String saveTrafficContent(Long tid, String content, HttpServletRequest request, Model model){
        Map<String,Object> map = new HashMap<String, Object>();
        TrafficContent trafficContent = trafficService.findContentByTId(tid);
        if(trafficContent != null){
            trafficContent.setContent(content);
            if(trafficService.updateTrafficContent(trafficContent)){
                map.put("result",true);
                map.put("message","保存成功");
            }else{
                map.put("result",false);
                map.put("message","保存失败");
            }
        }else{
            trafficContent = new TrafficContent(tid,content);
            if(trafficService.saveTrafficContent(trafficContent)){
                map.put("result",true);
                map.put("message","保存成功");
            }else{
                map.put("re sult",false);
                map.put("message","保存失败");
            }
        }
        return JSON.toJSONString(map);
    }

    /**
     * 组装交规文章
     * @param model
     * @return
     */
    @RequestMapping(value = "/user/traffic/show",method = RequestMethod.POST)
    public String show(Model model){
        List<Map<String, Object>> traffics = new ArrayList<Map<String, Object>>();
        TrafficMenu root =  trafficService.getMenuByPIdIsNull().get(0);
        parseTraffic(traffics, root, 1);
        model.addAttribute("traffics",traffics);
        return "/user/traffic/show";
    }

    /**
     *
     * @param traffics
     * @param parent
     * @param index
     */
    public void parseTraffic(List<Map<String, Object>> traffics, TrafficMenu parent, int index){
        List<TrafficMenu> menus = trafficService.getMenuByPId(parent.getId());
        for (TrafficMenu menu : menus) {
            List<TrafficMenu> lists = trafficService.getMenuByPId(menu.getId());
            if(lists != null && !lists.isEmpty()){
                if(inList(traffics, menu)){
                    Map<String, Object> map = new HashMap<String, Object>();
                    map.put("name",menu.getName());
                    map.put("isLeaf",false);
                    map.put("index",index);
                    traffics.add(map);
                }
                parseTraffic(traffics,menu,index+1);
            }else{
                Map<String, Object> map = new HashMap<String, Object>();
                TrafficContent content = trafficService.findContentByTId(menu.getId());
                map.put("name",menu.getName());
                map.put("isLeaf",true);
                map.put("index",index);
                map.put("content",content == null?"":content.getContent());
                traffics.add(map);
            }
        }
    }

    /**
     *
     * @param traffics
     * @param menu
     * @return
     */
    private boolean inList(List<Map<String,Object>> traffics, TrafficMenu menu) {
        for (Map<String, Object> traffic : traffics) {
            if(traffic.get("name").equals(menu.getName())){
                return false;
            }
        }
        return true;
    }

}
