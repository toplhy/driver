package com.lhy.driver.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.itextpdf.text.pdf.BaseFont;
import com.lhy.driver.pojo.*;
import com.lhy.driver.pojo.Dictionary;
import com.lhy.driver.service.DictionaryService;
import com.lhy.driver.service.ItemBankService;
import com.lhy.driver.service.PointService;
import com.lhy.driver.service.QuestionService;
import com.lhy.driver.utils.ExcelUtil;
import com.lhy.driver.utils.TemplateToHtml;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.xhtmlrenderer.pdf.ITextFontResolver;
import org.xhtmlrenderer.pdf.ITextRenderer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.*;

/**
 * Created by lhy on 2017/3/21.
 */
@Controller
public class QuestionController {

    @Autowired
    private ItemBankService itemBankService;
    @Autowired
    private DictionaryService dictionaryService;
    @Autowired
    private PointService pointService;
    @Autowired
    private QuestionService questionService;

    /**
     * 试题列表页面
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/question/list",method = {RequestMethod.GET,RequestMethod.POST})
    public String list(Model model){
        List<ItemBank> itemList = itemBankService.getItemBankList(0,100000);
        List<Dictionary> typeList = dictionaryService.getDicByCode("STLX");
        model.addAttribute("itemList",itemList);
        model.addAttribute("typeList",typeList);
        return "/admin/question/list";
    }

    /**
     * 试题列表：试题分页展示
     * @param ibid
     * @param type
     * @param size
     * @param page
     * @return
     */
    @RequestMapping(value = "/admin/question/questionJson",produces = {"application/json;charset=UTF-8"},method = {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public String questionJson(Long ibid, Long type, int size, int page){
        Map<String,Object> map = new HashMap<String, Object>();
        Integer total = questionService.getQuestionCount(type,ibid);
        List<Map<String,Object>> list = questionService.getQuestionList(type,ibid,page,size);
        map.put("total",total);
        map.put("rows",list);
        return JSON.toJSONString(map);
    }

    /**
     * 新建试题页面
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/question/create",method = {RequestMethod.GET,RequestMethod.POST})
    public String create(Model model){
        List<ItemBank> itemList = itemBankService.getItemBankList(0,100000);
        List<Dictionary> typeList = dictionaryService.getDicByCode("STLX");
        model.addAttribute("itemList",itemList);
        model.addAttribute("typeList",typeList);
        return "/admin/question/create";
    }

    /**
     * 新建试题：得到知识点
     * @param ibid
     * @return
     */
    @RequestMapping(value = "/admin/question/getPoint",produces = {"application/json;charset=UTF-8"},method = {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public String getPoint(Long ibid){
        List<Point> list = pointService.getPointByItemId(ibid);
        return JSON.toJSONString(list);
    }

    /**
     * 保存试题的操作
     * @param question
     * @param request
     * @return
     */
    @RequestMapping(value = "/admin/question/saveQuestion",produces = {"application/json;charset=UTF-8"},method = {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public String saveQuestion(Question question,HttpServletRequest request){
        Map<String,Object> map = new HashMap<String, Object>();
        if(request.getParameter("singleOptions") != null && !request.getParameter("singleOptions").equals("")){
            String[] singleOptions = request.getParameterValues("singleOptions");
            List<Map> options = new ArrayList<Map>();
            for(int i=0;i<singleOptions.length;i++){
                Map option = new HashMap();
                option.put("key",(char)(65+i));
                option.put("value",singleOptions[i]);
                options.add(option);
            }
            question.setOptions(JSON.toJSONString(options));
        }else if(request.getParameter("multOptions") != null && !request.getParameter("multOptions").equals("")){
            String[] multOptions = request.getParameterValues("multOptions");
            List<Map> options = new ArrayList<Map>();
            for(int i=0;i<multOptions.length;i++){
                Map option = new HashMap();
                option.put("key",(char)(65+i));
                option.put("value",multOptions[i]);
                options.add(option);
            }
            question.setOptions(JSON.toJSONString(options));
        }
        if(questionService.saveQuestion(question)){
            map.put("result",true);
            map.put("message","保存成功");
        }else{
            map.put("result",false);
            map.put("message","保存失败");
        }
        return JSON.toJSONString(map);
    }

    /**
     * 修改试题的操作
     * @param question
     * @param request
     * @return
     */
    @RequestMapping(value = "/admin/question/alterQuestion",produces = {"application/json;charset=UTF-8"},method = {RequestMethod.GET,RequestMethod.POST})
    @ResponseBody
    public String alterQuestion(Question question,HttpServletRequest request){
        Map<String,Object> map = new HashMap<String, Object>();
        if(request.getParameter("singleOptions") != null && !request.getParameter("singleOptions").equals("")){
            String[] singleOptions = request.getParameterValues("singleOptions");
            List<Map> options = new ArrayList<Map>();
            for(int i=0;i<singleOptions.length;i++){
                Map option = new HashMap();
                option.put("key",(char)(65+i));
                option.put("value",singleOptions[i]);
                options.add(option);
            }
            question.setOptions(JSON.toJSONString(options));
        }else if(request.getParameter("multOptions") != null && !request.getParameter("multOptions").equals("")){
            String[] multOptions = request.getParameterValues("multOptions");
            List<Map> options = new ArrayList<Map>();
            for(int i=0;i<multOptions.length;i++){
                Map option = new HashMap();
                option.put("key",(char)(65+i));
                option.put("value",multOptions[i]);
                options.add(option);
            }
            question.setOptions(JSON.toJSONString(options));
        }
        if(questionService.updateQuestion(question)){
            map.put("result",true);
            map.put("message","修改成功");
        }else{
            map.put("result",false);
            map.put("message","修改失败");
        }
        return JSON.toJSONString(map);
    }

    /**
     * 试题展示页面
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/question/show",method = {RequestMethod.GET,RequestMethod.POST})
    public String show(Long id, Model model){
        Map<String,Object> question = questionService.getQuestionById(id);
        JSONArray options = JSONArray.parseArray(question.get("options").toString());
        model.addAttribute("options",options);
        model.addAttribute("question",question);
        return "/admin/question/show";
    }

    /**
     * 编辑试题页面
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/admin/question/edit",method = {RequestMethod.GET,RequestMethod.POST})
    public String edit(Long id, Model model){
        Map<String,Object> question = questionService.getQuestionById(id);
        JSONArray options = JSONArray.parseArray(question.get("options").toString());
        List<ItemBank> itemList = itemBankService.getItemBankList(0,100000);
        List<Dictionary> typeList = dictionaryService.getDicByCode("STLX");
        model.addAttribute("itemList",itemList);
        model.addAttribute("typeList",typeList);
        model.addAttribute("options",options);
        model.addAttribute("question",question);
        return "/admin/question/edit";
    }

    /**
     * 删除试题操作
     * @param ids
     * @return
     */
    @RequestMapping(value = "/admin/question/delQuestion",produces = {"application/json;charset=UTF-8"},method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody
    public String delQuestion(String ids){
        Map<String,Object> map = new HashMap<String, Object>();
        if(questionService.delQuestion(ids)){
            map.put("result",true);
            map.put("message","删除成功");
        }else{
            map.put("result",false);
            map.put("message","删除失败");
        }
        return JSON.toJSONString(map);
    }

    /**
     * 试题导出操作
     * @param ids
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/admin/question/exportQuestion",method = {RequestMethod.POST,RequestMethod.GET})
    public void exportQuestion(String ids, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String,Object> data = questionService.exportQuestion(ids,request);
        String htmlStr = TemplateToHtml.toHtml("question.ftl", data, request);
        String appPath = request.getServletContext().getRealPath("/static/temp/") + File.separator;
        ITextRenderer renderer = new ITextRenderer();
        renderer.setDocumentFromString(htmlStr,"file:" + appPath);
        // 解决中文支持问题
        ITextFontResolver fontResolver = renderer.getFontResolver();
        String font = request.getServletContext().getRealPath("/static/fonts/simsun.ttc");
        fontResolver.addFont(font, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
        response.setHeader("Content-disposition", "attachment;filename=" + new String("questions.pdf".getBytes("GBK"),"ISO8859-1"));
        response.setContentType("application/pdf");
        OutputStream os = response.getOutputStream();
        renderer.layout();
        renderer.createPDF(os, true);
        os.flush();
        os.close();
    }

    /**
     * 下载导入模板操作
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/admin/question/downTemplate",method = {RequestMethod.POST,RequestMethod.GET})
    public void downTemplate( HttpServletRequest request, HttpServletResponse response) throws Exception {
        String path = request.getServletContext().getRealPath("/static/templates/question.xlsx");
        File file = new File(path);
        response.setContentType("application/octet-stream");
        response.addHeader("Content-Disposition", "attachment;filename=" + new String("template.xlsx".getBytes("GBK"),"ISO8859-1"));
        InputStream in = new FileInputStream(file);
        OutputStream os = response.getOutputStream();
        int b;
        while((b=in.read())!= -1)
        {
            os.write(b);
        }
        in.close();
        os.close();
    }

    /**
     * 导入试题操作
     * @param questions
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/admin/question/importQuestion",produces = {"application/json;charset=UTF-8"},method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody
    public String importQuestion(@RequestParam(value = "questions") MultipartFile questions) throws Exception {
        Map<String,Object> map = new HashMap<String, Object>();
        String filetype = questions.getContentType();
        if(!filetype.equals("application/vnd.ms-excel") && !filetype.equals("application/wps-office.xlsx") && !filetype.equals("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")){
            map.put("result",false);
            map.put("message","文件类型不正确！");
        }else{
            List<List<Object>> list = ExcelUtil.getListByExcel(questions.getInputStream(),questions.getOriginalFilename());
            if(questionService.importQuestion(list)){
                map.put("result",true);
                map.put("message","导入成功！");
            }else{
                map.put("result",false);
                map.put("message","导入出错！");
            }
        }
        return JSON.toJSONString(map);
    }

}
