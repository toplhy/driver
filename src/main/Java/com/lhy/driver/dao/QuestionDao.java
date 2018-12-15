package com.lhy.driver.dao;

import com.lhy.driver.pojo.Question;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by lhy on 2017/3/29.
 */
@Repository
public interface QuestionDao {

    boolean saveQuestion(Question question);

    Integer getQuestionCount(@Param("type") Long type, @Param("ibid") Long ibid);

    List<Map<String,Object>> getQuestionList(@Param("type") Long type, @Param("ibid") Long ibid, @Param("page") int page, @Param("size") int size);

    Map<String,Object> getQuestionById(Long id);

    void deleteQuestion(long id);

    List<Map<String, Object>> exportQuestions(List<Long> ids);

    boolean updateQuestion(@Param("question") Question question);

    List<Map<String,Object>> getRandomQuestionsByItem(Long itemId);

    int getWrongByQuestionAndUser(@Param("qid")Long qid, @Param("uid")Long uid);

    void saveWrong(@Param("qid")Long qid, @Param("uid")Long uid);

    int hasCollected(@Param("qid")Long qid, @Param("uid")Long uid);

    Integer saveCollection(@Param("qid")Long qid, @Param("uid")Long uid);

    int deleteCollection(@Param("qid")Long qid, @Param("uid")Long uid);

    List<Map<String,Object>> getWrongsByItemAndUser(@Param("itemId")Long itemId, @Param("uid")Long uid);

    List<Map<String,Object>> getCollectionsByItemAndUser(@Param("itemId")Long itemId, @Param("uid")Long uid);

    List<Map<String,Object>> getSpecialQuestionsByItemAndPoint(@Param("itemId")Long itemId, @Param("point")String point);

    List<Map<String,Object>> getCommentsBuQuestion(Long qid);

    int saveComment(@Param("question")Long question, @Param("user")Long user, @Param("content")String content);

    Integer getCountByItemAndPointAndType(@Param("itemId")Long itemId, @Param("point")String point, @Param("type")String type);

    Integer getCountByItemAndType(@Param("itemId")Long itemId, @Param("type")String type);

    List<Map<String,Object>> getQuestionByItemAndPointAndType(@Param("itemId")Long itemId, @Param("point")String point, @Param("type")String type);

    List<Map<String,Object>> getDiffQuestionsByItem(Long itemId);

    int getWrongCountByPointAndUser(@Param("point")String point, @Param("user")Long user);

    int getCountByDrivertypeAndType(@Param("name")String name, @Param("type")Long type);
}
