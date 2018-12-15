package com.lhy.driver.service;

import com.lhy.driver.pojo.ExamHistory;
import com.lhy.driver.pojo.ItemBank;
import com.lhy.driver.pojo.Question;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by lhy on 2017/3/29.
 */
public interface QuestionService {

    boolean saveQuestion(Question question);

    Integer getQuestionCount(Long type, Long ibid);

    List<Map<String,Object>> getQuestionList(Long type, Long ibid, int page, int size);

    Map<String,Object> getQuestionById(Long id);

    boolean delQuestion(String ids);

    Map<String,Object> exportQuestion(String ids, HttpServletRequest request);

    boolean updateQuestion(Question question);

    boolean importQuestion(List<List<Object>> list);

    List<Map<String,Object>> getRandomQuestionsByItem(Long itemId);

    boolean getWrongByQuestionAndUser(Long qid, Long id);

    void saveWrong(Long qid, Long id);

    boolean hasCollected(Long qid, Long uid);

    boolean saveCollection(Long qid, Long uid);

    boolean deleteCollection(Long qid, Long uid);

    List<Map<String,Object>> getWrongsByItemAndUser(Long itemId, Long uid);

    List<Map<String,Object>> getCollectionsByItemAndUser(Long itemId, Long uid);

    List<Map<String,Object>> getSpecialQuestionsByItemAndPoint(Long itemId, String point);

    List<Map<String,Object>> getCommentsBuQuestion(Long qid);

    boolean saveComment(Long question, Long user, String content);

    List<Map<String,Object>> getExamQuestions(ItemBank itemBank);

    List<Map<String,Object>> getDiffQuestionsByItem(Long itemId);

    int getWrongCountByPointAndUser(String point, Long user);

    int getCountByDrivertypeAndType(String name,Long type);

}
