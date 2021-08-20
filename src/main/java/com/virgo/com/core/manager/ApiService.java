package com.virgo.com.core.manager;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * created by Virgo on 2021/1/2
 * usage:
 */
public class ApiService {
    public static final String TABLE_ACCOUNT = "Account";

    //登入
    public static boolean login(String username, String password) {
        String sql = "select * from " + TABLE_ACCOUNT + " where username ='" + username + "' and password ='" + password + "'";
        DBManager dbManager = DBManager.getInstance();
        dbManager.connectDB();

        ResultSet rs = dbManager.exeQuery(sql);
        try {
            if (rs.next()) {
                // 匹配成功
                dbManager.closeDB();
                return true;
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return false;
    }

    //注册
    public static boolean register(String username, String password, String eMail) {
        String sql = "select * from " + TABLE_ACCOUNT + " where username='" + username + "'";
        DBManager dbManager = DBManager.getInstance();
        dbManager.connectDB();

        ResultSet rs = dbManager.exeQuery(sql);
        try {
            if (rs.next()) {
                // 匹配成功
                System.out.println("用户已存在！");
                return false;
            }
            String sql2 = "insert into " + TABLE_ACCOUNT + " (username,password,email) values('" + username + "','" + password + "','" + eMail + "')";
            int result = dbManager.exeUpdate(sql2);
            dbManager.closeDB();
            return result != 0;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        dbManager.closeDB();
        return false;
    }

    //修改密码
    public static boolean updatePassword(String username, String newPassword) {
        String sql = "update " + TABLE_ACCOUNT + " set password='" + newPassword + "' where username='" + username + "'";

        DBManager dbManager = DBManager.getInstance();
        dbManager.connectDB();

        int result = dbManager.exeUpdate(sql);
        dbManager.closeDB();

        return result != 0;
    }
}