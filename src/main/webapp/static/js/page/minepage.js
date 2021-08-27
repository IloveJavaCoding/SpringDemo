const motto1 = "When there is a higher mountain to climb in one's heart,he will not care about the mud around the foot, he may face the pain that the commons can not bear in the most peaceful way.";
const motto2 = "当一个人的心中有着更高的山峰想去攀登时，他就不会在意脚下的泥沼，他才可能用最平静的方式去面对一般人难以忍受的痛苦！";
let isEnglish = true;//默认为英语

function init(){
    const book1 = document.getElementById("bo1");//http://www.dushu369.com/waiguomingzhu/nwdsl/
    const book2 = document.getElementById("bo2");//http://www.dushu369.com/waiguomingzhu/dfqmm/
    const book3 = document.getElementById("bo3");//http://www.99lib.net/book/92/

    const handler1 = function () {
        document.location = "http://www.dushu369.com/waiguomingzhu/nwdsl/";
    };
    const handler2 = function () {
        document.location = "http://www.dushu369.com/waiguomingzhu/dfqmm/";
    };
    const handler3 = function () {
        document.location = "http://www.99lib.net/book/92/";
    };
    book1.addEventListener("click", handler1);
    book2.addEventListener("click", handler2);
    book3.addEventListener("click", handler3);
}

function translateMotto(){
    const motto = document.getElementById("span_motto");
    if(isEnglish){
        motto.innerHTML=motto2;
        isEnglish = false;
    }else{
        motto.innerHTML=motto1;
        isEnglish = true;
    }
}

/*
<ul>
    <li><a href="http://music.163.com/song?id=413812448&userid=331391548">周深 - 大鱼.mp3</a></li>
    <li><a href="http://music.163.com/song?id=4873075&userid=331391548">秦时明月 - 情动.mp3</a></li>
    <li><a href="http://music.163.com/song?id=5271400&userid=331391548">贵族乐团 - 寂静之声.mp3</a></li>
</ul>
*/