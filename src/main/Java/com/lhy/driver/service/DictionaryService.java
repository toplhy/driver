package com.lhy.driver.service;

import com.lhy.driver.pojo.Dictionary;

import java.util.List;

/**
 * Created by lhy on 2017/3/21.
 */
public interface DictionaryService {
    List<Dictionary> getDicByCode(String stlx);

    Dictionary getDicById(Long drivertype);
}
