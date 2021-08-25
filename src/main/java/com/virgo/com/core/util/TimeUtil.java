package com.virgo.com.core.util;

import org.apache.commons.lang.time.DateFormatUtils;

import java.util.Date;

public class TimeUtil {
    public static final String DATE_FORMAT_YMD = "yyyy/MM/dd";
    public static final String DATE_FORMAT_YMDHM = "yyyy-MM-dd HH:mm";

    /**
     * 获取指定格式的当前时间、日期的字符串
     * @param pattern
     * @return
     */
    public static String getStringDateNow(String pattern){
        Date now = new Date();
        return DateFormatUtils.format(now, pattern);
    }
}
