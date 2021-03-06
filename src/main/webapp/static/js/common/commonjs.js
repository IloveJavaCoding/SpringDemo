
/**
 * 校验登入用户
 */
function onLoad(){
    const name = getLoginUser();
    console.log("name: " + name);
    //是否已登入
    if(name!=="null"){
        var admin = document.getElementById("admin");
        if(name === "admin" || name === "virgo"){
            console.log("管理员？", "yes");
            admin.style.visibility = "visible";
        }else{
            console.log("管理员？", "no");
            admin.style.visibility = "hidden";
        }
    }else{
        //跳转到登入页
        // window.location.href="/SpringDemo/account/go_login";
        window.location.replace('account/go_login');
    }
}

//监听页面滚动控制返回顶部按钮显隐
window.addEventListener('scroll',function(){
    var go_top = document.getElementById("go_top");
    if(go_top!=null){
        var st = document.documentElement.scrollTop + document.body.scrollTop; //获取滚动后的高度
        if(st > 900){
            go_top.style.visibility="visible";
        }else{
            go_top.style.visibility="hidden";
        }
    }
});

/**
 * 将byte长度转换为单位长度
 * @param size
 */
function formatFileSize(size) {
    var mb = 1024*1024;//MB
    const kb = 1024;//KB
    if(size>=mb){
        var m = size/mb;
        return m.toFixed(2) + " MB";
    }else if(size>=kb){
        var k = size/kb;
        return k.toFixed(2) + " KB";
    }else{
        return size + "B";
    }
}

/**
 * 将m长度转换为单位长度
 * @param time s
 */
function formatTime(time) {
    if(time<=0){
        return "00";
    }
    var H = 3600;//h
    var M = 60;//m
    var h,m,s;
    if(time>=H){
        h = Math.floor(time/H);
        m = Math.floor((time - h*H)/M);
        s = time - h*H - m*M;
        return formatHMS(h)+":"+formatHMS(m)+":"+formatHMS(s);
    }else if(time>=M){
        m = Math.floor(time/M);
        s = time - m*M;
        return formatHMS(m)+":"+formatHMS(s);
    }else{
        return "00:"+formatHMS(time);
    }
}

function formatHMS(t) {
    if(t<10){
        return "0" + t;
    }
    return t;
}

/**
 * 在新页面打开url
 * @param url
 */
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












// function getUser() {
//     if(typeof(Storage)!=="undefined") {
//         return sessionStorage.getItem("username");
//         // 是的! 支持 localStorage  sessionStorage 对象!
//         // 一些代码.....
//     } else {
//         // 抱歉! 不支持 web 存储。
//         return null;
//     }
// }

// function getLoginUser() {
//     return '<%=session.getAttribute("username")%>';
// }

//
// //打开文件夹
// /**
//  * Shell.BrowseForFolder(WINDOW_HANDLE, Message, OPTIONS, strPath)函数
//  * strPath:
//  * 0x11--我的电脑
//  * 0 --桌面
//  * "c:\\"--系统C盘
//  * @returns {string}
//  * @constructor
//  */
// function browseFolder(){
//     try{
//         var Message = "请选择文件夹";  //选择框提示信息
//         var shell = new ActiveXObject( "Shell.Application" );
//         var forFolder = shell.BrowseForFolder(0,Message,0x0040,0x11);//起始目录为：我的电脑
//         //var Folder = Shell.BrowseForFolder(0,Message,0); //起始目录为：桌面
//         if(forFolder != null){
//             forFolder = forFolder.items();  // 返回 FolderItems 对象
//             forFolder = forFolder.item();  // 返回 Folderitem 对象
//             forFolder = forFolder.Path;   // 返回路径
//             if(forFolder.charAt(forFolder.length-1) !== "\\"){
//                 forFolder = forFolder + "\\";
//             }
//             console.log("choose path: " + forFolder)
//             return forFolder;
//         }
//     }catch(e){
//         alert(e.message);
//     }
// }
//
// function saveDialog() {
//     try{
//         OCXResult.Result.value = "";
//         //创建一个ActiveX对象
//         var fd = new ActiveXObject("MSComDlg.CommonDialog");
//         //设置保存文件类型选项
//         fd.Filter = "JPG图片|*.jpg";
//         fd.FilterIndex = 2;
//         fd.fileName="HelloWorld.jpg";
//         // 必须设置文件的最大内存
//         fd.MaxFileSize = 256;
//         //打开“另存为”对话框
//         fd.ShowSave();
//     }catch(e){
//         confirm("您的系统尚未注册COMDLG32.OCX，请先下载注册此控件后再重新进行操作");
//     }
// }
