package com.lhy.driver.service;

import com.lhy.driver.pojo.TrafficContent;
import com.lhy.driver.pojo.TrafficMenu;

import java.util.List;

/**
 * Created by lhy on 2017/3/7.
 */
public interface TrafficService {
    List<TrafficMenu> getMenuByPIdIsNull();

    List<TrafficMenu> getMenuByPId(Long pid);

    boolean addTrafficMenu(TrafficMenu trafficMenu);

    boolean updateTrafficMenu(TrafficMenu trafficMenu);

    boolean deleteTrafficMenu(Long id);

    TrafficContent findContentByTId(Long tid);

    boolean saveTrafficContent(TrafficContent trafficContent);

    boolean updateTrafficContent(TrafficContent trafficContent);
}
