package com.lhy.driver.utils;

import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.text.NumberFormat;

/**
 * Created by lhy on 2017/4/29.
 */
public class PercentUtil {

    /**
     * 计算每一个知识点在试卷中的试题数目
     * @param num
     * @param total
     * @param standard
     * @return
     */
    public static String calculate( int num, int total,int standard){
        DecimalFormat df = (DecimalFormat) NumberFormat.getInstance();
        df.setMaximumFractionDigits(0);
        df.setRoundingMode(RoundingMode.HALF_UP);
//        return df.format(accuracy_num);
        return df.format((double)num/total*standard);
    }
}
