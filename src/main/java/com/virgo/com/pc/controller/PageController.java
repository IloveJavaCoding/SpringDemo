package com.virgo.com.pc.controller;

import com.virgo.com.pc.bean.PcBaseControllerr;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

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
