package com.virgo.com.pc.controller;

import com.virgo.com.core.bean.Response;
import com.virgo.com.core.util.LogUtil;
import com.virgo.com.pc.bean.PcBaseControllerr;
import com.virgo.com.pc.entity.Account;
import com.virgo.com.pc.service.IUserService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 用户管理
 */
@Controller
@RequestMapping("/admin")
public class AdminManagerController extends PcBaseControllerr {
    private static final String TAG = "AccountManagerControlle";

    @Autowired
    protected IUserService userService;

    @RequestMapping("/user_manager")
    public ModelAndView userManager(HttpServletRequest request){
        return new ModelAndView("admin/admin");
    }

    @RequestMapping("/all_user")
    public void loadAllUser(HttpServletResponse response){
        List<Account> users = userService.selectAll();
        JSONObject object;
        if(!users.isEmpty()){
            System.out.println("总数量：" + users.size());
            JSONArray array = JSONArray.fromObject(users);
            object = Response.success("获取成功", array);
        }else{
            object = Response.fail("未查询到相关数据！");
        }
        sendJsonResponse(response, object);
    }

    @RequestMapping("/page_user")
    public void loadAllUser(HttpServletRequest request, HttpServletResponse response){
        String p = request.getParameter("page");
        LogUtil.debug(TAG, "page: " + p);
        //每页10条
        int page = Integer.parseInt(p);
        int allPage = userService.allPageNum();
        System.out.println("总页数：" + allPage);
        JSONObject object;
        if(page<=allPage){
            List<Account> users = userService.selectByPage(page);
            if(users==null || users.isEmpty()){
                object = Response.fail("查询数据失败！");
            }else{
                JSONArray array = JSONArray.fromObject(users);
                object = Response.success(String.valueOf(allPage), array);
            }
        }else{
            object = Response.fail("页数超出！");
        }

        sendJsonResponse(response, object);
    }

    @RequestMapping("/delete_user")
    public void deleteUser(HttpServletRequest request, HttpServletResponse response){
        String id = request.getParameter("id");
//        id = new String(id.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
        LogUtil.debug(TAG, "user id: " + id);
        //每页10条
        int uId = Integer.parseInt(id);

        boolean isOk = userService.deleteById(uId);

        JSONObject object;
        if(isOk){
            object = Response.success("删除成功，等待刷新");
        }else{
            object = Response.fail("删除失败，请重试！");
        }

        sendJsonResponse(response, object);
    }
}
