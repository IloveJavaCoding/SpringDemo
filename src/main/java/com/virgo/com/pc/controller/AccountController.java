package com.virgo.com.pc.controller;

import com.virgo.com.core.bean.Response;
import com.virgo.com.core.data.Constants;
import com.virgo.com.core.util.LogUtil;
import com.virgo.com.pc.bean.PcBaseControllerr;
import com.virgo.com.pc.entity.Account;
import com.virgo.com.pc.service.IUserService;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * pc 登入,注销
 */
@Controller
@RequestMapping("/account")
public class AccountController extends PcBaseControllerr {
    private static final String TAG = "AccountController";

    @Autowired
    protected IUserService userService;

    @RequestMapping("/go_login")
    public ModelAndView login(){
        return goLogin();
    }

    @RequestMapping("/go_register")
    public ModelAndView register(){
        return goRegister();
    }

    //注销
    @RequestMapping("/logout")
    public ModelAndView logout(HttpServletRequest request){
        request.getSession().invalidate();
        return goLogin();
    }

    //忘记密码
    @RequestMapping("/go_forget")
    public ModelAndView forget(){
        return goForget();
    }

    //登入
    @RequestMapping("/login")
    public ModelAndView login(HttpServletRequest request){
        if(request!=null){
            String name = (String) request.getSession().getAttribute("username");
            if(name!=null && !name.equals("null")){
                //已登入
                return goHome();
            }

            String username = request.getParameter("username");
            String password = request.getParameter("password");
            LogUtil.debug(TAG, username + ", " + password);

//            if(ApiService.login(username, password)){
            if(userService.checkLogin(username, password)){//UserUtil.checkLogin(username, password)
                HttpSession session = request.getSession();
                session.setMaxInactiveInterval(Constants.LOGIN_VALID);//过期时间 s 默认30min
                session.setAttribute("username", username);
                return goHome();
            }
            LogUtil.debug(TAG, "登入失败");
        }

        return goLogin();
    }

    //注册
    @RequestMapping("/register")
    public void register(HttpServletRequest request, HttpServletResponse response){
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        LogUtil.debug(TAG, username + ", " + password);

        //校验用户是否已存在
        JSONObject object;
        if(userService.isExist(username)){//UserUtil.checkLogin(username, password)
            object = Response.fail("该用户名已存在！");
            LogUtil.debug(TAG, username + " 已存在！" );
        }else{
            //注册新账号
            Account account = new Account();
            account.setUsername(username);
            account.setPassword(password);
            if(userService.insert(account)){//new Account(username, password)
                LogUtil.debug(TAG, username + " 注册成功！" );
                object = Response.success("注册成功！");
            }else {
                object = Response.fail("注册失败！");
                LogUtil.debug(TAG, username + " 注册失败！");
            }
        }

        sendJsonResponse(response, object);

//        //带参数
//        ModelAndView view = new ModelAndView();
//        view.setViewName("account/register");
//        view.addObject("reg_result", json.toString());
//        return view;
    }

    private ModelAndView goLogin() {
        return new ModelAndView("account/loginpage");
    }

    private ModelAndView goRegister() {
        return new ModelAndView("account/registerpage");
    }

    private ModelAndView goForget() {
        return new ModelAndView("account/forgetpage");
    }

    private ModelAndView goHome() {
        //http://localhost:8080/SpringDemo/home?user=zsl
        return new ModelAndView("redirect:/home");
    }
}
