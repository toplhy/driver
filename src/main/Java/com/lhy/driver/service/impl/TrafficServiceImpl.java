package com.lhy.driver.service.impl;

import com.lhy.driver.dao.TrafficDao;
import com.lhy.driver.pojo.TrafficContent;
import com.lhy.driver.pojo.TrafficMenu;
import com.lhy.driver.service.TrafficService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by lhy on 2017/3/7.
 */
@Service
public class TrafficServiceImpl implements TrafficService {
    @Autowired
    private TrafficDao trafficDao;

    public List<TrafficMenu> getMenuByPIdIsNull() {
        return trafficDao.getMenuByPIdIsNull();
    }

    public List<TrafficMenu> getMenuByPId(Long pid) {
        return trafficDao.getMenuByPId(pid);
    }

    public boolean addTrafficMenu(TrafficMenu trafficMenu) {
        if(trafficDao.addTrafficMenu(trafficMenu)>0){
            return true;
        }else{
            return false;
        }
    }

    public boolean updateTrafficMenu(TrafficMenu trafficMenu) {
        if(trafficDao.updateTrafficMenu(trafficMenu)>0){
            return true;
        }else{
            return false;
        }
    }

    public boolean deleteTrafficMenu(Long id) {
        if(trafficDao.deleteTrafficMenu(id)>0){
            return true;
        }else{
            return false;
        }
    }

    public TrafficContent findContentByTId(Long tid) {
        return trafficDao.findContentByTId(tid);
    }

    public boolean saveTrafficContent(TrafficContent trafficContent) {
        if(trafficDao.saveTrafficContent(trafficContent)>0){
            return true;
        }else{
            return false;
        }
    }

    public boolean updateTrafficContent(TrafficContent trafficContent) {
        if(trafficDao.updateTrafficContent(trafficContent)>0){
            return true;
        }else{
            return false;
        }
    }

}
