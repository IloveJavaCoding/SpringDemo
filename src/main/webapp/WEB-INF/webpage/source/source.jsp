<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Virgo Source</title>
    <link href="/SpringDemo/static/res/icon/icon_logo.ico" rel="shortcut icon"/>
    <link rel="stylesheet" type="text/css" href="/SpringDemo/static/css/commonstyle.css"/>
    <link rel="stylesheet" type="text/css" href="/SpringDemo/static/css/tablelist.css"/>
    <link rel="stylesheet" type="text/css" href="/SpringDemo/static/css/sourcepage.css"/>
    <!--支持jquery-->
<%--    <script src="https://ajax.aspnetcdn.com/ajax/jquery/jquery-3.5.1.min.js"></script>--%>
    <script src="/SpringDemo/static/js/jquery3.5.1/jquery-3.5.1.min.js"></script>

    <script type="text/javascript">
        var curPage = 1;//默认为第一页数据
        var curType = 0;//默认全部
        var allPage;

        function getLoginUser() {
            return '<%=session.getAttribute("username")%>';
        }

        //进入后加载
        function loadData() {
            setCurPage();
            loadFiles(curPage, curType);
        }

        function uploadFile() {
            var formData = new FormData();
            formData.append("file",$("#filename")[0].files[0]);
            $.ajax({
                url: '/SpringDemo/source/upload',//请求url
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

        function loadFiles(page, type) {
            $.ajax({
                cache:false,
                type:"POST",
                url:"/SpringDemo/source/page_file",
                data:{
                    page:page,
                    type:type
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
                    json.forEach(function(value){
                        var id = value.id;
                        var name = value.name;
                        var url = value.url;
                        var createdate = value.createdate;
                        var type = value.suffix;
                        var size = formatFileSize(value.size);

                        str += "<tr>";
                        str += "<td>"+ id + "</td>";
                        str += "<td>"+ name + "</td>";
                        str += "<td>"+ type + "</td>";
                        str += "<td>"+ size + "</td>";
                        str += "<td>"+ createdate + "</td>";
                        str += "<td>";
                        str += "<button onclick='openUrl(\""+url+"\")'>预览</button>";
                        // str += "<button onclick='download(\""+url+"\", \""+name+"\")'>下载</button>";
                        str += "<button onclick='download("+id+")'>下载</button>";
                        str += "<button onclick='deleteFile("+id+")'>删除</button>";
                        str += "</td>";
                        str += "</tr>";
                    });

                    document.getElementById("table_file_body").innerHTML = str;
                }
            });
        }

        function setAllPage() {
            document.getElementById("span_allpage").innerText = allPage;
        }

        function setCurPage() {
            document.getElementById("span_curpage").innerText = curPage;
        }

        function changeType(type) {
            if(type===curType){
                console.log("类型未变化！");
            }else{
                //切换类型
                curType = type;
                curPage = 0;
                loadFiles(curPage, curType);
            }
        }

        function lastPage() {
            if(curPage>1){
                curPage--;
                setCurPage();
                loadFiles(curPage, curType);
            }else{
                alert("当前为第一页！")
            }
        }

        function nextPage() {
            if(curPage<allPage){
                curPage++;
                setCurPage();
                loadFiles(curPage, curType);
            }else{
                alert("当前为最后一页！")
            }
        }

        function deleteFile(id) {
            if(id!==null) {
                //if else 选择弹框
                if (confirm("真的要删除资源：" + id)) {
                    $.ajax({
                        cache: false,
                        type: "POST",
                        url: "/SpringDemo/source/delete_file",
                        data: {
                            id: id
                        },
                        dataType: "json",
                        async: true,
                        error: function (request) {
                            alert(request.data);
                        },
                        success: function (response) {
                            if (response.code !== "SUCCESS") {
                                alert(response.msg);
                                return;
                            }

                            //删除成功
                            loadFiles(curPage, curType);
                        }
                    });
                } else {
                    //do nothing
                }
            }
        }

        function openUrl(url) {
            window.open(url);
            //window.location=url;

            // const link = document.createElement('a');
            // link.setAttribute('href', url); //设置下载文件的url地址
            // // link.setAttribute('download', name); //用于设置下载文件的文件名
            // link.click();

            // var $form = $('<form method="GET"></form>');
            // $form.attr('action', url);
            // $form.appendTo($('body'));
            // $form.submit();
        }

        function download(id) {
            // console.log("download: " + url +", " + name);
            // const link = document.createElement('a');
            // link.setAttribute('href', url); //设置下载文件的url地址
            // link.setAttribute('download', name); //用于设置下载文件的文件名
            // link.style.display = 'none';
            // document.body.appendChild(link);
            // link.click();
            // document.body.removeChild(link);

            if(id!==null) {
                //选择路径弹框
                $.ajax({
                    cache: false,
                    type: "POST",
                    url: "/SpringDemo/source/download",
                    data: {
                        id: id,
                        savepath:"F:\\ZSLWORK\\download"
                    },
                    dataType: "json",
                    async: true,
                    error: function (request) {
                        alert(request.data);
                    },
                    success: function (response) {
                        alert(response.msg);
                    }
                });
            }
        }

    </script>

    <script type="text/javascript" src="/SpringDemo/static/js/commonjs.js"></script>
</head>

<body onload="onLoad(); loadData()">
    <div id="header" class="header">
        <a class="logo" href="/SpringDemo/static/res/icon/icon_logo2.ico"></a>
        <h1>VIRGO</h1>
    </div>

    <div id="navigation" class="navigation">
        <ul class="ul_nav">
            <li><a href="/SpringDemo/home">首页</a></li>
            <li><a href="/SpringDemo/html">Html</a></li>
            <li><a href="/SpringDemo/source" class="nav_selected">Source</a></li>
            <li><a href="/SpringDemo/mine">Mine</a></li>
            <li id="admin" class="li_hidden"><a href="/SpringDemo/admin">Admin</a></li>
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

            <form id="upload_file2" class="form_upload_file" method="post" action="/SpringDemo/source/uploadFile" enctype="multipart/form-data">
                <input type="file" name="file"/>
                <input type="submit" value="上传"/>
            </form>
        </div>

        <div class="div_file">
            <div class="file_navigation">
                <ul class="ul_nav_file">
                    <li class="nav_selected" onclick="changeType(0)">全部文件</li>
                    <li onclick="changeType(1)">图片文件</li>
                    <li onclick="changeType(2)">音频文件</li>
                    <li onclick="changeType(3)">视频文件</li>
                </ul>
            </div>

            <div class="file_list">
                <table id="table_file" class="table_data">
                    <thead id="table_file_head" class="table_data_head">
                    <tr>
                        <th>id</th>
                        <th>名字</th>
                        <th>类型</th>
                        <th>大小</th>
                        <th>创建日期</th>
                        <th>操作</th>
                    </tr>
                    </thead>

                    <tbody id="table_file_body" class="table_data_body">

                    </tbody>

                    <tfoot id="table_file_foot" class="table_data_foot">
                    <tr>
                        <td colspan="6">
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

        <div>
            <a href="http://192.168.2.151:9000/media/2021/08/25/d561a24dea688aa21df0ced74f8450e7.png"
               download="temp.png">点我下载</a>

            <button onclick="saveDialog()">打开文件夹</button>
        </div>

    </div>

    <div id="footer" class="footer">
        <hr/>
        我是有底线的<br/>
        Copyright@Forever <span class="span_hight">Virgo</span>
    </div>
</body>
</html>