package com.virgo.com.pc.modules.user.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.virgo.com.pc.modules.user.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper extends BaseMapper<User> {

    /**
     * 查找用户列表
     * @param page
     * @param wrapper
     * @return
     */
    List<User> selectUserList(Pagination page, @Param("ew") Wrapper<User> wrapper);
}
