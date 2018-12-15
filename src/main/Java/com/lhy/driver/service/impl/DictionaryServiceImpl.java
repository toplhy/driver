package com.lhy.driver.service.impl;

import com.lhy.driver.dao.DictionaryDao;
import com.lhy.driver.pojo.Dictionary;
import com.lhy.driver.service.DictionaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by lhy on 2017/3/21.
 */
@Service
public class DictionaryServiceImpl implements DictionaryService {

    @Autowired
    private DictionaryDao dictionaryDao;

    public List<Dictionary> getDicByCode(String stlx) {
        return dictionaryDao.getDicByCode(stlx);
    }

    public Dictionary getDicById(Long drivertype) {
        return dictionaryDao.getDicById(drivertype);
    }
}
