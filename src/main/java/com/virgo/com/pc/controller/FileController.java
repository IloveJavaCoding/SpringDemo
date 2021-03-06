package com.virgo.com.pc.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.virgo.com.core.bean.GridResponse;
import com.virgo.com.core.bean.Response;
import com.virgo.com.core.data.Constants;
import com.virgo.com.core.util.FileUploadUtil;
import com.virgo.com.core.util.LogUtil;
import com.virgo.com.core.util.TextUtil;
import com.virgo.com.pc.bean.PcBaseControllerr;
import com.virgo.com.pc.entity.Miniofile;
import com.virgo.com.pc.service.IFileService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
@RequestMapping("/source")
public class FileController extends PcBaseControllerr {
    private static final String TAG = "FileController";

    @Autowired
    protected IFileService fileService;

    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    public void uploadFile(HttpServletResponse response, @RequestParam("file") MultipartFile file) {
        JSONObject jsonObject;
        LogUtil.debug(TAG, "filename: " + file.getOriginalFilename());
        try {
            Miniofile minioFile = FileUploadUtil.uploadFile(file);
            if(minioFile!=null){
                fileService.insert(minioFile);
                LogUtil.debug(TAG, minioFile.toString());
                jsonObject = Response.success("上传成功", minioFile.getUrl());
            }else{
                jsonObject = Response.fail("上传失败1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            jsonObject = Response.fail("上传失败2");
        }

        sendJsonResponse(response, jsonObject);
    }

    @RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
    @ResponseBody
    public String uploadFileHandler(@RequestParam("file") MultipartFile file) {
        if (!file.isEmpty()) {
            try {
                // 文件存放服务端的位置
                String rootPath = "E:/tmp";
                java.io.File dir = new java.io.File(rootPath + java.io.File.separator + "tmpFiles");
                if (!dir.exists())
                    dir.mkdirs();
                // 写文件到服务器
                java.io.File serverFile = new java.io.File(dir.getAbsolutePath() + java.io.File.separator + file.getOriginalFilename());
                file.transferTo(serverFile);
                return "You successfully uploaded file=" +  file.getOriginalFilename();
            } catch (Exception e) {
                return "You failed to upload " +  file.getOriginalFilename() + " => " + e.getMessage();
            }
        } else {
            return "You failed to upload " +  file.getOriginalFilename() + " because the file was empty.";
        }
    }

    @RequestMapping("/page_file")
    public void loadFile(HttpServletRequest request, HttpServletResponse response){
        String p = request.getParameter("page");
        String t = request.getParameter("type");
        LogUtil.debug(TAG, "page: " + p + ", type: " + t);
        //每页10条
        int page = Integer.parseInt(p);
        int type = Integer.parseInt(t);

        EntityWrapper<Miniofile> wrapper = new EntityWrapper<>();
        if(type==0){//所有
            wrapper.ge("type", type);
        }else{
            wrapper.eq("type", type);
        }

        int allPage = fileService.allPageNum(Constants.PAGE_MAX_NUM, wrapper);
        System.out.println("总页数：" + allPage);
        JSONObject object;
        if(page<=allPage){
            List<Miniofile> files = fileService.selectByPage(page, wrapper);
            if(files==null || files.isEmpty()){
                object = Response.fail("查询数据失败！");
            }else{
                JSONArray array = JSONArray.fromObject(files);
                object = Response.success(String.valueOf(allPage), array);
            }
        }else{
            object = Response.fail("页数超出！");
        }

        sendJsonResponse(response, object);
    }

    @RequestMapping("/all_file")
    public void loadAllFile(HttpServletResponse response){
        int allPage = fileService.allPageNum(Constants.PAGE_MAX_NUM);
        System.out.println("总页数：" + allPage);
        JSONObject object;
        List<Miniofile> files = fileService.selectAll();
        if(files==null || files.isEmpty()){
            object = Response.fail("查询数据失败！");
        }else{
            JSONArray array = JSONArray.fromObject(files);
            object = Response.success(String.valueOf(allPage), array);
        }

        sendJsonResponse(response, object);
    }

    @RequestMapping("/delete_file")
    public void deleteFile(HttpServletRequest request, HttpServletResponse response){
        String id = request.getParameter("id");
        LogUtil.debug(TAG, "file id: " + id);
        int uId = Integer.parseInt(id);

        Miniofile file = fileService.selectById(uId);
        JSONObject object;
        if(file==null){
            object = Response.fail("删除失败，未找到相关数据！");
        }else{
            boolean isOk = fileService.deleteById(uId);
            if(isOk){
                //删除数据库内资源
                boolean isFine = FileUploadUtil.deleteFile(file.getSavename());
                if(isFine){
                    object = Response.success("删除成功，等待刷新。");
                }else{
                    object = Response.success("删除成功，服务器内资源删除异常！");
                }
            }else{
                object = Response.fail("删除失败，请重试！");
            }
        }

        sendJsonResponse(response, object);
    }

    @RequestMapping("/download")
    public void downloadFile(HttpServletRequest request, HttpServletResponse response){
        String id = request.getParameter("id");
        String savePath = request.getParameter("savepath");

        int uId = Integer.parseInt(id);
        Miniofile file = fileService.selectById(uId);
        JSONObject object;
        if(file==null){
            object = Response.fail("下载失败，未找到相关资源！");
        }else{
            boolean isOk = FileUploadUtil.downloadFile(file.getSavename(), savePath);
            if(isOk){
                object = Response.success("下载成功！");
            }else{
                object = Response.fail("下载失败，请重试！");
            }
        }

        sendJsonResponse(response, object);
    }

    /////////////////////////////////////////////grid table//////////////////////////////////////////////
    @RequestMapping("/page_data")
    public void loadPageData(HttpServletRequest request, HttpServletResponse response){
        String p = request.getParameter("page");
        String num = request.getParameter("rows");
        String sort = request.getParameter("sidx");//排序
        String order = request.getParameter("sord");//asc 升序 desc 降序

        String filter = request.getParameter("_search");
        String search = request.getParameter("search");

        LogUtil.debug(TAG, "page: " + p + ", rownum " + num + ", sort: " + sort
                + ", order " + order + ", filter " + filter + ", search " + search);
        int page = Integer.parseInt(p);
        int rnum = Integer.parseInt(num);

        int allRecords = fileService.allRecordsNum();
        GridResponse res = new GridResponse();
        int allPage = allRecords% rnum==0?allRecords/rnum:allRecords/rnum + 1;
        res.setPage(page);
        res.setTotal(allPage);
        res.setRecords(allRecords);

        System.out.println("总行数：" + allRecords + " 总页数：" + allPage);
        if(page<=allPage){
            List<Miniofile> files;
            if(TextUtil.isEmpty(sort)){
                //无排序
                files = fileService.selectByPage(page, rnum);
            }else{
                files = fileService.selectByPage(page, rnum, sort, order);
            }

            if(files==null || files.isEmpty()){
                res.fail("查询数据失败！");
            }else{
//                JSONArray array = JSONArray.fromObject(files);
//                res.setData(array);

                res.setData2(files);
            }
        }else{
            res.fail("页数超出！");
        }

        sendJsonResponse(response, res.toJson());
    }
}
