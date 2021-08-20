package com.virgo.com.core.util;

/**
 * 文本处理工具类
 */
public class TextUtil {
    /**
     * 判断字符非空
     * @param str
     * @return
     */
    public static boolean isEmpty(String str){
        return str == null || ("").equals(str);
    }

    /**
     * 用某字符连接多个字符串
     * @param separate
     * @param param
     * @return
     */
    public static String joinStrs(String separate, String ... param){
        if(separate==null || param.length<=0){
            return null;
        }

        StringBuilder builder = new StringBuilder();
        int index = 0;
        int len = param.length - 1;
        while (index<len){
            builder.append(param[index]).append(separate);
            index++;
        }

        builder.append(param[len]);
        return builder.toString();
    }

    /**
     * 获取文件后缀名
     * @param filename
     * @return
     */
    public static String getExtensionName(String filename) {
        if ((filename != null) && (filename.length() > 0)) {
            int dot = filename.lastIndexOf('.');
            if ((dot > -1) && (dot < (filename.length() - 1))) {
                return filename.substring(dot + 1).toLowerCase();
            }
        }
        return filename;
    }
}
