package com.virgo.com.pc.modules.page.controller;

import com.virgo.com.core.bean.Response;
import com.virgo.com.core.util.FileUploadUtil;
import com.virgo.com.core.util.LogUtil;
import com.virgo.com.pc.bean.PcBaseControllerr;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.File;

/**
 * 默认返回HTML即页面，若不想如此可设置response返回类型未text/json;
 */
@Controller
public class PageController extends PcBaseControllerr {
    private static final String TAG = "PageController";

    @RequestMapping("/home")
    public ModelAndView showHomePage(){
        return new ModelAndView("home/home");
    }

    @RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
    @ResponseBody
    public String uploadFileHandler(@RequestParam("file") MultipartFile file) {
        if (!file.isEmpty()) {
            try {
                // 文件存放服务端的位置
                String rootPath = "E:/tmp";
                File dir = new File(rootPath + File.separator + "tmpFiles");
                if (!dir.exists())
                    dir.mkdirs();
                // 写文件到服务器
                File serverFile = new File(dir.getAbsolutePath() + File.separator + file.getOriginalFilename());
                file.transferTo(serverFile);
                return "You successfully uploaded file=" +  file.getOriginalFilename();
            } catch (Exception e) {
                return "You failed to upload " +  file.getOriginalFilename() + " => " + e.getMessage();
            }
        } else {
            return "You failed to upload " +  file.getOriginalFilename() + " because the file was empty.";
        }
    }

    @RequestMapping(value = "/home/upload", method = RequestMethod.POST)
    public void uploadFile(HttpServletResponse response, @RequestParam("file") MultipartFile file) {
        JSONObject jsonObject;
        LogUtil.debug(TAG, "filename: " + file.getOriginalFilename());
        String url;
        try {
            url = FileUploadUtil.uploadFiles(file);
            LogUtil.debug(TAG, "url: " + url);
            jsonObject = Response.success("上传成功", url);
        } catch (Exception e) {
            e.printStackTrace();
            jsonObject = Response.fail("上传失败");
        }

        sendJsonResponse(response, jsonObject);
    }

//    @RequestMapping(value = "/home/upload", method = RequestMethod.POST)
//    public AjaxJson uploadFile(HttpServletRequest request, HttpServletResponse response, @RequestBody MultipartFile[] files){
//        response.setContentType("text/plain");
//        AjaxJson ajaxJson = new AjaxJson();
//        List<String> urlList = new ArrayList<>();
//        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());
//
////            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
////            Iterator<String> ite = multiRequest.getFileNames();
////            while (ite.hasNext()) {
////                LogUtil.debug(TAG, "filename: " + ite);
////                MultipartFile file = multiRequest.getFile(ite.next());
////                try {
////                    String url = FileUploadUtil.uploadFiles(request, file);
////                    urlList.add(url);
////                    continue;
////                } catch (Exception e) {
////                    e.printStackTrace();
////                    response.setStatus(-1);
////                    ajaxJson.fail("上传失败");
////                    return ajaxJson;
////                }
////            }
//        if (multipartResolver.isMultipart(request)) { // 判断request是否有文件上传
//            for(MultipartFile file:files){
//                LogUtil.debug(TAG, "filename: " + file);
//                try {
//                    String url = FileUploadUtil.uploadFiles(request, file);
//                    urlList.add(url);
//                } catch (Exception e) {
//                    e.printStackTrace();
//                    response.setStatus(-1);
//                    ajaxJson.fail("上传失败");
//                    return ajaxJson;
//                }
//            }
//            ajaxJson.setData(urlList);
//        }
//        return ajaxJson;
//    }

    @RequestMapping("/html")
    public ModelAndView showHtmlPage(){
        return new ModelAndView("html/html");
    }

    @RequestMapping("/html/table")
    public ModelAndView showTablePage(){
        return new ModelAndView("html/table");
    }

    @RequestMapping("/source")
    public ModelAndView showSourcePage(){
        return new ModelAndView("source/source");
    }

    @RequestMapping("/mine")
    public ModelAndView showMinePage(){
        return new ModelAndView("mine/mine");
    }

    @RequestMapping("/admin")
    public ModelAndView showAdminPage(){
        return new ModelAndView("admin/admin");
    }
}
