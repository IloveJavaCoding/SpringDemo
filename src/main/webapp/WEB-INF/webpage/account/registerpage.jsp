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
    <link rel="stylesheet" type="text/css" href="/SpringDemo/static/css/page/registerpage.css">
    <script src="/SpringDemo/static/js/jquery3.5.1/jquery-3.5.1.min.js"></script>
    <script src="/SpringDemo/static/js/layer/layer.js"></script>

    <script type="text/javascript">
        function register() {
            var username = document.getElementById("username").value;
            var p1 = document.getElementById("password").value;
            var p2 = document.getElementById("password2").value;

            if(username==="" || p1==="" || p2===""){
                errorMsg('用户名、密码不能为空！');
                return false;
            }

            checkPassword(p1, p2);

            $.ajax({
                url: '/SpringDemo/account/register',//请求url
                type: 'post',//请求类型
                cache: false,//
                data: {
                    username:username,
                    password:p1
                },//请求参数
                dataType: "json",//返回数据类型
                success:function (res) {
                    layer.open({
                        title:'注册结果',
                        content:res.msg ,
                        icon:0,
                        yes: function(index){
                            //do something
                            // clearInput();
                            layer.close(index); //如果设定了yes回调，需进行手工关闭
                        },
                        cancel: function(index){
                            // clearInput();
                            layer.close(index);
                            return true;
                        }
                    });
                }
            })
        }

        function clearInput() {
            document.getElementById("username").innerHTML="";
            document.getElementById("password").innerHTML="";
            document.getElementById("password2").innerHTML="";
        }

        function checkPassword(p1, p2) {
            if (regex(p1)) {
                if (p1 === p2) {
                    return true;
                }
                errorMsg('两次密码输入不一致！');
            }
            return false;
        }

        function regex(p1) {
            if (!p1.match(/^[a-zA-Z][\da-zA-Z]{5,11}/)) {
                layer.open({
                    title: '错误提醒',
                    content: '密码不符合要求：字母开头，字母数字组合，长度6-12',
                    icon: 0
                });
                return false;
            }
            return true;
        }

        function errorMsg(msg) {
            layer.open({
                title: '错误提醒',
                content: msg,
                icon: 2,
                time: 3000,
                closeBtn: 0
            });
        }
    </script>
</head>
<body>

<div class="main">
    <div class="login_form">
        <%--使用表单提交参数：name为key, 对应标签值为value, action内指定接收位置--%>
        <!--onsubmit: 表单提交前校验， TRUE 提交 method="post" action="/SpringDemo/account/register" onsubmit="return checkPassword();" -->
        <form class="form">
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
<%--                <button type="submit">注册</button>--%>
                <button type="button" onclick="register()">注册</button>
            </div>
        </form>

        <div class="login_other">
            <a href="/SpringDemo/account/go_login" class="login">登入</a>
        </div>
    </div>
</div>

<div class="footer">

</div>
</body>
</html>
