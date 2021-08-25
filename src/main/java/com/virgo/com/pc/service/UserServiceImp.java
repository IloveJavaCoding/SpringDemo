package com.virgo.com.pc.service;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.virgo.com.core.service.CommonServiceImp;
import com.virgo.com.core.util.TextUtil;
import com.virgo.com.pc.entity.Account;
import com.virgo.com.pc.mapper.AccountMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 用户接口实现类
 */
@Service("userService")
@Transactional
public class UserServiceImp extends CommonServiceImp<AccountMapper, Account> implements IUserService{
    private static final String TAG = "UserServiceImp";

    @Override
    public boolean isExist(String username) {
        if (TextUtil.isEmpty(username)) {
            return false;
        }
        EntityWrapper<Account> wrapper = new EntityWrapper<>();
        wrapper.eq("username", username);
        return selectOne(wrapper)!=null;
    }

    @Override
    public boolean checkLogin(String username, String password) {
        if (TextUtil.isEmpty(username)) {
            return false;
        }
        EntityWrapper<Account> wrapper = new EntityWrapper<>();
        wrapper.eq("username", username);
        wrapper.and();
        wrapper.eq("password", password);
        return selectOne(wrapper)!=null;
    }

    @Override
    public Account findUserByName(String username) {
        if (TextUtil.isEmpty(username)) {
            return null;
        }
        return selectOne(new EntityWrapper<Account>().eq("username", username));
    }
}
