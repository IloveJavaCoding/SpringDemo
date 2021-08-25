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
    public int allPageNum() {
        List<T> list = selectAll();
        return getPageNum(list);
    }

    private int getPageNum(List<T> list) {
        if(list==null || list.isEmpty()){
            return 0;
        }else{
            LogUtil.debug("all list size: " + list.size());
            return list.size()% Constants.PAGE_MAX_NUM==0?list.size()/Constants.PAGE_MAX_NUM:list.size()/Constants.PAGE_MAX_NUM + 1;
        }
    }

    @Override
    public int allPageNum(EntityWrapper<T> wrapper) {
        List<T> list = selectList(wrapper);
        return getPageNum(list);
    }

    @Override
    public List<T> selectAll() {
        return selectList(new EntityWrapper<T>().isNotNull("id"));
    }

    @Override
    public List<T> selectByPage(int page) {
        List<T> all = selectAll();
        return getPage(page, all);
    }

    private List<T> getPage(int page, List<T> all) {
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
        return getPage(page, all);
    }
}
