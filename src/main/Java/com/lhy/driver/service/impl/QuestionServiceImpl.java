package com.lhy.driver.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.lhy.driver.dao.DictionaryDao;
import com.lhy.driver.dao.ItemBankDao;
import com.lhy.driver.dao.PointDao;
import com.lhy.driver.dao.QuestionDao;
import com.lhy.driver.pojo.*;
import com.lhy.driver.pojo.Dictionary;
import com.lhy.driver.service.QuestionService;
import com.lhy.driver.utils.PercentUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created by lhy on 2017/3/29.
 */
@Service
public class QuestionServiceImpl implements QuestionService {

    @Autowired
    private QuestionDao questionDao;
    @Autowired
    private DictionaryDao dictionaryDao;
    @Autowired
    private ItemBankDao itemBankDao;
    @Autowired
    private PointDao pointDao;

    public boolean saveQuestion(Question question) {
        if(questionDao.saveQuestion(question)){
            return true;
        }else{
            return false;
        }
    }

    public Integer getQuestionCount(Long type, Long ibid) {
        return questionDao.getQuestionCount(type, ibid);
    }

    public List<Map<String, Object>> getQuestionList(Long type, Long ibid, int page, int size) {
        return questionDao.getQuestionList(type, ibid, page, size);
    }

    public Map<String,Object> getQuestionById(Long id) {
        return questionDao.getQuestionById(id);
    }

    @Transactional
    public boolean delQuestion(String ids) {
        String[] idlist = ids.split(",");
        for (String id: idlist) {
            questionDao.deleteQuestion(Long.parseLong(id));
        }
        return true;
    }

    public Map<String, Object> exportQuestion(String ids,HttpServletRequest request) {
        String path =  request.getServletContext().getRealPath("/static/temp/imgTemp") + "\\";
        Map<String, Object> data = new HashMap<String, Object>();
        List<Long> idList = new ArrayList<Long>();
        for (String id: ids.split(",")) {
            idList.add(Long.parseLong(id));
        }
        List<Map<String, Object>> list = questionDao.exportQuestions(idList);
        for(int i = 0; i<list.size(); i++){
            Map map = list.get(i);
            List<Map> options = new ArrayList<Map>();
            JSONArray array = JSONArray.parseArray(map.get("options").toString());
            for(int j = 0; j<array.size(); j++){
                Map option = (Map) array.get(j);
                options.add(option);
            }
            map.put("options",options);
            map.put("content",map.get("content").toString().replace("\">","\" />").replace("<p>","").replace("</p>","").replace("<br>",""));
        }
        data.put("data",list);
        return data;
    }

    public boolean updateQuestion(Question question) {
        if(questionDao.updateQuestion(question)){
            return true;
        }else{
            return false;
        }
    }

    @Transactional
    public boolean importQuestion(List<List<Object>> lists) {
        for (int i = 0; i < lists.size(); i++){
            List<Object> list = lists.get(i);
            Question question = new Question();
            String bankStr = list.get(0).toString();
            int index = bankStr.indexOf('·');
            ItemBank itemBank = itemBankDao.getItemBankByTypeAndName(bankStr.substring(0,index),bankStr.substring(index+1,bankStr.length()));
            question.setIbid(itemBank.getId());
            String typeStr = list.get(1).toString();
            com.lhy.driver.pojo.Dictionary type = dictionaryDao.getDicByNameAndCode(typeStr,"STLX");
            question.setType(type.getId());
            question.setContent(list.get(2).toString());
            List<Map> options = new ArrayList<Map>();
            for (int j = 3; j <= 8; j++){
                if(list.get(j) != ""){
                    Map option = new HashMap();
                    option.put("key",(char)(65+j-3));
                    option.put("value",list.get(j).toString());
                    options.add(option);
                }
            }
            question.setOptions(JSON.toJSONString(options));
            question.setAnswer(list.get(9).toString());
            question.setDifficulty((int)Double.parseDouble(list.get(10).toString()));
            question.setAnalysis(list.get(11).toString());
            question.setPoint(list.get(12).toString());
            question.setKeyword(list.get(13).toString());
            questionDao.saveQuestion(question);
        }
        return true;
    }

    public List<Map<String, Object>> getRandomQuestionsByItem(Long itemId) {
        return questionDao.getRandomQuestionsByItem(itemId);
    }

    public boolean getWrongByQuestionAndUser(Long qid, Long uid) {
        if(questionDao.getWrongByQuestionAndUser(qid, uid) > 0) {
            return false;
        }else{
            return true;
        }
    }

    public void saveWrong(Long qid, Long uid) {
        questionDao.saveWrong(qid, uid);
    }

    public boolean hasCollected(Long qid, Long uid) {
        if(questionDao.hasCollected(qid,uid) > 0){
            return true;
        }else{
            return false;
        }
    }

    public boolean saveCollection(Long qid, Long uid) {
        if(questionDao.saveCollection(qid,uid) > 0){
            return true;
        }else{
            return false;
        }
    }

    public boolean deleteCollection(Long qid, Long uid) {
        if(questionDao.deleteCollection(qid,uid) > 0){
            return true;
        }else{
            return false;
        }
    }

    public List<Map<String, Object>> getWrongsByItemAndUser(Long itemId, Long uid) {
        return questionDao.getWrongsByItemAndUser(itemId,uid);
    }

    public List<Map<String, Object>> getCollectionsByItemAndUser(Long itemId, Long uid) {
        return questionDao.getCollectionsByItemAndUser(itemId,uid);
    }

    public List<Map<String, Object>> getSpecialQuestionsByItemAndPoint(Long itemId, String point) {
        return questionDao.getSpecialQuestionsByItemAndPoint(itemId, point);
    }

    public List<Map<String, Object>> getCommentsBuQuestion(Long qid) {
        return questionDao.getCommentsBuQuestion(qid);
    }

    public boolean saveComment(Long question, Long user, String content) {
        if(questionDao.saveComment(question, user, content)>0){
            return true;
        }else{
            return false;
        }
    }

    public List<Map<String, Object>> getExamQuestions(ItemBank itemBank) {
        List<Point> points = pointDao.getPointByItemId(itemBank.getId());
        Integer singtotal = questionDao.getCountByItemAndType(itemBank.getId(),"单选题");
        Integer multotal = questionDao.getCountByItemAndType(itemBank.getId(),"多选题");
        if(singtotal < itemBank.getSingnum() || multotal < itemBank.getMultnum()){
            return null;
        }
        return makePaper(points,itemBank,singtotal,multotal);
    }

    /**
     * 判断生成的模拟试卷是否有重复的题目，有则重新生成
     * @param points
     * @param itemBank
     * @param singtotal
     * @param multotal
     * @return
     */
    public List<Map<String, Object>> makePaper(List<Point> points,ItemBank itemBank,Integer singtotal,Integer multotal){
        List<Map<String, Object>> questions = new ArrayList<Map<String, Object>>();
        for(int i = 0; i< points.size(); i++){
            Integer singnum = questionDao.getCountByItemAndPointAndType(itemBank.getId(),"%"+points.get(i).getName()+"%","单选题");
            Integer multnum = questionDao.getCountByItemAndPointAndType(itemBank.getId(),"%"+points.get(i).getName()+"%","多选题");
            singnum = Integer.parseInt(PercentUtil.calculate(singnum, singtotal, itemBank.getSingnum()));
            multnum = Integer.parseInt(PercentUtil.calculate(multnum, multotal, itemBank.getMultnum()));
            List<Map<String, Object>> singpart = questionDao.getQuestionByItemAndPointAndType(itemBank.getId(),"%"+points.get(i).getName()+"%","单选题");
            List<Map<String, Object>> multpart = questionDao.getQuestionByItemAndPointAndType(itemBank.getId(),"%"+points.get(i).getName()+"%","多选题");
            Collections.shuffle(singpart);
            Collections.shuffle(multpart);
            questions.addAll(singpart.subList(0,singnum));
            questions.addAll(multpart.subList(0,multnum));
        }
        if(questions.size() == new HashSet(questions).size()){
            return questions;
        }else{
            return makePaper(points,itemBank,singtotal,multotal);
        }
    }

    public List<Map<String, Object>> getDiffQuestionsByItem(Long itemId) {
        return questionDao.getDiffQuestionsByItem(itemId);

    }

    public int getWrongCountByPointAndUser(String point, Long user) {
        return questionDao.getWrongCountByPointAndUser(point, user);
    }

    public int getCountByDrivertypeAndType(String name,Long type) {
        return questionDao.getCountByDrivertypeAndType(name,type);
    }


}
