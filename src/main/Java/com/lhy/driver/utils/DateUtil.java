package com.lhy.driver.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by lhy on 2017/4/6.
 */
public class DateUtil {

    /**
     * 得到近index月
     * @param index
     * @return
     */
    public static String[] getLast12Months(int index){
        String[] last12Months = new String[index];
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.MONTH, cal.get(Calendar.MONTH)+1); //要先+1,才能把本月的算进去</span>
        for(int i=0; i<index; i++){
            cal.set(Calendar.MONTH, cal.get(Calendar.MONTH)-1); //逐次往前推1个月
            last12Months[(index-1)-i] = cal.get(Calendar.YEAR)+ "-" + (cal.get(Calendar.MONTH)+1);
        }
        return last12Months;
    }

    /**
     * 将传入的时间加一个月
     * @param datetime
     * @return
     * @throws ParseException
     */
    public static Date addMonth(String datetime) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
        Date dt = sdf.parse(datetime);
        Calendar rightNow = Calendar.getInstance();
        rightNow.setTime(dt);
        rightNow.add(Calendar.MONTH, 1);
        Date dt1 = rightNow.getTime();
        return dt1;
    }
}
