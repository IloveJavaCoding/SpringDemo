//智能表格
let curpage = 1;//当前页
let allpage = 0;//总页数

let tBody;//数据显示区
let spanCur;//当前页
let spanAll;//总页

let headMap;//表头组: map(key, name)
let dataList;//数据缓存列表，原数据
let tempList = [];//数据缓存列表，临时操作数据

let maxLine = 10;//每页最大显示数据行数
let sortKey = "id";//当前排序列
let isIncrease = true;//默认小->大

/**
 * 初始化页面
 * @param theads
 */
function initView(theads) {
    const root = document.createElement("div");
    root.appendChild(initController());
    root.appendChild(initTable(theads));
    return root;
}

/**
 * 控制栏
 */
function initController() {
    const div = document.createElement("div");

    const span1 = document.createElement("span");
    span1.innerText = "最大行数：";

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

    const span2 = document.createElement("span");
    span2.innerText = "搜索：";
    const input = document.createElement("input");
    input.setAttribute("type", "text");
    input.addEventListener("input", function () {
        const value = input.value;
        console.log("input: " + value);
        if(value.length>0){
            //不为空时
            loadCurPageFilter(value);
        }else{
            //清空搜索
            updateTempData(dataList);
        }
    })

    div.appendChild(span1);
    div.appendChild(select);
    div.appendChild(span2);
    div.appendChild(input);

    return div;
}

/**
 * 初始化表格
 * @param theads 属性组
 */
function initTable(theads) {
    headMap = theads;
    const columns = theads.size;

    const table = document.createElement("table");
    table.setAttribute("class", "table_root");

    const tHead = document.createElement("thead");
    tHead.setAttribute("class", "table_head");
    const trH = document.createElement("tr");
    headMap.forEach(function (value, key) {
        const th = document.createElement("th");
        th.addEventListener("click", function () {
            sortData(key);
        });
        th.innerHTML=value;
        trH.appendChild(th);
    });
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
 * @param key
 */
function loadCurPageFilter(filter) {
    const temp = [];
    for(let i=0; i<dataList.length; i++){
        const obj = dataList[i];
        headMap.forEach(function (value, key) {
            const v = obj[key].toString();
            if(v.search(filter)!==-1){
                temp.push(obj);
                // 在forEach循环中，return 返回任何值，都只能退出当前循环。
                return true;
            }
        });
    }
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
        str += "<tr>";
        headMap.forEach(function (value, key) {
            str += "<td>"+ obj[key]+ "</td>";
        });
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
