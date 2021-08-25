package com.virgo.com.core.service;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.IService;

import java.util.List;

public interface ICommonService<T> extends IService<T> {
    /**
     * 总页数: 无筛选
     * @return
     */
    int allPageNum();

    /**
     * 总页数: 有筛选
     * @return
     */
    int allPageNum(EntityWrapper<T> wrapper);

    /**
     * 获取所有数据
     * @return
     */
    List<T> selectAll();

    /**
     * 根据页数获取对应数据: 无筛选
     * @param page
     * @return
     */
    List<T> selectByPage(int page);

    /**
     * 根据页数获取对应数据: 有筛选
     * @param page
     * @return
     */
    List<T> selectByPage(int page, EntityWrapper<T> wrapper);

}