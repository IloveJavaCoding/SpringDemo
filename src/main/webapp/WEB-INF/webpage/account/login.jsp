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
    <link rel="stylesheet" type="text/css" href="/SpringDemo/static/css/login.css">
    <script type="text/javascript">
    </script>
</head>
<body>
    <div class="header">

    </div>
    <div class="main">
        <div class="login_form">
            <%--使用表单提交参数：name为key, 对应标签值为value, action内指定接收位置--%>
            <form class="form" method="post" action="/SpringDemo/account/login">
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
                <a href="/SpringDemo/account/forget" class="forget">忘记密码?</a>
                <a href="/SpringDemo/account/register" class="register">注册</a>
            </div>
        </div>
    </div>

    <div class="footer">

    </div>
</body>
</html>
