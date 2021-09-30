package com.virgo.com.core.service;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.IService;

import java.util.List;

public interface ICommonService<T> extends IService<T> {
    /**
     * 总行数: 无筛选
     * @return 总行数
     */
    int allRecordsNum();

    /**
     * 总页数: 无筛选
     * @return 总页数
     */
    int allPageNum(int rowNum);

    /**
     * 总页数: 有筛选
     * @return 总页数
     */
    int allPageNum(int rowNum, EntityWrapper<T> wrapper);

    /**
     * 获取所有数据
     * @return 获取所有数据
     */
    List<T> selectAll();

    /**
     * 获取所有数据
     * @param sort 排序属性
     * @param order 排序方式
     * @return 获取所有数据
     */
    List<T> selectAll(String sort, String order);

    /**
     * 根据页数获取对应数据: 无筛选
     * @param page 页数
     * @return 根据页数获取对应数据
     */
    List<T> selectByPage(int page);

    /**
     * 根据页数获取对应数据: 无筛选
     * @param page 页数
     * @param num 每页个数
     * @return 根据页数获取对应数据
     */
    List<T> selectByPage(int page, int num);

    /**
     * 根据页数获取对应数据: 无筛选
     * @param page 页数
     * @param num 每页个数
     * @param sort 排序属性
     * @param order 排序方式
     * @return 根据页数获取对应数据
     */
    List<T> selectByPage(int page, int num, String sort, String order);

    /**
     * 根据页数获取对应数据: 有筛选
     * @param page 页数
     * @return 根据页数获取对应数据
     */
    List<T> selectByPage(int page, EntityWrapper<T> wrapper);
}