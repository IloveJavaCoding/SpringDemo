<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/8/6
  Time: 16:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin</title>
    <link href="/SpringDemo/static/res/icon/icon_logo.ico" rel="shortcut icon"/>
    <link rel="stylesheet" type="text/css" href="/SpringDemo/static/css/common/commonstyle.css"/>
    <link rel="stylesheet" type="text/css" href="/SpringDemo/static/css/common/itable.css"/>
    <link rel="stylesheet" type="text/css" href="/SpringDemo/static/css/page/adminpage.css"/>
    <script src="/SpringDemo/static/js/jquery3.5.1/jquery-3.5.1.min.js"></script>
    <script src="/SpringDemo/static/js/layer/layer.js"></script>
    <script type="text/javascript" src="/SpringDemo/static/js/common/virgotable.js"></script>

    <script type="text/javascript">
        // var table;
        function getLoginUser() {
            return '<%=session.getAttribute("username")%>';
        }

        function addTable() {
            var root = document.getElementById("table_view");
            var head = new Map([['id','id'], ['username','账号'], ['password','密码']]);
            root.appendChild(createTable(head));
            showButton(false);

            // table = new iTable();
            // root.appendChild(table.createTable(head));
            // table.showButton(false);
            getAllUsers();
        }

        function getAllUsers() {
            $.ajax({
                cache:false,
                type:"POST",
                url:"/SpringDemo/admin/all_user",
                dataType:"json",
                async:true,
                error:function (request) {
                    alert(request.data);
                },
                success:function (response) {
                    if(response.code!=="SUCCESS"){
                        layer.msg(response.msg);
                        return;
                    }

                    setData(response.data);
                    // table.setData(response.data);

                    // //数组元素，元素的索引，数组本身
                    // var str = "";
                    // json.forEach(function(value, index){
                    //     var order = index;
                    //     var id = value.id;
                    //     var username = value.username;
                    //     var password = value.password;
                    //     console.log(order + " : " + id + " - " + username + " : " + password);
                    //
                    //     str += "<tr>";
                    //     str += "<td>"+ id + "</td>";
                    //     str += "<td>"+ username + "</td>";
                    //     str += "<td>"+ password + "</td>";
                    //     str += "<td><button id=" + id + " onclick='deleteUser("+id+")'>删除</button></td>";
                    //     str += "</tr>";
                    // });
                }
            });
        }

        function deleteUser(id) {
            console.log("id: " + id);
            if(id!==null){
                //if else 选择弹框
                if(confirm("真的要删除用户：" + id)){
                    $.ajax({
                        cache:false,
                        type:"POST",
                        url:"/SpringDemo/admin/delete_user",
                        data:{
                            id:id
                        },
                        dataType:"json",
                        async:true,
                        error:function (request) {
                            alert(request.data);
                        },
                        success:function (response) {
                            if(response.code!=="SUCCESS"){
                                alert(response.msg);
                                return;
                            }

                            //删除成功
                            getUsers(curPage);
                        }
                    });
                }else{
                    //do nothing
                }
            }
        }
    </script>

    <script type="text/javascript" src="/SpringDemo/static/js/common/commonjs.js"></script>
</head>
<body onload="onLoad(); addTable()">
<div id="header" class="header">
    <a class="logo" href="/SpringDemo/static/res/icon/icon_logo2.ico"></a>
    <h1>VIRGO</h1>
</div>

<div id="navigation" class="navigation">
    <ul class="ul_nav">
        <li><a href="/SpringDemo/home">首页</a></li>
        <li><a href="/SpringDemo/html">Html</a></li>
        <li><a href="/SpringDemo/source">Source</a></li>
        <li><a href="/SpringDemo/mine">Mine</a></li>
        <li id="admin" class="li_hidden"><a href="/SpringDemo/admin" class="nav_selected">Admin</a></li>
    </ul>
</div>

<div id="main" class="main">
    <a id="go_top" href="#main" class="back_top_icon"><img src="/SpringDemo/static/res/icon/icon_end.png" width="32" height="32"/></a>

    <div id="table_view">

    </div>
</div>

<div id="footer" class="footer">
    <hr/>
    我是有底线的<br/>
    Copyright@Forever <span class="span_hight">Virgo</span>
</div>
</body>
</html>