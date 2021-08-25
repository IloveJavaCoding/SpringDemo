package com.virgo.com.pc.controller;

import com.virgo.com.core.bean.Response;
import com.virgo.com.core.util.LogUtil;
import com.virgo.com.core.util.TextUtil;
import com.virgo.com.pc.entity.Account;
import com.virgo.com.pc.service.IUserService;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * pc 登入,注销
 */
@Controller
@RequestMapping("/account")
public class AccountController {
    private static final String TAG = "AccountController";

    @Autowired
    protected IUserService userService;

    @RequestMapping("/loginin")
    public ModelAndView login(){
        return goLogin();
    }

    //登入
    @RequestMapping("/login")
    public ModelAndView login(HttpServletRequest request){
        if(request!=null){
            if(request.getSession().getAttribute("user")!=null){
                //已登入
                return goHome();
            }

            String username = request.getParameter("username");
            String password = request.getParameter("password");
            LogUtil.debug(TAG, username + ", " + password);

//            if(ApiService.login(username, password)){

            if(userService.checkLogin(username, password)){//UserUtil.checkLogin(username, password)
                HttpSession session = request.getSession();
                session.setMaxInactiveInterval(3600);//过期时间 s 默认30min
                session.setAttribute("username", username);
                return goHome();
            }
            LogUtil.debug(TAG, "登入失败");
        }

        return reLogin();
    }

    //注销
    @RequestMapping("/logout")
    public ModelAndView logout(HttpServletRequest request){
        request.getSession().invalidate();
        return reLogin();
    }

    //注册
    @RequestMapping("/register")
    public ModelAndView register(HttpServletRequest request){
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        LogUtil.debug(TAG, username + ", " + password);

        if(TextUtil.isEmpty(username) || TextUtil.isEmpty(password)){
            return new ModelAndView("account/register");
        }else{
            //校验用户是否已存在
            JSONObject json;
            if(userService.isExist(username)){//UserUtil.checkLogin(username, password)
                json = Response.fail("该用户名已存在！");
                LogUtil.debug(TAG, username + " 已存在！" );
            }else{
                //注册新账号
                if(userService.insert(new Account(username, password))){
                    LogUtil.debug(TAG, username + " 注册成功！" );
                    return goLogin();
                }else {
                    json = Response.fail("注册失败！");
                    LogUtil.debug(TAG, username + " 注册失败！");
                }
            }

            //带参数
            ModelAndView view = new ModelAndView();
            view.setViewName("account/register");
            view.addObject("reg_result", json.toString());
            return view;
        }
    }

    //忘记密码
    @RequestMapping("/forget")
    public ModelAndView forget(){
        return new ModelAndView("account/forget");
    }

    private ModelAndView reLogin() {
        return new ModelAndView("redirect:/account/loginin");
    }

    private ModelAndView goLogin() {
        return new ModelAndView("account/login");
    }

    private ModelAndView goHome() {
        //http://localhost:8080/SpringDemo/home?user=zsl
        return new ModelAndView("redirect:/home");
    }
}
