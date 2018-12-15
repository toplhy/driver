package com.lhy.driver.dao;

import com.lhy.driver.pojo.Point;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by lhy on 2017/3/18.
 */
@Repository
public interface PointDao {

    Integer getPointCount(@Param("name") String name, @Param("ibid") Long ibid);

    List<Map<String,Object>> getPointList(@Param("name") String name, @Param("ibid") Long ibid,@Param("begin") Integer begin, @Param("size") Integer size);

    Point getPointById(Long id);

    boolean savePoint(Point point);

    boolean updatePoint(@Param("point") Point point);

    boolean deletePoint(Long id);

    List<Point> getPointByItemId(Long ibid);

}
