package com.virgo.com.core.bean;

import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

public class BaseController {
    /**
     * 调用接口时返回json类型数据
     * @param response
     * @param outputObj
     */
    protected void sendJsonResponse(HttpServletResponse response, Object outputObj) {
        PrintWriter out = null;
        response.setContentType("text/json;charset=utf-8");
        try {
            out = response.getWriter();
            out.print(outputObj);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            if(out!=null){
                out.flush();
                out.close();
            }
        }
    }
}
