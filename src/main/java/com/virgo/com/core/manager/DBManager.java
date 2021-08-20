package com.virgo.com.core.manager;

import java.sql.*;

/**
 * : 数据库连接 表格增删改查
 * @author Administrator
 *
 */
public class DBManager {
	// 数据库连接常量
    public static final String USERNAME = "root";
    public static final String PASSWORD = "root";
    public static final String DATABASE_NAME = "SpringDemo";
    public static final String URL = "jdbc:mysql://localhost:3306/"+DATABASE_NAME+"?serverTimezone=GMT%2B8";
    
    // 静态成员 支持单态模式
    private static DBManager instance = null;
    private Connection connection = null;//连接数据库
    private Statement statement = null;//用于执行sql命令

    // 单例模式
    public static DBManager getInstance() {
    	if(instance==null) {
    		synchronized (DBManager.class) {
    			if(instance==null) {
    				instance = new DBManager();
    			}
			}
    	}
    	return instance;
    }
    
    private DBManager() {
        // 加载驱动
    	try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    /////////////////////////////////////////////////////
    //1. 连接数据库
    public void connectDB() {
    	System.out.println("Connecting to database...");
        try {
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            statement = connection.createStatement();
            System.out.println("Connect successfully");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //2. 关闭连接
    public void closeDB() {
    	System.out.println("Close connection ...");
        try {
            statement.close();
            connection.close();
            System.out.println("Close successfully");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //3. 查询操作 -> 返回查询结果
    public ResultSet exeQuery(String sql) {
        System.out.println(sql);
    	ResultSet rs = null;
    	try {
            rs = statement.executeQuery(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    //3. 查询操作 -> 返回查询结果
    //return: (1) the row count for SQL Data Manipulation Language (DML) statements 
    //		  (2) 0 for SQL statements that return nothing
    public int exeUpdate(String sql) {
        int result = 0;
        try {
        	result = statement.executeUpdate(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    //用于调试 判断自己连接是否有问题
//  	public static void main(String[] args){
//  		DBManager dbManager = DBManager.getInstance();
//  		dbManager.connectDB();
//
////  		String sql = "select * from Account";
//        String sql = "select * from Account where username ='virgo' and password ='virgo142857'";
//  		ResultSet rs = dbManager.exeQuery(sql);
//  		try {
//			while(rs.next()) {
//				System.out.println(rs.getInt("id") + ": " + rs.getString("username") + "\t" + rs.getString("password"));
//			}
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//  	}
}
