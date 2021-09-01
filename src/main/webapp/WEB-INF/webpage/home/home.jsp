<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/8/4
  Time: 14:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@include file="/WEB-INF/webpage/taglibs.jspf" %>--%>
<%--<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>--%>

<%--todo--%>
<%--find view --%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home Page</title>
    <%--    <base href="http://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/"/>--%>
    <link href="/SpringDemo/static/res/icon/icon_logo.ico" rel="shortcut icon"/>
    <link rel="stylesheet" type="text/css" href="/SpringDemo/static/css/common/commonstyle.css"/>
    <link rel="stylesheet" type="text/css" href="/SpringDemo/static/css/page/homepage.css"/>
    <!--支持jquery-->
    <%--    <script src="https://ajax.aspnetcdn.com/ajax/jquery/jquery-3.5.1.min.js"></script>--%>
    <script src="/SpringDemo/static/js/jquery3.5.1/jquery-3.5.1.min.js"></script>
    <script src="/SpringDemo/static/js/layer/layer.js"></script>
    <script type="text/javascript" src="/SpringDemo/static/js/page/homepage.js"></script>

    <script type="text/javascript">
        function getLoginUser() {
            return '<%=session.getAttribute("username")%>';
        }

        function showTable() {
            layer.open({
                type:2,
                title:'表格',
                content:['home/itable', 'no'],
                area:['800px','500px']
            });
        }
    </script>
    <script type="text/javascript" src="/SpringDemo/static/js/common/commonjs.js"></script>
</head>
<body onload="onLoad()">
<div id="header" class="header">
    <a class="logo" href="/SpringDemo/static/res/icon/icon_logo2.ico"></a>
    <h1>VIRGO</h1>
    <br/>
    <span id="homeTitle">Welcome To Virgo Page</span>
</div>

<div id="navigation" class="navigation">
    <ul class="ul_nav">
        <li><a href="/SpringDemo/home" class="nav_selected">首页</a></li>
        <li><a href="/SpringDemo/html">Html</a></li>
        <li><a href="/SpringDemo/source">Source</a></li>
        <li><a href="/SpringDemo/mine">Mine</a></li>
        <li id="admin" class="li_hidden"><a href="/SpringDemo/admin">Admin</a></li>
    </ul>
</div>

<div id="main" class="main">
    <a id="go_top" href="#main" class="back_top_icon">
        <img src="/SpringDemo/static/res/icon/icon_end.png" width="32" height="32"/></a>


    <div class="test">
        <button onclick="showTable()">显示表格</button>
    </div>
    <div>
        <a href="http://www.baidu.com/" target="home_frame"><span>百度</span></a> |
        <a href="https://www.runoob.com/" target="home_frame"><span>菜鸟</span></a> |
        <a href="https://huaban.com/" target="home_frame"><span>花瓣</span></a> |
    </div>

    <br/>
    <div class="div_frame_nav">
        <ul id="frame_ul">
            <li class="nav_selected">
                <a href="/SpringDemo/home/default" target="home_frame">默认</a>
            </li>
            <li>
                <a href="/SpringDemo/html/table" target="home_frame">表格</a>
                <div class="del_button">X</div>
            </li>
            <li>
                <a href="/SpringDemo/html/table" target="home_frame">表格</a>
            </li>
            <li>
                <a href="/SpringDemo/html/table" target="home_frame">表格</a>
            </li>
        </ul>
    </div>

    <div class="div_frame">
        <!--src: 默认加载页-->
        <iframe id="home_frame" name="home_frame" class="home_frame"
                src="/SpringDemo/home/default" width="100%" height="100%"></iframe>
    </div>
</div>

<div id="footer" class="footer">
    <hr/>
    我是有底线的<br/>
    Copyright@Forever <span class="span_hight">Virgo</span>
</div>
</body>
</html>
