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
    <link rel="stylesheet" type="text/css" href="/SpringDemo/static/css/commonstyle.css"/>
    <link rel="stylesheet" type="text/css" href="/SpringDemo/static/css/homepage.css"/>
    <!--支持jquery-->
<%--    <script src="https://ajax.aspnetcdn.com/ajax/jquery/jquery-3.5.1.min.js"></script>--%>
    <script src="/SpringDemo/static/js/jquery3.5.1/jquery-3.5.1.min.js"></script>
    <script type="text/javascript">
        function getLoginUser() {
            return '<%=session.getAttribute("username")%>';
        }
    </script>

    <script type="text/javascript" src="/SpringDemo/static/js/commonjs.js"></script>
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
        <a href="#main" class="back_top_icon"><img src="/SpringDemo/static/res/icon/icon_end.png" width="32" height="32"/></a>

    </div>

    <div id="footer" class="footer">
        <hr/>
        我是有底线的<br/>
        Copyright@Forever <span class="span_hight">Virgo</span>
    </div>
</body>
</html>
