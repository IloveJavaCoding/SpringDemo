<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/9/1
  Time: 11:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>iTable</title>
    <link rel="stylesheet" type="text/css" href="/SpringDemo/static/css/common/itable.css"/>
    <script src="/SpringDemo/static/js/jquery3.5.1/jquery-3.5.1.min.js"></script>
    <script src="/SpringDemo/static/js/layer/layer.js"></script>
    <script type="text/javascript" src="/SpringDemo/static/js/common/virgotable.js"></script>
    <script type="text/javascript">
        const json = [
            {id: 1, name: 'asa', gender:'f', age: 15},
            {id: 2, name: 'bdbdddddsssdd', gender:'m', age: 16},
            {id: 3, name: 'cvc', gender:'f', age: 16},
            {id: 4, name: 'acd', gender:'f', age: 17},
            {id: 5, name: 'dsa', gender:'f', age: 13},
            {id: 6, name: 'fds', gender:'f', age: 14},
            {id: 7, name: 'sks', gender:'f', age: 12},
            {id: 8, name: 'eaa', gender:'m', age: 17},
            {id: 9, name: 'hmy', gender:'f', age: 18},
            {id: 10, name: 'cxs', gender:'f', age: 16},
            {id: 11, name: 'tyu', gender:'m', age: 14},
            {id: 12, name: 'opj', gender:'m', age: 15},
            {id: 13, name: 'llg', gender:'f', age: 17},
            {id: 14, name: 'qwa', gender:'m', age: 16}
            ];

        function addTable() {
            var root = document.getElementById("root_view");
            var head = new Map([['id','id'], ['name','名字'], ['gender','性别'], ['age','年龄']]);
            root.appendChild(initView(head));

            setData(json);
        }
    </script>
</head>
<body id="root_view" onload="addTable()">

</body>
</html>
