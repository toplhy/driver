package com.lhy.driver.service.impl;

import com.lhy.driver.dao.PointDao;
import com.lhy.driver.pojo.Point;
import com.lhy.driver.service.PointService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by lhy on 2017/3/18.
 */
@Service
public class PointServiceImpl implements PointService {

    @Autowired
    private PointDao pointDao;

    public Integer getPointCount(String name, Long ibid) {
        return pointDao.getPointCount(name,ibid);
    }

    public List<Map<String, Object>> getPointList(String name, Long ibid, Integer begin, Integer size) {
        return pointDao.getPointList(name,ibid, begin, size);
    }

    public Point getPointById(Long id) {
        return pointDao.getPointById(id);
    }

    public boolean savePoint(Point point) {
        return pointDao.savePoint(point);
    }

    public boolean updatePoint(Point point) {
        return pointDao.updatePoint(point);
    }

    public boolean deletePoint(String ids) {
        String[] idlist = ids.split(",");
        for (String id: idlist) {
            pointDao.deletePoint(Long.parseLong(id));
        }
        return true;
    }

    public List<Point> getPointByItemId(Long ibid) {
        return pointDao.getPointByItemId(ibid);
    }
}
