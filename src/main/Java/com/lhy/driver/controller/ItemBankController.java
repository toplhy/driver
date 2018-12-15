package com.lhy.driver.controller;

import com.alibaba.fastjson.JSON;
import com.lhy.driver.pojo.Dictionary;
import com.lhy.driver.pojo.ItemBank;
import com.lhy.driver.service.DictionaryService;
import com.lhy.driver.service.ItemBankService;
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
 * Created by lhy on 2017/3/12.
 */
@Controller
public class ItemBankController {

    @Autowired
    private ItemBankService itemBankService;
    @Autowired
    private DictionaryService dictionaryService;

    /**
     * 跳转到题库列表页面
     * @return
     */
    @RequestMapping(value = "/admin/itembank/list",method = {RequestMethod.GET,RequestMethod.POST})
    public String list(){
        return "/admin/itembank/list";
    }

    /**
     * 题库列表：题库分页展示
     * @param page
     * @param size
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/itembank/itembankJson",produces = {"application/json;charset=UTF-8"}, method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody
    public String itembankJson(int page, int size, HttpServletRequest request, Model model){
        Map<String,Object> map = new HashMap<String, Object>();
        Integer total = itemBankService.getItemBankCount();
        List<ItemBank> list = itemBankService.getItemBankList(page,size);
        map.put("total",total);
        map.put("rows",list);
        return JSON.toJSONString(map);
    }

    /**
     * 新建题库页面
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/itembank/create",method = {RequestMethod.GET,RequestMethod.POST})
    public String create(Long id,Model model){
        List<Dictionary> typeList = dictionaryService.getDicByCode("SYCX");
        if(id != null){
            ItemBank itemBank = itemBankService.getItemBankById(id);
            model.addAttribute("itembank",itemBank);
        }
        model.addAttribute("typeList",typeList);
        return "/admin/itembank/create";
    }

    /**
     * 保存或更新题库信息操作
     * @param itemBank
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/itembank/saveItemBank",produces = {"application/json;charset=UTF-8"},method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody
    public String saveItemBank(ItemBank itemBank, HttpServletRequest request, Model model){
        Map<String,Object> map = new HashMap<String, Object>();
        if(itemBank.getId() == null){
            itemBank.setState(1);
            if(itemBankService.saveItembank(itemBank)){
                map.put("result",true);
                map.put("message","保存成功");
            }else{
                map.put("result",false);
                map.put("message","保存失败");
            }
        }else{
            if(itemBankService.updateItembank(itemBank)){
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
     * 展示题库信息页面
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/itembank/show",method = {RequestMethod.GET,RequestMethod.POST})
    public String show(Long id,Model model){
        ItemBank itemBank = itemBankService.getItemBankById(id);
        model.addAttribute("itembank",itemBank);
        return "/admin/itembank/show";
    }

    /**
     * 禁用、启用题库操作
     * @param itemBank
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/itembank/enabled",produces = {"application/json;charset=UTF-8"},method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody
    public String enabled(ItemBank itemBank, HttpServletRequest request, Model model){
        Map<String,Object> map = new HashMap<String, Object>();
        if(itemBankService.updateItembank(itemBank)){
            map.put("result",true);
            map.put("message","操作成功");
        }else{
            map.put("result",false);
            map.put("message","操作失败");
        }
        return JSON.toJSONString(map);
    }

    /**
     * 删除题库操作
     * @param ids
     * @return
     */
    @RequestMapping(value = "/admin/itembank/delItemBank",produces = {"application/json;charset=UTF-8"},method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody
    public String delItemBank(String ids){
        Map<String,Object> map = new HashMap<String, Object>();
        if(itemBankService.deleteItemBank(ids)){
            map.put("result",true);
            map.put("message","删除成功");
        }else{
            map.put("result",false);
            map.put("message","删除失败");
        }
        return JSON.toJSONString(map);
    }
}
