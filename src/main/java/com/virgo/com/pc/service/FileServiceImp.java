package com.virgo.com.pc.service;

import com.virgo.com.core.service.CommonServiceImp;
import com.virgo.com.pc.entity.Miniofile;
import com.virgo.com.pc.mapper.MiniofileMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 上传文件管理
 */
@Service("fileService")
@Transactional
public class FileServiceImp extends CommonServiceImp<MiniofileMapper, Miniofile> implements IFileService {
}
