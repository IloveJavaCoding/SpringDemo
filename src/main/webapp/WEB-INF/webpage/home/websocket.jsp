<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/9/9
  Time: 11:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>WebSocket</title>
    <script src="/SpringDemo/static/js/jquery3.5.1/jquery-3.5.1.min.js"></script>
    <script type="text/javascript">
        var websocket = null;

        //判断当前浏览器是否支持WebSocket
        function createConnect(){
            if(websocket==null){
                if('WebSocket' in window){
                    websocket = new WebSocket("ws://localhost:8080/SpringDemo/mainsocket");
                } else{
                    alert('Not support websocket')
                }

                //连接发生错误的回调方法
                websocket.onerror = function(){
                    setMessageInnerHTML("error");
                };

                //连接成功建立的回调方法
                websocket.onopen = function(){
                    setMessageInnerHTML("open");
                }

                //接收到消息的回调方法
                websocket.onmessage = function(event){
                    setMessageInnerHTML(event.data);
                }

                //连接关闭的回调方法
                websocket.onclose = function(){
                    setMessageInnerHTML("close");
                }

                //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
                window.onbeforeunload = function(){
                    websocket.close();
                }
            }else{
                alert("已创建！")
            }
        }

        //将消息显示在网页上
        function setMessageInnerHTML(innerHTML){
            document.getElementById('message').innerHTML += innerHTML + '<br/>';
        }

        //关闭连接
        function closeWebSocket(){
            websocket.close();
        }

        //发送消息
        function send(){
            var message = document.getElementById('text').value;
            if(websocket!=null){
                websocket.send(message);
            }else{
                alert("还未创建连接！")
            }
        }

        function sendMsg() {
            var msg = document.getElementById("msg").value;
            var id = document.getElementById("client").value;

            if(msg==="" || id===""){
                alert("输出不为空！");
                return;
            }else{
                console.log("服务端向 " + id + " 发送 " + msg);
            }
            $.ajax({
                url: '/SpringDemo/home/websocket_back',//请求url
                type: 'post',//请求类型
                cache: false,
                data: {
                    message:msg,
                    code:id
                },
                dataType: "json"//返回数据类型
            })
        }
    </script>
</head>
<body>
    <div>
        <input id="text" type="text"/>
        <button onclick="createConnect()">create</button>
        <button onclick="send()">Send</button>
        <button onclick="closeWebSocket()">Close</button>
    </div>

    <div id="message">
    </div>
    <br/>

    <div>
        <input id="msg" type="text" placeholder="msg"/>
        <input id="client" type="text" placeholder="client id"/>
        <button onclick="sendMsg()">Send</button>
    </div>
</body>
</html>
