package com.virgo.com.pc.service;

import com.virgo.com.core.service.ICommonService;
import com.virgo.com.pc.entity.Account;

/**
 * 用户操作接口
 */
public interface IUserService extends ICommonService<Account> {
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
    Account findUserByName(String username);
}
