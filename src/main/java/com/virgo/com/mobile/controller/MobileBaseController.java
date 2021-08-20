package com.virgo.com.mobile.controller;

import com.virgo.com.core.bean.BaseController;

/**
 * 与终端设备之间的http通讯
 */
public class MobileBaseController extends BaseController {
//    /**
//     * 校验连接: appkey, packagename, agent
//     * @param request
//     * @param response
//     * @return
//     */
//    protected boolean valid(HttpServletRequest request, HttpServletResponse response) {
//        String appkey = request.getParameter("appkey");
//        String packageName = request.getParameter("pkg_name");
//        if(TextUtil.isEmpty(appkey) || TextUtil.isEmpty(packageName)){
//            return false;
//        }
//
//        boolean retVal = false;
//        String agent = request.getHeader("user-agent");
//        if(agent.contains("Android")){
//            retVal = CryptyUtil.validAppKey(appkey, packageName, "android");
//        }else if(agent.contains("iPhone")||agent.contains("iPod")||agent.contains("iPad")){
//            retVal = CryptyUtil.validAppKey(appkey, packageName, "ios");
//        }
//
//        if(!retVal){
//            sendResponse(response, Response.fail("APP Key 不匹配"));
//        }
//        return retVal;
//    }
}
