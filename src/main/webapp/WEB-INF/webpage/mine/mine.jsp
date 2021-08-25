<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Virgo Mine</title>
    <link href="/SpringDemo/static/res/icon/icon_logo.ico" rel="shortcut icon"/>
    <link rel="stylesheet" type="text/css" href="/SpringDemo/static/css/commonstyle.css"/>
    <link rel="stylesheet" type="text/css" href="/SpringDemo/static/css/minepage.css"/>
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
    </div>

    <div id="navigation" class="navigation">
        <ul class="ul_nav">
            <li><a href="/SpringDemo/home">首页</a></li>
            <li><a href="/SpringDemo/html">Html</a></li>
            <li><a href="/SpringDemo/source">Source</a></li>
            <li><a href="/SpringDemo/mine" class="nav_selected">Mine</a></li>
            <li id="admin" class="li_hidden"><a href="/SpringDemo/admin">Admin</a></li>
        </ul>
    </div>

    <div id="main" class="main">
        <a href="#main" class="back_top_icon"><img src="/SpringDemo/static/res/icon/icon_end.png" width="32" height="32"/></a>

        <div class="baseinfo">
            <div class="portrait_nickname">
                <img class="portrait" src="/SpringDemo/static/res/img/img_portrait.jpg" width="50px" height="50px">

                <span class="nickname">
                     <u><a href="/SpringDemo/static/res/img/img_portrait.jpg">梦影幻灵</a></u>
                </span>
            </div>

            <br/>
            <br/>
            <hr/>

            <div class="detailinfo">
                <h3>简介</h3>

                <table>
                    <tr>
                        <th><b>NAME:</b></th>
                        <td>张顺亮</td>
                    </tr>
                    <tr>
                        <th><b>NICK-NAME:</b></th>
                        <td>Virgo</td>
                    </tr>
                    <tr>
                        <th><b>GENDER:</b></th>
                        <td>Male</td>
                    </tr>
                    <tr>
                        <th><b>BIRTHDAY:</b></th>
                        <td>1998-09-09</td>
                    </tr>
                    <tr>
                        <th><b>Favor:</b></th>
                        <td>Reading</td>
                    </tr>
                </table>
            </div>

            <br/>
            <div class="motto">
                <span id="span_motto">
        When there is a higher mountain to climb in one's heart,he will not care about
        the mud around the foot, he may face the pain that the commons can not bear in
        the most peaceful way.</span>
                <button onclick="translateMotto()">Translate</button>
                <br/>
            </div>
        </div>
    </div>

    <div id="footer" class="footer">
        <hr/>
        我是有底线的<br/>
        Copyright@Forever <span class="span_hight">Virgo</span>
    </div>
</body>
</html>