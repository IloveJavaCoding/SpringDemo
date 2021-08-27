<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/8/3
  Time: 15:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登入</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="/SpringDemo/static/css/page/loginpage.css">
    <script src="/SpringDemo/static/js/jquery3.5.1/jquery-3.5.1.min.js"></script>
    <!--需搭配jquery使用-->
    <script src="/SpringDemo/static/js/layer/layer.js"></script>
    <script type="text/javascript">
        //简单用户、密码校验：不为空
        function judgeUP() {
            var name = document.getElementById("username").value;
            var password = document.getElementById("password").value;
            if(name==="" || password===""){
                layer.open({
                    title:'错误提醒',
                    content:'用户名、密码不能为空！',
                    icon:2,
                    time:3000,
                    closeBtn:0
                });
                return false;
            }

            return true;
            // if(typeof(Storage)!=="undefined") {
            //     sessionStorage.setItem("username", name);
            //     return true
            // } else {
            //     // 抱歉! 不支持 web 存储。
            //     return false;
            // }
        }
    </script>
</head>
<body>
    <div class="header">
    </div>
    <div class="main">
        <div class="login_form">
            <%--使用表单提交参数：name为key, 对应标签值为value, action内指定接收位置--%>
            <form class="form" method="post" action="/SpringDemo/account/login" onsubmit="return judgeUP();">
                <div class="login_title">
                    <span>用户登入</span>
                </div>

                <div class="login_input">
                    <span>账号：</span>
                    <label for="username"></label>
                    <input type="text" id="username" name="username" placeholder="username">
                </div>

                <div class="login_input">
                    <span>密码：</span>
                    <label for="password"></label>
                    <input type="password" id="password" name="password" placeholder="password">
                </div>

                <div class="login_input">
                    <button type="submit">登入</button>
                </div>
            </form>

            <div class="login_other">
                <a href="/SpringDemo/account/go_forget" class="forget">忘记密码?</a>
                <a href="/SpringDemo/account/go_register" class="register">注册</a>
            </div>
        </div>
    </div>

    <div class="footer">

    </div>
</body>
</html>
