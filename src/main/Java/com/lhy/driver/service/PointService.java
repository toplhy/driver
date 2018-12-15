package com.lhy.driver.service;

import com.lhy.driver.pojo.Point;

import java.util.List;
import java.util.Map;

/**
 * Created by lhy on 2017/3/18.
 */
public interface PointService {
    Integer getPointCount(String name, Long ibid);

    List<Map<String,Object>> getPointList(String name, Long ibid,Integer begin, Integer size);

    Point getPointById(Long id);

    boolean savePoint(Point point);

    boolean updatePoint(Point point);

    boolean deletePoint(String ids);

    List<Point> getPointByItemId(Long ibid);
}
