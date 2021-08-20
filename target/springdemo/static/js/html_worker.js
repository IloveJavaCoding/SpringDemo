//====================web worker===================v
var time=0;
function timedCount(){
    time=time+1;
    postMessage(time);//向 HTML 页面传回一段消息
    setTimeout("timedCount()",500);//延时任务
}

timedCount();