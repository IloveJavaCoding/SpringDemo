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
    <script src="https://ajax.aspnetcdn.com/ajax/jquery/jquery-3.5.1.min.js"></script>
<%--    <script type="text/javascript" src="/SpringDemo/static/js/homepage.js"></script> --%>
    <script type="text/javascript">
        function onLoad(){
            var admin = document.getElementById("admin");
            if(!isAdmin()){
                console.log("管理员？", "no");
                admin.style.visibility = "hidden";
            }else{
                console.log("管理员？", "yes");
            }
        }

        function isAdmin() {
            const name = '<%=session.getAttribute("username")%>';
            return name === "admin";
        }

        function uploadFile() {
            var formData = new FormData();
            formData.append("file",$("#filename")[0].files[0]);
            $.ajax({
                url: '/SpringDemo/home/upload',//请求url
                type: 'post',//请求类型
                cache: false,//
                data: formData,//请求参数
                dataType: "json",//返回数据类型
                processData: false,
                contentType: false,
                success:function (res) {
                    console.log(res);
                    if(res!=null){
                        if(res.code==="SUCCESS"){
                            alert(res.msg+": " + res.data);
                        }else{
                            alert(res.msg);
                        }
                    }
                }
            })
        }
    </script>
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
            <li id="admin"><a href="/SpringDemo/admin">Admin</a></li>
        </ul>
    </div>

    <div id="main" class="main">
        <a href="#main" class="back_top_icon"><img src="/SpringDemo/static/res/icon/icon_end.png" width="32" height="32"/></a>

        <div class="file_upload">
<%--            method="post" action="/SpringDemo/home/upload"--%>
            <form id="upload_file" class="form_upload_file" enctype="multipart/form-data">
                <input type="file" id="filename" name="filename"/>
                <button type="button" onclick="uploadFile()">上传</button>
            </form>

            <br/>

            <form id="upload_file2" class="form_upload_file" method="post" action="/SpringDemo/uploadFile" enctype="multipart/form-data">
                <input type="file" name="file"/>
                <input type="submit" value="上传"/>
            </form>
        </div>

        <div class="file_list">

        </div>

    </div>

    <div id="footer" class="footer">
        <hr/>
        我是有底线的<br/>
        Copyright@Forever <span class="span_hight">Virgo</span>
    </div>
</body>
</html>
