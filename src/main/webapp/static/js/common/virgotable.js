//智能表格
let curpage = 1;//当前页
let allpage = 0;//总页数

let tBody;//数据显示区
let spanCur;//当前页
let spanAll;//总页
let checkBoxAll;//全选复选框

let headMap;//表头组: map(key, name)
let dataList;//数据缓存列表，原数据
let tempList = [];//数据缓存列表，临时操作数据
let selecList = [];//选中项列表；id

let maxLine = 10;//每页最大显示数据行数
let sortKey = "id";//当前排序列
let isIncrease = true;//默认小->大

// forEach方法中的function回调有三个参数：
// 第一个参数是遍历的数组内容，
// 第二个参数是对应的数组索引，
// 第三个参数是数组本身

/**
 * 初始化页面
 * 要求有id列，主键，值为int
 * @param theads
 */
function initView(theads) {
    const root = document.createElement("div");
    root.setAttribute("class", "layout_root");
    root.appendChild(initController());
    root.appendChild(initTable(theads));
    root.appendChild(initButton());

    return root;
}

/**
 * 控制栏
 */
function initController() {
    const div = document.createElement("div");
    div.setAttribute("class", "layout_controller");

    const span1 = document.createElement("span");
    span1.innerText = "显示行数：";

    const select = document.createElement("select");
    const option1 = document.createElement("option");
    option1.value = '10';
    option1.innerText = '10';
    option1.selected = true;
    const option2 = document.createElement("option");
    option2.value = '15';
    option2.innerText = '15';
    const option3 = document.createElement("option");
    option3.value = '20';
    option3.innerText = '20';
    const option4 = document.createElement("option");
    option4.value = '25';
    option4.innerText = '25';

    select.appendChild(option1);
    select.appendChild(option2);
    select.appendChild(option3);
    select.appendChild(option4);

    //监听 select 选项变化
    select.addEventListener("change", function () {
        maxLine = select.options[select.selectedIndex].value;
        updateShowData();
    });

    const layout_search = document.createElement("div");
    layout_search.setAttribute("class", "layout_search");
    const span2 = document.createElement("span");
    span2.innerText = "搜索：";
    const input = document.createElement("input");
    input.setAttribute("type", "text");
    input.addEventListener("input", function () {
        const value = input.value;
        if(value.length>0){
            //不为空时
            loadCurPageFilter(value);
        }else{
            //清空搜索
            updateTempData(dataList);
        }
    })
    layout_search.appendChild(span2);
    layout_search.appendChild(input);

    div.appendChild(span1);
    div.appendChild(select);
    div.appendChild(layout_search);

    return div;
}

/**
 * 初始化表格
 * @param theads 属性组
 */
function initTable(theads) {
    headMap = theads;
    const columns = theads.size + 2;//首列：选择框，尾列：操作栏

    const table = document.createElement("table");
    table.setAttribute("class", "layout_table");

    const tHead = document.createElement("thead");
    tHead.setAttribute("class", "table_head");
    const trH = document.createElement("tr");
    //首列：选择框
    const thA = document.createElement("th");
    thA.setAttribute("class", "table_th_a");
    checkBoxAll = document.createElement("input");
    checkBoxAll.setAttribute("type", "checkbox");
    checkBoxAll.value = "-1";//全选
    checkBoxAll.innerText = "全选";
    checkBoxAll.addEventListener("change", function () {
        console.log("select all: " + checkBoxAll.checked);
        //更新选中数据
        upadteChooseDataAll();
        //更新状态
        loadCurPage();
    });
    thA.appendChild(checkBoxAll);
    trH.appendChild(thA);
    headMap.forEach(function (value, key) {
        const th = document.createElement("th");
        th.addEventListener("click", function () {
            sortData(key);
        });
        th.innerHTML=value;
        trH.appendChild(th);
    });
    //尾列：操作栏
    const thZ = document.createElement("th");
    thZ.setAttribute("class", "table_th_z");
    thZ.innerHTML="操作";
    trH.appendChild(thZ);

    tHead.appendChild(trH);

    tBody = document.createElement("tbody");
    tBody.setAttribute("class", "table_body");

    const tFoot = document.createElement("tfoot");
    tFoot.setAttribute("class", "table_foot");
    const trF = document.createElement("tr");
    const tdF = document.createElement("td");
    tdF.colSpan = columns;

    const spanLast = document.createElement("span");
    spanLast.setAttribute("class", "span_button");
    spanLast.innerText = "上一页";
    spanLast.addEventListener("click", lastPage);

    const span1 = document.createElement("span");
    span1.innerText = "第";
    spanCur = document.createElement("span");
    spanCur.setAttribute("class", "span_hight");
    spanCur.innerText = curpage;
    const span2 = document.createElement("span");
    span2.innerText = "页";

    const span3 = document.createElement("span");
    span3.innerText = "共";
    spanAll = document.createElement("span");
    spanAll.setAttribute("class", "span_hight");
    spanAll.innerText = allpage;
    const span4 = document.createElement("span");
    span4.innerText = "页";

    const spanNext = document.createElement("span");
    spanNext.setAttribute("class", "span_button");
    spanNext.innerText = "下一页";
    spanNext.addEventListener("click", nextPage);

    tdF.appendChild(spanLast);
    tdF.appendChild(span1);
    tdF.appendChild(spanCur);
    tdF.appendChild(span2);
    tdF.appendChild(span3);
    tdF.appendChild(spanAll);
    tdF.appendChild(span4);
    tdF.appendChild(spanNext);
    trF.appendChild(tdF);
    tFoot.appendChild(trF);

    table.appendChild(tHead);
    table.appendChild(tBody);
    table.appendChild(tFoot);
    return table;
}

/**
 * 底部悬浮确定按钮
 */
function initButton() {
    const confirm = document.createElement("span");
    confirm.setAttribute("class", "layout_confirm_button")
    confirm.innerText = "确定";
    confirm.addEventListener("click", function () {
        returnSelectData();
    })
    return confirm;
}

/**
 * 设置数据源，更新缓存
 * @param data json数组
 */
function setData(data) {
    if(data!==null && data.length>0){
        dataList = data;
        updateTempData(data);
    }
}

/**
 * 筛选
 * @param filter
 */
function loadCurPageFilter(filter) {
    const temp = [];
    dataList.forEach(function (obj) {
        headMap.forEach(function (value, key) {
            const v = obj[key].toString();
            if(v.search(filter)!==-1){
                temp.push(obj);
                // 在forEach循环中，return 返回任何值，都只能退出当前循环。
                return true;
            }
        });
    });

    updateTempData(temp);
}

/**
* 加载当前应显示的数据
*/
function loadCurPage() {
    if(tempList!=null) {
        const size = tempList.length;
        const startIndex = (curpage - 1) * maxLine;
        let endIndex = curpage * maxLine;
        if(endIndex>size){
            endIndex = size;
        }
        if(size>startIndex){
            showData2(startIndex, endIndex);
        }
    }
}

/**
 * 根据选择的表头排序
 * @param key
 * @returns {undefined}
 */
function sortData(key) {
    if(key===sortKey){
        //更换顺序
        isIncrease = !isIncrease;
    }else{
        //新排序规则
        sortKey = key;
        isIncrease = true;
    }
    console.log("sort: " + key + ", increase: " + isIncrease);

    tempList.sort(function (a, b) {
        if(isIncrease){
            return sortVar(a[key], b[key]);
        }else{
            return sortVar(b[key], a[key]);
        }
    });

    updateShowData();
}

function sortVar(a, b) {
    //a>b 1
    //a<b -1
    //a==b 0
    let isnumber = (typeof(a) === "number");
    if(isnumber){
        return a-b;
    }else{
        if(a===b){
            return 0;
        }else if(a>b){
            return 1;
        }else {
            return -1;
        }
    }
}

/**
 * 刷新操作数据
 * @param temp
 */
function updateTempData(temp) {
    tempList = temp;
    updateShowData();
}

/**
 * 刷新显示列表
 */
function updateShowData() {
    curpage = 1;
    setCurPage();
    setPageNum();
    loadCurPage();
}

/**
 * 将数据显示到table
 * @param start 开始索引
 * @param end 结束索引
 */
function showData(start, end){
    let str = "";
    for(let i=start; i<end; i++){
        const obj = tempList[i];
        const id = obj.id;
        const name = obj.name;
        const thumb = obj.thumb;
        const type = obj.suffix;
        const dur = formatTime(obj.duration);
        const size = formatFileSize(obj.size);
        const resolve = obj.resolve;
        const createdate = obj.createdate;
        const url = obj.url;

        str += "<tr>";
        str += "<td>"+ id + "</td>";
        str += "<td>"+ name + "</td>";
        str += "<td><img src=\""+ thumb + "\" alt='暂无' width='80' height='45'/></td>";
        str += "<td>"+ type + "</td>";
        str += "<td>"+ dur + "</td>";
        str += "<td>"+ size + "</td>";
        str += "<td>"+ resolve + "</td>";
        str += "<td>"+ createdate + "</td>";
        str += "<td>";
        str += "<button onclick='openUrl(\""+url+"\")'>预览</button>";
        str += "<button onclick='download2(\""+url+"\", \""+name+"\", \""+type+"\")'>下载</button>";
        // str += "<button onclick='download("+id+")'>下载</button>";
        str += "<button onclick='deleteFile("+id+")'>删除</button>";
        str += "</td>";
        str += "</tr>";
    }
    tBody.innerHTML = str;
}

/**
 * 将数据显示到table， 仅读，按照表头顺序
 * @param start 开始索引
 * @param end 结束索引
 */
function showData2(start, end){
    let str = "";
    for(let i=start; i<end; i++){
        const obj = tempList[i];
        const id = obj.id;

        if(i%2===0){
            //单行
            str += "<tr class='tr_single'>";
        }else{
            //双行
            str += "<tr class='tr_double'>";
        }

        if(checkBoxAll.checked){
            str += "<td><input type='checkbox' value='"+ id +"' checked='checked' onchange='upadteChooseData(this)'/></td>";//要求有id栏（主键）
        }else{
            str += "<td><input type='checkbox' value='"+ id +"' onchange='upadteChooseData(this)'/></td>";//要求有id栏（主键）
        }
        headMap.forEach(function (value, key) {
            str += "<td>"+ obj[key]+ "</td>";
        });
        str += "<td>";
        // str += "<button onclick='openUrl(\""+url+"\")'>预览</button>";
        // str += "<button onclick='download2(\""+url+"\", \""+name+"\", \""+type+"\")'>下载</button>";
        str += "<button onclick='deleteData("+id+")'>删除</button>";
        str += "</td>";
        str += "</tr>";
    }
    tBody.innerHTML = str;
}

/**
 * 上一页
 */
function lastPage() {
    if(curpage>1){
        curpage--;
        setCurPage();
        loadCurPage();
    }else{
        layer.msg("当前为第一页！")
    }
}

/**
 * 下一页
 */
function nextPage() {
    if(curpage<allpage){
        curpage++;
        setCurPage();
        loadCurPage();
    }else{
        layer.msg("当前为最后一页！")
    }
}

/**
 * 设置当前页数
 */
function setCurPage() {
    spanCur.innerText = curpage;
}

/**
 * 设置总页数
 */
function setPageNum() {
    if(tempList!=null){
        const size = tempList.length;
        if(size%maxLine===0){
            allpage = Math.floor(size/maxLine);
        }else{
            //向上取整
            allpage = Math.ceil(size/maxLine);
        }
        spanAll.innerText = allpage;
    }
}

//全选、非全选更新状态
function upadteChooseDataAll() {
    selecList = [];
    if(checkBoxAll.checked){
        tempList.forEach(function (value, index) {
            selecList.push(tempList[index].id);
        });
    }
}

/**
 * 某个复选框状态变化时更新
 * @param checkbox
 */
function upadteChooseData(checkbox) {
    let id = checkbox.value;//string
    id = parseInt(id);
    // let index = selecList.existInArray(id);
    let index = selecList.indexOf(id);
    if(checkbox.checked){
        //选中
        if(index===-1){
            //不存在则添加
            selecList.push(id);
        }
    }else{
        checkBoxAll.checked = false;
        if(index!==-1){
            //存在则删除
            selecList.splice(index, 1);
        }
    }
}

function deleteData(id) {
    if(tempList!=null){
        tempList.forEach(function (value) {
            if(value.id===id){
                //找到了
                console.log("delete: " + id);
                return true;
            }
        })
    }
}

function returnSelectData() {
    console.log("return: " + selecList.toString())
}

//自定义 indexof
Array.prototype.existInArray = function (ele) {
    let out = -1;
    if(this.length<1){
        return out;
    }

    this.forEach(function (value, index) {
        if(value===ele){
            console.log("找到了： " + index);
            out = index;
            return true;
        }
    })

    return out;
}
