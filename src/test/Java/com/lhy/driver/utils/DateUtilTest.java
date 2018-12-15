package com.lhy.driver.utils;

import org.junit.Assert;
import org.junit.Test;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by lhy on 2017/4/15.
 */
public class DateUtilTest {

    @Test
    public void getLast12MonthsTest(){
        String[] actual = DateUtil.getLast12Months(6);
        String[] expected = {"2016-12","2017-1","2017-2","2017-3","2017-4","2017-5"};
        Assert.assertArrayEquals(actual,expected);
    }

    @Test
    public void addMonthTest() throws ParseException {
        Date actual = DateUtil.addMonth("2017-4");
        Date expected = new SimpleDateFormat("yyyy-MM").parse("2017-5");
        Assert.assertEquals(expected,actual);
    }
}
