package com.virgo.com.pc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/home")
public class HomeController {

    @RequestMapping("/default")
    public ModelAndView showHomePage(){
        return new ModelAndView("home/default");
    }
}
