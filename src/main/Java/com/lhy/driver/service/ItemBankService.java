package com.lhy.driver.service;

import com.lhy.driver.pojo.ItemBank;

import java.util.List;
import java.util.Map;

/**
 * Created by lhy on 2017/3/12.
 */
public interface ItemBankService {
    List<ItemBank> getItemBankList(Integer begin, Integer size);

    Integer getItemBankCount();

    boolean saveItembank(ItemBank itemBank);

    ItemBank getItemBankById(Long id);

    boolean updateItembank(ItemBank itemBank);

    boolean deleteItemBank(String ids);

    List<ItemBank> getItemBankByType(String drivertype);
}
