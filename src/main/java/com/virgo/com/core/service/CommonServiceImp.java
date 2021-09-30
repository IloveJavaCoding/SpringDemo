package com.virgo.com.core.service;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.virgo.com.core.data.Constants;
import com.virgo.com.core.util.LogUtil;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Transactional
public class CommonServiceImp <M extends BaseMapper<T>, T> extends ServiceImpl<M, T> implements ICommonService<T> {

    @Override
    public int allRecordsNum() {
        List<T> list = selectAll();
        if(list==null || list.isEmpty()) {
            return 0;
        }else{
            return list.size();
        }
    }

    @Override
    public int allPageNum(int rowNum) {
        List<T> list = selectAll();
        return getPageNum(rowNum, list);
    }

    private int getPageNum(int rowNum, List<T> list) {
        if(list==null || list.isEmpty()){
            return 0;
        }else{
            LogUtil.debug("all list size: " + list.size());
            return list.size()% rowNum==0?list.size()/rowNum:list.size()/rowNum + 1;
        }
    }

    @Override
    public int allPageNum(int rowNum, EntityWrapper<T> wrapper) {
        List<T> list = selectList(wrapper);
        return getPageNum(rowNum, list);
    }

    @Override
    public List<T> selectAll() {
        return selectList(new EntityWrapper<T>().isNotNull("id"));
    }

    @Override
    public List<T> selectAll(String sort, String order) {
        EntityWrapper<T> wrapper = new EntityWrapper<>();
        wrapper.isNotNull("id");
        wrapper.orderBy(sort, "asc".equalsIgnoreCase(order));
        return selectList(wrapper);
    }

    @Override
    public List<T> selectByPage(int page) {
        List<T> all = selectAll();
        return getPage(page, all, Constants.PAGE_MAX_NUM);
    }

    @Override
    public List<T> selectByPage(int page, int num) {
        List<T> all = selectAll();
        return getPage(page, all, num);
    }

    @Override
    public List<T> selectByPage(int page, int num, String sort, String order) {
        List<T> all = selectAll(sort, order);
        return getPage(page, all, num);
    }

    private List<T> getPage(int page, List<T> all, int rowNum) {
        //判断page是否有效
        if(all!=null && !all.isEmpty()){
            if(page<1){
                page=1;
            }
            int size = all.size();
            int startIndex = (page-1)* rowNum;
            int endIndex = page*rowNum;
            if(endIndex>size){
                endIndex = size;
            }
            if(size>startIndex){
                List<T> out = new ArrayList<>();
                for(int i=startIndex; i<endIndex; i++){
                    out.add(all.get(i));
                }

                return out;
            }
        }

        return null;
    }

    @Override
    public List<T> selectByPage(int page, EntityWrapper<T> wrapper) {
        List<T> all = selectList(wrapper);
        return getPage(page, all, Constants.PAGE_MAX_NUM);
    }
}
