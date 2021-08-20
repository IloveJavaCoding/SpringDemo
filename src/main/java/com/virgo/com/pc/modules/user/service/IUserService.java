package com.virgo.com.pc.modules.user.service;

import com.virgo.com.core.service.ICommonService;
import com.virgo.com.pc.modules.user.entity.User;

import java.util.List;

/**
 * 用户操作接口
 */
public interface IUserService extends ICommonService<User> {
    /**
     * 判断用户是否存在
     * @param username
     * @return
     */
    boolean isExist(String username);

    /**
     * 判断用户密码是否匹配
     * @param username
     * @param password
     * @return
     */
    boolean checkLogin(String username, String password);

    /**
     * 通过用户名查找对应用户信息
     * @param username
     * @return
     */
    User findUserByName(String username);

    /**
     * 获取所有用户
     * @return
     */
    List<User> selectAllUser();

    /**
     * 总页数
     * @return
     */
    int allPageNum();

    /**
     * 根据页数获取对应用户
     * @param page
     * @return
     */
    List<User> selectUserByPage(int page);
}
