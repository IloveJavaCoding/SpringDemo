package com.virgo.com.core.util;

public class LogUtil {

    public static boolean isDebuggable() {
        return true;
    }

    public static void debug(String msg) {
        System.out.println(msg);
    }

    public static void debug(String tag, String msg) {
        System.out.println(tag + " --- " + msg);
    }

    public static void info(String msg) {

    }

    public static void info(String tag, String msg) {

    }

    public static void warn(String msg) {

    }

    public static void warn(String tag, String msg) {

    }

    public static void error(String msg) {

    }

    public static void error(String tag, String msg) {

    }

    public static void error(String tag, String msg, Throwable throwable) {

    }
}
