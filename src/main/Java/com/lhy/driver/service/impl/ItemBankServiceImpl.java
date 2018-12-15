package com.lhy.driver.service.impl;

import com.lhy.driver.dao.ItemBankDao;
import com.lhy.driver.pojo.ItemBank;
import com.lhy.driver.service.ItemBankService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * Created by lhy on 2017/3/12.
 */
@Service
public class ItemBankServiceImpl implements ItemBankService{

    @Autowired
    private ItemBankDao itemBankDao;

    public List<ItemBank> getItemBankList(Integer begin, Integer size) {
        return itemBankDao.getItemBankList(begin,size);
    }

    public Integer getItemBankCount() {
        return itemBankDao.getCount();
    }

    public boolean saveItembank(ItemBank itemBank) {
        if(itemBankDao.saveItemBank(itemBank)>0){
            return true;
        }else{
            return false;
        }
    }

    public ItemBank getItemBankById(Long id) {
        return itemBankDao.getItemBankById(id);
    }

    public boolean updateItembank(ItemBank itemBank) {
        if(itemBankDao.updateItembank(itemBank)>0){
            return true;
        }else{
            return false;
        }
    }

    @Transactional
    public boolean deleteItemBank(String ids) {
        String[] idlist = ids.split(",");
        for (String id: idlist) {
            itemBankDao.deleteItemBank(Long.parseLong(id));
        }
        return true;
    }

    public List<ItemBank> getItemBankByType(String drivertype) {
        return itemBankDao.getItemBankByType(drivertype);
    }
}
