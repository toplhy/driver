package com.lhy.driver.utils;

import org.junit.Assert;
import org.junit.Test;

/**
 * Created by lhy on 2017/4/29.
 */
public class PercentUtilTest {

    @Test
    public void calculateTest(){
        String actual = PercentUtil.calculate(6,21,20);
        Assert.assertEquals(actual,"6");
    }

}
