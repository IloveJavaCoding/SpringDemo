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
    <script  type="text/javascript" src="/SpringDemo/static/js/jquery3.5.1/jquery-3.5.1.min.js"></script>
    <script  type="text/javascript" src="/SpringDemo/static/js/layer/layer.js"></script>

    <script type="text/javascript">
        function getLoginUser() {
            return '<%=session.getAttribute("username")%>';
        }

        function showTable() {
            layer.open({
                type:2,
                title:'表格',
                content:'home/itable',
                area:['800px','500px'],
                anim:6,
                //关闭弹框回调
                cancel:function (index, layero) {
                    //得到iframe页的窗口对象
                    setCallBack(layero.find("iframe")[0].contentWindow.returnSelectData());
                }
            });
        }

        function showGridTable() {
            layer.open({
                type:2,
                title:'Grid 表格',
                // content:['home/gridtable','no'],
                content:'home/gridtable',
                area:['900px','500px'],
                anim:1,
            });
        }

        function showWebSocket() {
            layer.open({
                type:2,
                title:'Web Socket 客户端',
                content:'home/websocket',
                area:['600px','500px'],
                anim:3
            });
        }

        function showMsg() {
            layer.open({
                type:0,
                icon:6,
                title:'提示',
                content:'Hello world!'
            });
        }

        function showLoad() {
            layer.open({
                type:3,
                icon:0,
                title:'加载',
                shade: [0.5, 'gray'],
                time:3000
            });
        }

        function setCallBack(msg) {
            document.getElementById("div_meaasge").innerText = msg;
        }

        function resize(obj){
            var idoc = obj.contentWindow.document;
            var img = idoc.getElementsByTagName('img')[0];
            var frame = $('#home_frame');
            if(img){
                var curWidth  = img.width;
                var curHeight = img.height;
                var maxWidth = frame.width();
                if (curWidth >= maxWidth){
                    img.width = maxWidth;
                    var zoomTimes=curWidth/maxWidth;
                    img.height = curHeight/zoomTimes;
                }
            }
            // var iframe=obj.contentWindow.document.body;
            // var bHeight = iframe.scrollHeight;
            // var dWidth = iframe.scrollWidth;
            // bHeight= Math.max(bHeight,200);
            // dWidth= Math.max(dWidth,1000);
            // frame.style.height=(bHeight+20+"px");
            // frame.style.width=(dWidth+10+"px");
        }

    </script>
    <script type="text/javascript" src="/SpringDemo/static/js/common/commonjs.js"></script>
    <script type="text/javascript" src="/SpringDemo/static/js/page/homepage.js"></script>
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
    <div>
        <a href="https://www.qweather.com/" target="home_frame"><span>天气</span></a> |
        <a href="https://www.runoob.com/" target="home_frame"><span>菜鸟</span></a> |
        <a href="https://huaban.com/" target="home_frame"><span>花瓣</span></a> |
    </div>
    <br/>

    <div id="layer_test">
        <button onclick="showTable()">显示表格</button>
        <br/>
        <button onclick="showGridTable()">显示Grid表格</button>
        <br/>
        <button onclick="showWebSocket()">Web Socket</button>
        <br/>
        <button onclick="showMsg()">提示消息</button>
        <br/>
        <button onclick="showLoad()">加载</button>
    </div>

    <div id="div_meaasge">

    </div>

    <div class="div_frame">
        <!--src: 默认加载页-->
        <iframe id="home_frame" name="home_frame" class="home_frame"
                src="/SpringDemo/static/res/img/img1.jpg" width="100%" height="100%"
                onload="resize(this)" onresize="resize(this)" scrolling="no"></iframe>
    </div>
</div>

<div id="footer" class="footer">
    <hr/>
    我是有底线的<br/>
    Copyright@Forever <span class="span_hight">Virgo</span>
</div>
</body>
</html>
