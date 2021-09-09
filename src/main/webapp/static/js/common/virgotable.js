//智能表格
//常量：
//1. id
const ATTR_ID = 'id';
const ATTR_CLASS = 'class';
const ATTR_TYPE = 'type';

const ID_TABLE_BODY = 'table_body';
const ID_SPAN_CONFIRM_BUTTON = 'confirm_button';
const ID_CHECK_BOX_ALL = 'checkBoxAll';
const ID_SPAN_CUR_PAGE = 'span_cur';
const ID_SPAN_ALL_PAGE = 'span_all';

const CLASS_LAYOUT_ROOT = 'layout_root';
const CLASS_LAYOUT_CONTROL = 'layout_controller';
const CLASS_LAYOUT_SEARCH = 'layout_search';
const CLASS_LAYOUT_TABLE = 'layout_table';
const CLASS_LAYOUT_TABLE_HEAD = 'table_head';
const CLASS_LAYOUT_TABLE_TH_A = 'table_th_a';
const CLASS_LAYOUT_TABLE_TH_Z = 'table_th_z';
const CLASS_LAYOUT_TABLE_BODY = 'table_body';
const CLASS_LAYOUT_TABLE_TR_SINGLE = 'table_tr_single';
const CLASS_LAYOUT_TABLE_TR_DOUBLE = 'table_tr_double';
const CLASS_LAYOUT_TABLE_FOOT = 'table_foot';
const CLASS_LAYOUT_P_BUTTON = 'p_button';
const CLASS_LAYOUT_SPAN_HIGH_LIGHT = 'span_highlight';
const CLASS_LAYOUT_CONFIRM_BUTTON = 'layout_confirm_button';

const TYPE_TEXT = 'text';
const TYPE_CHECK_BOX = 'checkbox';

//2. listener type
const LISTENER_TYPE_CHANGE = 'change';
const LISTENER_TYPE_CLICK = 'click';
const LISTENER_TYPE_INPUT = 'input';

//3. text
const TEXT_MAX_LINE = '显示行数：';
const TEXT_SEARCH = '搜索：';
const TEXT_TH_OPE = '操作';
const TEXT_OPE_DELETE = '删除';
const TEXT_LAST_PAGE = '上一页';
const TEXT_NEXT_PAGE = '下一页';
const TEXT_CONFIRM = '确定';
const TEXT_NOTCIE_FIRST = '当前为第一页！';
const TEXT_NOTCIE_END = '当前为最后一页！';

//变量：
let curpage = 1;//当前页
let allpage = 0;//总页数

let headMap;//表头组: map(key, name)
let dataList;//数据缓存列表，原数据
let tempList = [];//数据缓存列表，临时操作数据
let selecList = [];//选中项列表；id

let maxLine = 10;//每页最大显示数据行数
let sortKey = "id";//当前排序列
let isIncrease = true;//默认小->大

////////////////////////////////////////////////////////////////////////////
/**
 * 初始化页面
 * 要求有id列，主键，值为int
 * @param theads
 */
function createTable(theads) {
    const root = document.createElement("div");
    root.setAttribute(ATTR_CLASS, CLASS_LAYOUT_ROOT);
    root.appendChild(initController());
    root.appendChild(initTable(theads));
    root.appendChild(initButton());

    return root;
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
 * 控制确认按钮的显隐
 */
function showButton(visible) {
    let button = document.getElementById(ID_SPAN_CONFIRM_BUTTON);
    if(visible){
        button.style.visibility = "visible";
    }else{
        button.style.visibility = "hidden";
    }
}


//////////////////////////////////////////////////////////////////////////
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
    setTableDate(str);
}

/**
 * 将数据显示到table，通用，仅读，按照表头顺序
 * @param start 开始索引
 * @param end 结束索引
 */
function showDataCommon(start, end){
    let str = "";
    for(let i=start; i<end; i++){
        const obj = tempList[i];
        const id = obj.id;

        if(i%2===0){
            //单行
            str += "<tr class='"+CLASS_LAYOUT_TABLE_TR_SINGLE+"'>";
        }else{
            //双行
            str += "<tr class='"+CLASS_LAYOUT_TABLE_TR_DOUBLE+"'>";
        }

        if(getCheckBoxALLState()){
            str += "<td><input type='"+TYPE_CHECK_BOX+"' value='"+ id +"' checked='checked' onchange='upadteChooseData(this)'/></td>";//要求有id栏（主键）
        }else{
            str += "<td><input type='"+TYPE_CHECK_BOX+"' value='"+ id +"' onchange='upadteChooseData(this)'/></td>";//要求有id栏（主键）
        }

        headMap.forEach(function (value, key) {
            str += "<td>"+ obj[key]+ "</td>";
        });

        str += "<td>";
        str += "<button onclick='deleteData("+id+")'>"+TEXT_OPE_DELETE+"</button>";
        str += "</td>";
        str += "</tr>";
    }
    setTableDate(str);
}

//todo
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
    return selecList.toString();
}

///////////////////////////////////////////////////////////////////////////
/**
 * 控制栏
 */
function initController() {
    const div = document.createElement("div");
    div.setAttribute(ATTR_CLASS, CLASS_LAYOUT_CONTROL);

    const span1 = document.createElement("span");
    span1.innerText = TEXT_MAX_LINE;

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
    select.addEventListener(LISTENER_TYPE_CHANGE, function () {
        maxLine = select.options[select.selectedIndex].value;
        updateShowData();
    });

    const layout_search = document.createElement("div");
    layout_search.setAttribute(ATTR_CLASS, CLASS_LAYOUT_SEARCH);
    const span2 = document.createElement("span");
    span2.innerText = TEXT_SEARCH;
    const input = document.createElement("input");
    input.setAttribute(ATTR_TYPE, TYPE_TEXT);
    input.addEventListener(LISTENER_TYPE_INPUT, function () {
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
    table.setAttribute(ATTR_CLASS, CLASS_LAYOUT_TABLE);

    const tHead = document.createElement("thead");
    tHead.setAttribute(ATTR_CLASS, CLASS_LAYOUT_TABLE_HEAD);
    const trH = document.createElement("tr");
    //首列：选择框
    const thA = document.createElement("th");
    thA.setAttribute(ATTR_CLASS, CLASS_LAYOUT_TABLE_TH_A);

    const checkBoxAll = document.createElement("input");
    checkBoxAll.setAttribute(ATTR_ID, ID_CHECK_BOX_ALL);
    checkBoxAll.setAttribute(ATTR_TYPE, TYPE_CHECK_BOX);
    checkBoxAll.addEventListener(LISTENER_TYPE_CHANGE, function () {
        //更新选中数据
        upadteChooseDataAll(checkBoxAll.checked);
        //更新状态
        loadCurPage();
    });
    thA.appendChild(checkBoxAll);
    trH.appendChild(thA);
    headMap.forEach(function (value, key) {
        const th = document.createElement("th");
        th.addEventListener(LISTENER_TYPE_CLICK, function () {
            sortData(key);
        });
        th.innerText=value;
        trH.appendChild(th);
    });

    //尾列：操作栏
    const thZ = document.createElement("th");
    thZ.setAttribute(ATTR_CLASS, CLASS_LAYOUT_TABLE_TH_Z);
    thZ.innerText=TEXT_TH_OPE;
    trH.appendChild(thZ);
    tHead.appendChild(trH);

    const tBody = document.createElement("tbody");
    tBody.setAttribute(ATTR_ID, ID_TABLE_BODY);
    tBody.setAttribute(ATTR_CLASS, CLASS_LAYOUT_TABLE_BODY);

    const tFoot = document.createElement("tfoot");
    tFoot.setAttribute(ATTR_CLASS, CLASS_LAYOUT_TABLE_FOOT);
    const trF = document.createElement("tr");
    const tdF = document.createElement("td");
    tdF.colSpan = columns;

    const pLast = document.createElement("p");
    pLast.setAttribute(ATTR_CLASS, CLASS_LAYOUT_P_BUTTON);
    pLast.innerText = TEXT_LAST_PAGE;
    pLast.addEventListener(LISTENER_TYPE_CLICK, lastPage);

    const pCur = document.createElement("p");
    pCur.innerHTML = "第 <span id='"+ID_SPAN_CUR_PAGE+"' class='"+CLASS_LAYOUT_SPAN_HIGH_LIGHT+"'></span> 页";

    const pAll = document.createElement("p");
    pAll.innerHTML = "共 <span id='"+ID_SPAN_ALL_PAGE+"' class='"+CLASS_LAYOUT_SPAN_HIGH_LIGHT+"'></span> 页";

    const pNext = document.createElement("p");
    pNext.setAttribute(ATTR_CLASS, CLASS_LAYOUT_P_BUTTON);
    pNext.innerText = TEXT_NEXT_PAGE;
    pNext.addEventListener(LISTENER_TYPE_CLICK, nextPage);

    tdF.appendChild(pLast);
    tdF.appendChild(pCur);
    tdF.appendChild(pAll);
    tdF.appendChild(pNext);

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
    confirm.setAttribute(ATTR_ID, ID_SPAN_CONFIRM_BUTTON);
    confirm.setAttribute(ATTR_CLASS, CLASS_LAYOUT_CONFIRM_BUTTON)
    confirm.innerText = TEXT_CONFIRM;
    confirm.addEventListener(LISTENER_TYPE_CLICK, function () {
        returnSelectData();
        closeLayer();
    })
    return confirm;
}

/**
 * 关闭layer 弹框，如果存在(在弹框内调用)
 */
function closeLayer() {
    let index=parent.layer.getFrameIndex(window.name);
    parent.layer.close(index);
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
            showDataCommon(startIndex, endIndex);
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
 * 上一页
 */
function lastPage() {
    if(curpage>1){
        curpage--;
        setCurPage();
        loadCurPage();
    }else{
        layer.msg(TEXT_NOTCIE_FIRST);
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
        layer.msg(TEXT_NOTCIE_END);
    }
}

/**
 * 设置当前页数
 */
function setCurPage() {
    document.getElementById(ID_SPAN_CUR_PAGE).innerText = String(curpage);
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
        document.getElementById(ID_SPAN_ALL_PAGE).innerText = String(allpage);
    }
}

/**
 * 设置显示的数据内容
 */
function setTableDate(html) {
    document.getElementById(ID_TABLE_BODY).innerHTML = html;
}

/**
 * 设置全选复选框为未选择状态
 */
function setCheckBoxALLFalse() {
    document.getElementById(ID_CHECK_BOX_ALL).checked = false;
}

/**
 * 获取全选复选框当前状态
 * @returns {(function(*): boolean|boolean)|boolean|(function(*): boolean|boolean)|(function(*): boolean|boolean)}
 */
function getCheckBoxALLState() {
    return document.getElementById(ID_CHECK_BOX_ALL).checked
}

/**
 * 全选、非全选更新选择列表
 * @param checked
 */
function upadteChooseDataAll(checked) {
    selecList = [];
    if(checked){
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
        setCheckBoxALLFalse();
        if(index!==-1){
            //存在则删除
            selecList.splice(index, 1);
        }
    }
}

////////////////////////////////////自定义///////////////////////////////////////////////
/**
 * 判断元素是否存在在数组内
 * @param ele
 * @returns {number} 元素索引； -1：不存在
 */
Array.prototype.existInArray = function (ele) {
    let out = -1;
    if(this.length<1){
        return out;
    }

    this.forEach(function (value, index) {
        if(value===ele){
            out = index;
            return true;
        }
    })

    return out;
}
