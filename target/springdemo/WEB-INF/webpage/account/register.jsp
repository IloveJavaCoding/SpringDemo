<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/8/6
  Time: 14:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="/SpringDemo/static/css/register.css">
    <script type="text/javascript">
        function checkPassword() {
            var p1 = document.getElementById("password").value;
            console.log("p1", p1);
            if(regex(p1)){
                var p2 = document.getElementById("password2").value;
                console.log("p2", p2);
                if(p1===p2){
                    console.log("result", "success");
                    return true;
                }
                alert("两次密码输入不一致！")
            }
            return false;
        }

        function regex(p1) {
            if(!p1.match(/^[a-zA-Z][\da-zA-Z]{5,11}/)){
                alert("密码不符合要求：字母开头，字母数字组合，长度6-12")
                return false;
            }
            return true;
        }

        function onLoad() {
            // $("#reg_result").val();
            var response = document.getElementById("reg_result").value;
            console.log("注册结果", response);
            if(response!=null){
                // alert(response);
            }

        }
    </script>
</head>
<body onload="onLoad()">
<div class="header">
    <input type="hidden" id="reg_result" value="${reg_result}" />
</div>
<div class="main">
    <div class="login_form">
        <%--使用表单提交参数：name为key, 对应标签值为value, action内指定接收位置--%>
        <!--onsubmit: 表单提交前校验， TRUE 提交-->
        <form class="form" method="post" action="/SpringDemo/account/register" onsubmit="return checkPassword();">
            <div class="login_title">
                <span>用户注册</span>
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
                <span>确认：</span>
                <label for="password2"></label>
                <input type="password" id="password2" name="password2" placeholder="confirm password">
            </div>

            <div class="login_input">
                <button type="submit">注册</button>
            </div>
        </form>

        <div class="login_other">
            <a href="/SpringDemo/account/loginin" class="login">登入</a>
        </div>
    </div>
</div>

<div class="footer">

</div>
</body>
</html>
