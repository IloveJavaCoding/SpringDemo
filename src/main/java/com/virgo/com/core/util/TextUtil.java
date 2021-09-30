package com.virgo.com.core.util;

/**
 * 文本处理工具类
 */
public class TextUtil {
    public static final String[] IMAGE_EXTENSION = {"bmp", "gif", "jpg", "jpeg", "png"};
    public static final String[] VIDEO_EXTENSION = {"swf", "flv", "mp4", "wma", "3gp", "wmv", "mpeg", "mid", "avi", "mpg", "asf", "rmvb"};
    public static final String[] AUDIO_EXTENSION = {"mp3", "wav", "acc", "ogg", "flac", "ncm"};
    public static final String[] TEXT_EXTENSION = { "doc", "docx", "xls", "xlsx", "ppt", "pptx", "html", "htm", "txt"};
    public static final String[] MEDIA_EXTENSION = {"swf", "flv", "mp4", "mp3", "wav", "wma", "3gp", "wmv", "mpeg", "mid", "avi", "mpg", "asf", "rmvb"};
    public static final String[] DEFAULT_ALLOWED_EXTENSION = {
            // 图片
            "bmp", "gif", "jpg", "jpeg", "png",
            // word excel powerpoint
            "doc", "docx", "xls", "xlsx", "ppt", "pptx", "html", "htm", "txt",
            // 压缩文件
            "rar", "zip", "gz", "bz2",
            // pdf
            "pdf"};


    public static final int MEDIA_ALL = 0;
    public static final int MEDIA_IAMGE = 1;
    public static final int MEDIA_AUDIO = 2;
    public static final int MEDIA_VIDEO = 3;
    public static final int MEDIA_TEXT = 4;

    /**
     * 判断字符非空
     * @param str
     * @return
     */
    public static boolean isEmpty(String str){
        return str == null || ("").equals(str);
    }

    public static boolean isEqual(String str, String str2){
        return str.equals(str2);
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
     * 从文件路径中获取完整文件名 最后一个"/" -- 后缀名
     * @param path
     * @return
     */
    public static String getFileNameWithSuffix(String path){
        if(TextUtil.isEmpty(path))
            return path;

        if(path.contains("/")){
            int index = path.lastIndexOf("/");
            return path.substring(index + 1);
        }

        return path;
    }

    /**
     * 仅获取文件名， 无后缀
     * @param path
     * @return
     */
    public static String getFileName(String path){
        if(TextUtil.isEmpty(path))
            return path;

        String name = path;
        if(path.contains("/")){
            int index = path.lastIndexOf("/");
            name = path.substring(index + 1);
        }

        if(path.contains(".")){
            int dot = path.lastIndexOf('.');
            name = path.substring(0, dot);
        }
        return name;
    }

    /**
     * 获取文件后缀名 无"."
     * @param path
     * @return
     */
    public static String getFileSuffix(String path){
        if(TextUtil.isEmpty(path))
            return path;

        if(path.contains(".")){
            int dot = path.lastIndexOf('.');
            return path.substring(dot+1).toLowerCase();
        }
        return path;
    }

    /**
     * 获取文件后缀名 y有"."
     * @param path
     * @return
     */
    public static String getFileSuffixDot(String path){
        if(TextUtil.isEmpty(path))
            return path;

        if(path.contains(".")){
            int dot = path.lastIndexOf('.');
            return path.substring(dot).toLowerCase();
        }
        return path;
    }

    /**
     * 分析后缀名所对应的类型
     * @param suffix
     * @return
     */
    public static int getTypeFromSuffix(String suffix) {
        if(TextUtil.isEmpty(suffix))
            return -1;

        for(String str: IMAGE_EXTENSION){
            if(suffix.equals(str)){
                return MEDIA_IAMGE;
            }
        }

        for(String str: AUDIO_EXTENSION){
            if(suffix.equals(str)){
                return MEDIA_AUDIO;
            }
        }

        for(String str: VIDEO_EXTENSION){
            if(suffix.equals(str)){
                return MEDIA_VIDEO;
            }
        }

        for(String str: TEXT_EXTENSION){
            if(suffix.equals(str)){
                return MEDIA_TEXT;
            }
        }

        return MEDIA_ALL;
    }
}
