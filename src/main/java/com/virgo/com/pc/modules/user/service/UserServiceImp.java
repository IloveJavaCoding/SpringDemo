package com.virgo.com.pc.modules.user.service;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.virgo.com.core.data.Constants;
import com.virgo.com.core.service.CommonServiceImp;
import com.virgo.com.core.util.LogUtil;
import com.virgo.com.core.util.TextUtil;
import com.virgo.com.pc.modules.user.entity.User;
import com.virgo.com.pc.modules.user.mapper.UserMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * 用户接口实现类
 */
@Service("userService")
@Transactional
public class UserServiceImp extends CommonServiceImp<UserMapper, User> implements IUserService{
    private static final String TAG = "UserServiceImp";

    @Override
    public boolean isExist(String username) {
        if (TextUtil.isEmpty(username)) {
            return false;
        }
        EntityWrapper<User> wrapper = new EntityWrapper<>();
        wrapper.eq("username", username);
        return selectOne(wrapper)!=null;
    }

    @Override
    public boolean checkLogin(String username, String password) {
        if (TextUtil.isEmpty(username)) {
            return false;
        }
        EntityWrapper<User> wrapper = new EntityWrapper<>();
        wrapper.eq("username", username);
        wrapper.and();
        wrapper.eq("password", password);
        return selectOne(wrapper)!=null;
    }

    @Override
    public User findUserByName(String username) {
        if (TextUtil.isEmpty(username)) {
            return null;
        }
        return selectOne(new EntityWrapper<User>().eq("username", username));
    }

    @Override
    public List<User> selectAllUser() {
//        EntityWrapper<User> wrapper = new EntityWrapper<>();
//        wrapper.ge("id",-1);

        return selectList(new EntityWrapper<User>().isNotNull("id"));
    }

    @Override
    public int allPageNum() {
        List<User> list = selectAllUser();
        if(list==null || list.isEmpty()){
            return 0;
        }else{
            LogUtil.debug("all list size: " + list.size());
            return list.size()%Constants.PAGE_MAX_NUM==0?list.size()/Constants.PAGE_MAX_NUM:list.size()/Constants.PAGE_MAX_NUM + 1;
        }
    }

    @Override
    public List<User> selectUserByPage(int page) {
        List<User> all = selectAllUser();
        //判断page是否有效
        if(all!=null && !all.isEmpty()){
            if(page<1){
                page=1;
            }
            int size = all.size();
            int startIndex = (page-1)* Constants.PAGE_MAX_NUM;
            int endIndex = page*Constants.PAGE_MAX_NUM;
            if(endIndex>size){
                endIndex = size;
            }
            if(size>startIndex){
                List<User> out = new ArrayList<>();
                for(int i=startIndex; i<endIndex; i++){
                    out.add(all.get(i));
                }

                return out;
            }
        }

        return null;
    }

    @Override
    public Page<User> selectPage(Page<User> page, Wrapper<User> wrapper) {
        wrapper.eq("1", "1");
        page.setRecords(baseMapper.selectUserList(page, wrapper));
        return page;
    }
}
