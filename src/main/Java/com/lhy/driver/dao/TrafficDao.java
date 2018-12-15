package com.lhy.driver.dao;

import com.lhy.driver.pojo.TrafficContent;
import com.lhy.driver.pojo.TrafficMenu;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by lhy on 2017/3/6.
 */
@Repository
public interface TrafficDao {

    List<TrafficMenu> getMenuByPIdIsNull();

    List<TrafficMenu> getMenuByPId(Long pid);

    int addTrafficMenu(TrafficMenu trafficMenu);

    int updateTrafficMenu(TrafficMenu trafficMenu);

    int deleteTrafficMenu(Long id);

    TrafficContent findContentByTId(Long tid);

    int saveTrafficContent(TrafficContent trafficContent);

    int updateTrafficContent(TrafficContent trafficContent);
}
