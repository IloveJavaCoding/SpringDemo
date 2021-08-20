/**
 *javascript:
 *1. 使 HTML 页面具有更强的动态和交互性;
 *2. 只有在浏览器不支持脚本或者禁用脚本时，才会显示 <noscript> 元素中的内容;
 *3. 统一变量var;

ps：ele: 某一个标签元素
1. 输出
document.write("content");

2. 绑定标签
document.getElementById("id");
document.querySelector('#id');

3. 获取标签值
document.getElementById("id").value;  

4. 赋值输出
ele.innerHTML = "xxxxx";

5. 弹框
alert("xxx");

6. 函数返回值
return xxx;
*/


//=======================画图===========================
function draw(){
	//1. 形状
	var can = document.getElementById("canvas_1");
	var ctx = can.getContext("2d");

	var cWidth = 300;
	var cHeight = 300;
	
	//路径、矩形、圆形、字符
	var rWidth = 200;
	var rHeight = 80;
	
	var star_x = 80;
	var star_y = 20;
	var star_off = 10;
	var star_len = 15;
	
	ctx.fillStyle="#66ccff";
	ctx.fillRect(50,0,rWidth,rHeight);

	ctx.beginPath();
	ctx.arc(150, 40, 40, 0, 2*Math.PI);
	ctx.stroke();
	
	ctx.moveTo(star_x,star_y);
	ctx.lineTo(star_x-star_off, star_y+star_len*2.5);
	ctx.lineTo(star_x+star_len, star_y+star_off);
	ctx.lineTo(star_x-star_len, star_y+star_off);
	ctx.lineTo(star_x+star_off, star_y+star_len*2.5);
	ctx.lineTo(star_x,star_y);
	ctx.stroke();
	
	var star_x = 220;
	
	ctx.moveTo(star_x,star_y);
	ctx.lineTo(star_x-star_off, star_y+star_len*2.5);
	ctx.lineTo(star_x+star_len, star_y+star_off);
	ctx.lineTo(star_x-star_len, star_y+star_off);
	ctx.lineTo(star_x+star_off, star_y+star_len*2.5);
	ctx.lineTo(star_x,star_y);
	ctx.stroke();
	
	//设置字体大小与样式:上面设置会影响后面，除非重新设定
	ctx.font="25px Arial";
	ctx.strokeStyle="#ff0000";
	ctx.strokeText("中国", cWidth/2-25, rHeight/2);
	
	// 创建渐变
	var grd=ctx.createLinearGradient(0,0,cWidth,0);
	grd.addColorStop(0,"red");
	//中间可添加多个颜色（0.x, color);
	grd.addColorStop(1,"white");
	
	// 填充渐变
	ctx.fillStyle=grd;
	ctx.fillRect(100,100,100,100);
	
	ctx.font="15px Verdana";
	ctx.fillText("中华人民共和国万岁， 世界人民大团结万岁", 10, cHeight/4*3);
}

//=======================拖动===========================
function drag(event){
	event.dataTransfer.setData("key", event.target.id);
}

function dragOver(event){
	/*避免浏览器对数据的默认处理（drop 事件的默认行为是以链接形式打开）*/
	event.preventDefault();
}

function drop(event){
	event.preventDefault();
	var id = event.dataTransfer.getData("key");
	event.target.appendChild(document.getElementById(id));
}

//====================定位: 需用户授权=====================
function getLocation(id){
	var ele = document.getElementById(id);
	
	ele.innerHTML="获取中...";
    if (navigator.geolocation){
		navigator.geolocation.getCurrentPosition(showPosition, showError);
		//navigator.geolocation.watchPosition(showPosition);
		//watchPosition() - 返回用户的当前位置，并继续返回用户移动时的更新位置（就像汽车上的 GPS）。
		//clearWatch() - 停止 watchPosition() 方法
    }else{
        ele.innerHTML="该浏览器不支持获取地理位置。";
    }
}

function showPosition(position){
	ele.innerHTML = "纬度: " + position.coords.latitude + 
	"<br>经度: " + position.coords.longitude;	
	
	/*
	 coords.latitude	十进制数的纬度
	 coords.longitude	十进制数的经度
	 coords.accuracy	位置精度
	 coords.altitude	海拔，海平面以上以米计
	 coords.altitudeAccuracy	位置的海拔精度
	 coords.heading		方向，从正北开始以度计
	 coords.speed		速度，以米/每秒计
	 timestamp			响应的日期/时间
	*/
}

function showPositionInMap(position){
	lat = position.coords.latitude;
	lon = position.coords.longitude;
	var latlon = new google.maps.LatLng(lat, lon)
	
	var mapview = document.getElementById('c_location_map')
	mapview.style.height = '250px';
	mapview.style.width = '500px';

	var myOptions={
		center:latlon,zoom:14,
		mapTypeId:google.maps.MapTypeId.ROADMAP,
		mapTypeControl:false,
		navigationControlOptions:{style:google.maps.NavigationControlStyle.SMALL}
	};
	var map=new google.maps.Map(mapview,myOptions);
	var marker=new google.maps.Marker({position:latlon,map:map,title:"You are here!"});
}

function showError(error){
    switch(error.code) {
        case error.PERMISSION_DENIED:
            ele.innerHTML="用户拒绝对获取地理位置的请求。"
            break;
        case error.POSITION_UNAVAILABLE:
            ele.innerHTML="位置信息是不可用的。"
            break;
        case error.TIMEOUT:
            ele.innerHTML="请求用户地理位置超时。"
            break;
        case error.UNKNOWN_ERROR:
            elee.innerHTML="未知错误。"
            break;
    }
}

// <!--引入百度 API，"ak=" 后面一串码是密钥，最好自己申请-->
//<script type="text/javascript" src="https://api.map.baidu.com/api?v=2.0&ak=7a6QKaIilZftIMmKGAFLG7QT1GLfIncg"></script>

//=====================视频===========================
function playPause(id){ 
	var myVideo = document.getElementById(id);
	if (myVideo.paused) 
	  myVideo.play(); 
	else 
	  myVideo.pause(); 
} 

function makeFull(id){
	var myVideo = document.getElementById(id);
	//myVideo.width='100%';
	myVideo.requestFullscreen()
} 

function makeSmall(id){ 
	var myVideo = document.getElementById(id);
	myVideo.width=160; 
} 

function makeNormal(id){
	var myVideo = document.getElementById(id);
	myVideo.width=320; 
} 

//=========================web 存储==========================
/**
1. localStorage - 用于长久保存整个网站的数据，保存的数据没有过期时间，直到手动去除;
		只要在相同的协议、相同的主机名、相同的端口下，就能读取/修改到同一份localStorage数据;
2. sessionStorage - 用于临时保存同一窗口(或标签页)的数据，在关闭窗口或标签页之后将会删除这些数据;
		除了协议、主机名、端口外，还要求在同一窗口（也就是浏览器的标签页）下;
3. 数据以 键/值(字符串) 对存在, web网页的数据只允许该网页访问使用;(自行创建)

if(typeof(Storage)!=="undefined")
{
    // 是的! 支持 localStorage  sessionStorage 对象!
    // 一些代码.....
} else {
    // 抱歉! 不支持 web 存储。
}

保存数据：localStorage.setItem(key,value);
读取数据：localStorage.getItem(key);
删除单个数据：localStorage.removeItem(key);
删除所有数据：localStorage.clear();
得到某个索引的key：localStorage.key(index);

Number(String) 转int
---json <--> object----:
var str = JSON.stringify(obj);  //将对象转换为字符串
var obj = JSON.parse(str); 		//将字符串转换为 JSON 对象
*/

//=============================sql 数据库:异步执行==========================
/**
1. openDatabase：使用现有的数据库或者新建的数据库创建一个数据库对象。
	数据库名称
	版本号
	描述文本
	数据库大小
	创建回调（可省略）
2. transaction：控制一个事务，以及基于这种情况执行提交或者回滚。
3. executeSql：执行实际的 SQL 查询。
	1. sql;
	2. 参数；
	3. result;
*/

var db = openDatabase("VirgoGame", "1.0", "summon hero", 2*1024*1024);

function deleteDatabase(){
	db.transaction(function(tx){
		tx.executeSql('DROP DATABASE VirgoGame');
	});
}

//hero table
function createTable(){
	db.transaction(function(tx){
		tx.executeSql('CREATE TABLE IF NOT EXISTS HERO(id unique, name, gender, type, count)');
	});
}

function deleteTable(){
	db.transaction(function(tx){
		tx.executeSql('DROP TABLE HERO');
	});
}

function summon(){
	var random = Math.random();
	var hero = new Object;
	var num = Math.floor(random*10%5);
	switch(num){
		case 0:
			hero.id=1;
			hero.name="貂蝉";
			hero.gender="女";
			hero.type="法师";
			break;
		case 1:
			hero.id=2;
			hero.name="阿离";
			hero.gender="女";
			hero.type="射手";
			break;
		case 2:
			hero.id=3;
			hero.name="赵云";
			hero.gender="男";
			hero.type="战士";
			break;
		case 3:
			hero.id=4;
			hero.name="李白";
			hero.gender="男";
			hero.type="刺客";
			break;
		case 4:
			hero.id=5;
			hero.name="大乔";
			hero.gender="女";
			hero.type="辅助";
			break;
	}
	var platform = document.getElementById("c_sql_div");
	platform.innerHTML = "获得英雄\n"+ JSON.stringify(hero);
	
	//存入数据库
	saveHero(hero);
	
}

function saveHero(hero){
	//查看有没有
	db.transaction(function(tx){
		tx.executeSql('SELECT * FROM HERO WHERE id=?', [hero.id], 
			function(tx, results){
				var count = results.rows.length;
				// alert(count);
				//如果不存在 创建
				//否则 更新count
				if(count>0){
					updateHero(hero.id, count+1);
				}else{
					insertHero(hero);
				}
		}, null);
	});
}

/**
插入：
1. INSERT INTO table_name VALUES (value1,value2,value3,...);
2. INSERT INTO table_name (column1,column2,column3,...) VALUES (value1,value2,value3,...);
*/
function insertHero(hero){
	db.transaction(function(tx){
		tx.executeSql('INSERT INTO HERO (id, name, gender, type, count) VALUES (?,?,?,?,?)',
			[hero.id, hero.name, hero.gender, hero.type, 1]);
	});
}

/**
更新 
UPDATE table_name SET column1=value1,column2=value2,... WHERE some_column=some_value;
*/
function updateHero(id, count){
	db.transaction(function(tx){
		tx.executeSql('UPDATE HERO SET count=? WHERE id=?', [count,id]);
	});
}

/**
查看：
1. SELECT column_name,column_name FROM table_name;
2. SELECT * FROM table_name;
3. SELECT DISTINCT column_name,column_name FROM table_name;(返回唯一不同的值)
*/
function searchHero(id){
	db.transaction(function(tx){
		tx.executeSql('SELECT * FROM HERO WHERE id=?', [id], 
			function(tx, results){
				return results.rows.length;
		}, null);
	});
}

// ASC|DESC
/**
排序
SELECT column_name,column_name FROM table_name ORDER BY column_name,column_name ASC|DESC;
*/
function listHero(){
	db.transaction(function(tx){
		tx.executeSql('SELECT * FROM HERO ORDER BY count DESC', [], 
			function(tx, results){
				var len = results.rows.length;
				var msg;
				if(len>0){
					msg = '<table width="100%">'+
							"<tr>" +
								"<th>id</th>" +
								"<th>name</th>" +
								"<th>gender</th>" +
								"<th>type</th>" +
								"<th>count</th>" +
							 "</tr>";
					
					for (var i = 0; i < len; i++){
						var hero = results.rows.item(i);
						msg += "<tr>" +
								'<td class="font_center">' + hero.id + "</td>" +
								'<td class="font_center">' + hero.name + "</td>" +
								'<td class="font_center">' + hero.gender + "</td>" +
								'<td class="font_center">' + hero.type + "</td>" +
								'<td class="font_center">' + hero.count+ "</td>" +
								 "</tr>";
					}
				
					msg += "</table>";
					
				}else{
					msg = "空空如也的英雄池!";
				}
				document.querySelector('#c_sql_div_data').innerHTML =  msg;
		}, null);
	});
}

/**
删除:
1. DELETE FROM table_name WHERE some_column=some_value;
2. 删除所有数据; 
	DELETE FROM table_name; 
	DELETE * FROM table_name;
*/
function clearAll(){
	db.transaction(function(tx) {
		tx.executeSql('DELETE FROM HERO');
	});
	
	document.querySelector('#c_sql_div_data').innerHTML = "空空如也的英雄池!";
}

//=========================web worker: chrome 不允许通过本地文件访问使用web worker============================
var worker;
 
function startWorker() {
	//检测用户的浏览器是否支持
    if(typeof(Worker) !== "undefined") {
		//检测是否存在 worker，如果不存在，创建一个新的对象
        if(typeof(worker) == "undefined") {
            worker = new Worker("html_worker.js");
        }
		//"onmessage" 事件监听器
        worker.onmessage = function(event) {
            document.getElementById("c_worker_result").innerHTML = event.data;
        };
    } else {
        document.getElementById("c_worker_result").innerHTML = "抱歉，你的浏览器不支持 Web Workers...";
    }
}
 
function stopWorker() {
	//终止 web worker，并释放浏览器/计算机资源
    worker.terminate();
    worker = undefined;
}

//===============================================图片弹框======================================
function showImgDialog() {
	var img = document.getElementById("image_2");
	var dialog = document.getElementById('img_dialog');
	var modalImg = document.getElementById("dialog_content");
	var captionText = document.getElementById("dialog_caption");

    dialog.style.display = "block";
    modalImg.src = img.src;
    modalImg.alt = img.alt;
    captionText.innerHTML = img.alt;
}

// 点击 <span> 元素上的 (x), 关闭模态框
function closeImgDialog() { 
	var dialog = document.getElementById('img_dialog');
    dialog.style.display = "none";
}