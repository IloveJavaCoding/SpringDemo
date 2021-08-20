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
    <link rel="stylesheet" type="text/css" href="/SpringDemo/static/css/commonstyle.css"/>
    <link rel="stylesheet" type="text/css" href="/SpringDemo/static/css/adminpage.css"/>
    <!--支持jquery-->
    <script src="https://ajax.aspnetcdn.com/ajax/jquery/jquery-3.5.1.min.js"></script>
    <script type="text/javascript">
        var curPage = 1;//默认为第一页数据
        var allPage;
        function loadUsers() {
            setCurPage();
            getUsers(curPage);
        }

        function setAllPage() {
            document.getElementById("span_allpage").innerText = allPage;
        }

        function setCurPage() {
            document.getElementById("span_curpage").innerText = curPage;
        }

        function getUsers(page) {
            $.ajax({
                cache:false,
                type:"POST",
                url:"/SpringDemo/admin/page_user",
                data:{
                    page:page
                },
                dataType:"json",
                async:true,
                error:function (request) {
                    alert(request.data);
                },
                success:function (response) {
                    // alert(response.msg);
                    if(response.code!=="SUCCESS"){
                        alert(response.msg);
                        return;
                    }
                    allPage = response.msg;
                    console.log("all page: " + allPage);
                    setAllPage();

                    var json = response.data;
                    //数组元素，元素的索引，数组本身
                    var str = "";
                    json.forEach(function(value, index){
                        var order = index;
                        var id = value.id;
                        var username = value.username;
                        var password = value.password;
                        console.log(order + " : " + id + " - " + username + " : " + password);

                        str += "<tr>";
                        str += "<td>"+ id + "</td>";
                        str += "<td>"+ username + "</td>";
                        str += "<td>"+ password + "</td>";
                        str += "<td><button id=" + id + " onclick='deleteUser("+id+");'>删除</button></td>";
                        str += "</tr>";
                    });
                    // $("#table_user_body").innerHTML  = str;
                    document.getElementById("table_user_body").innerHTML = str;
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

        function lastPage() {
            if(curPage>1){
                curPage--;
                setCurPage();
                getUsers(curPage);
            }else{
                alert("当前为第一页！")
            }
        }

        function nextPage() {
            if(curPage<allPage){
                curPage++;
                setCurPage();
                getUsers(curPage);
            }else{
                alert("当前为最后一页！")
            }
        }
    </script>
</head>
<body onload="loadUsers()">
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
        <li><a href="/SpringDemo/admin" class="nav_selected">Admin</a></li>
    </ul>
</div>

<div id="main" class="main">
    <a href="#main" class="back_top_icon"><img src="/SpringDemo/static/res/icon/icon_end.png" width="32" height="32"/></a>

    <div class="user_list">
        <table id="table_user" class="table_user">
            <thead id="table_user_head" class="table_user_head">
                <tr>
                    <th>id</th>
                    <th>账号</th>
                    <th>密码</th>
                    <th>管理</th>
                </tr>
            </thead>

            <tbody id="table_user_body" class="table_user_body">

            </tbody>

            <tfoot id="table_user_foot" class="table_user_foot">
                <tr>
                    <td colspan="4">
                        <span class="span_button" onclick="lastPage();">上一页</span>
                        第<span id="span_curpage" class="span_hight"></span>页
                        共<span id="span_allpage" class="span_hight"></span>页
                        <span class="span_button" onclick="nextPage();">下一页</span>
                    </td>
                </tr>
            </tfoot>
        </table>
    </div>
</div>

<div id="footer" class="footer">
    <hr/>
    我是有底线的<br/>
    Copyright@Forever <span class="span_hight">Virgo</span>
</div>
</body>
</html>