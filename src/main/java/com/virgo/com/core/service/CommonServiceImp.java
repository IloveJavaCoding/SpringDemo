package com.virgo.com.core.service;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public class CommonServiceImp <M extends BaseMapper<T>, T> extends ServiceImpl<M, T> implements ICommonService<T> {

}
