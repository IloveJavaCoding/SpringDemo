package com.virgo.com.mobile.controller;

import com.virgo.com.core.bean.Response;
import com.virgo.com.core.manager.ApiService;
import com.virgo.com.core.util.LogUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/mobile/account")
public class MobileAccountController extends MobileBaseController{
    private static final String TAG = "MobileAccountController";

    //登入
    @RequestMapping("/login")
    public void login(HttpServletRequest request, HttpServletResponse response){
        if(request!=null){
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            LogUtil.debug(TAG, username + ", " + password);
            //校验密码
            if(ApiService.login(username, password)){
                sendJsonResponse(response, Response.success("登入成功"));
            }else{
                sendJsonResponse(response, Response.fail("账号或密码不正确"));
            }
        }
    }
}
