package com.virgo.com.pc.controller;

import com.virgo.com.pc.bean.PcBaseControllerr;
import com.virgo.com.pc.websocket.SecondSocket;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/home")
public class HomeController extends PcBaseControllerr {
    private static final String TAG = "HomeController";

    @RequestMapping("/default")
    public ModelAndView showHomePage(){
        return new ModelAndView("home/default");
    }

    @RequestMapping("/itable")
    public ModelAndView showITable(){
        return new ModelAndView("home/itable");
    }

    @RequestMapping("/gridtable")
    public ModelAndView showgridTable(){
        return new ModelAndView("home/gridtable");
    }

    @RequestMapping("/websocket")
    public ModelAndView showWebSocket(){
        return new ModelAndView("home/websocket");
    }

    @RequestMapping("/websocket_back")
    public void websocketBack(HttpServletRequest request, HttpServletResponse response){
        String message = request.getParameter("message");
        String code = request.getParameter("code");
        SecondSocket.sendMessage(code, message);
        sendJsonResponse(response, null);
    }
}
