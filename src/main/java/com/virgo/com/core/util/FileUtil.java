package com.virgo.com.core.util;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;

/**
 * 文件，资源处理工具类
 */
public class FileUtil {

    /**
     * 判断是否为绝对路径
     * @param path
     * @return
     */
    public static boolean isAbsolutePath(String path) {
        return path.startsWith("/") || path.indexOf(":") > 0;
    }

    /**
     * 获取文件绝对路径
     * @param path
     * @return
     */
    public static String getAbsolutePath(String path) {
        if (!isAbsolutePath(path)) {
            try {
                path = FileUtil.class.getClassLoader().getResource(path).toURI().getPath();
            } catch (URISyntaxException e) {
                e.printStackTrace();
            }
        }
        return path;
    }

    // 创建单个文件
    public static boolean createFile(String filePath) {
        File file = new File(filePath);
        if (file.exists()) {// 判断文件是否存在
            //System.out.println("目标文件已存在" + filePath);
            return false;
        }
        if (filePath.endsWith(File.separator)) {// 判断文件是否为目录
            //System.out.println("目标文件不能为目录！");
            return false;
        }
        if (!file.getParentFile().exists()) {// 判断目标文件所在的目录是否存在
            // 如果目标文件所在的文件夹不存在，则创建父文件夹
            //System.out.println("目标文件所在目录不存在，准备创建它！");
            if (!file.getParentFile().mkdirs()) {// 判断创建目录是否成功
                //System.out.println("创建目标文件所在的目录失败！");
                return false;
            }
        }
        try {
            // 创建目标文件
            //System.out.println("创建文件成功:" + filePath);
            //System.out.println("创建文件失败！");
            return file.createNewFile();
        } catch (IOException e) {// 捕获异常
            e.printStackTrace();
            //System.out.println("创建文件失败！" + e.getMessage());
            return false;
        }
    }
}
