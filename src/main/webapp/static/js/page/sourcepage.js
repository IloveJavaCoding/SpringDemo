/**
 * 下载弹框
 * @param url 下载链接
 * @param name 文件名
 * @param suffix 后缀
 */
function downloadDialog(url, name, suffix) {
    const oReq = new XMLHttpRequest();
    oReq.open('GET', url, true);
    oReq.responseType = 'arraybuffer';
    // let loading = top.layer.alert("正在创建下载链接...", {icon: 0, title:"下载中。。。"});
    oReq.onload = function () {
        if (oReq.status === 200 || oReq.status === 0) {
            // console.log(oReq.response);
            const arrayBuffer = oReq.response; // Note: not oReq.responseText
            const byteArray = new Uint8Array(arrayBuffer);
            const aLink = window.parent.document.createElement('a');
            const body = window.parent.document.querySelector("body");
            const blob = new Blob([byteArray], {type: 'application/octet-stream'});
            aLink.download = name + "." + suffix;
            aLink.href = URL.createObjectURL(blob);
            aLink.display = 'none';
            aLink.target = '_blank';
            body.appendChild(aLink);
            aLink.click();
            body.removeChild(aLink);
            window.URL.revokeObjectURL(aLink.href);
        }
        else {
            top.layer.alert("下载失败！");
        }
        // top.layer.close(loading);
    };
    oReq.send();
}