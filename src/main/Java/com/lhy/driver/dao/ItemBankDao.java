package com.lhy.driver.dao;

import com.lhy.driver.pojo.ItemBank;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by lhy on 2017/3/12.
 */
@Repository
public interface ItemBankDao {

    List<ItemBank> getItemBankList(@Param("begin") Integer begin, @Param("size") Integer size);

    Integer getCount();

    int saveItemBank(ItemBank itemBank);

    ItemBank getItemBankById(Long id);

    int updateItembank(@Param("itemBank")ItemBank itemBank);

    int deleteItemBank(Long id);

    ItemBank getItemBankByTypeAndName(@Param("drivertype")String drivertype, @Param("name")String name);

    List<ItemBank> getItemBankByType(String drivertype);
}
