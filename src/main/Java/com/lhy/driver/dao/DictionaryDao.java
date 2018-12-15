package com.lhy.driver.dao;

import com.lhy.driver.pojo.Dictionary;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by lhy on 2017/3/12.
 */
@Repository
public interface DictionaryDao {
    List<Dictionary> getDicByCode(String stlx);

    Dictionary getDicById(Long id);

    Dictionary getDicByNameAndCode(@Param("name")String name, @Param("code")String code);
}
