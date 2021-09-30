<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/9/13
  Time: 13:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Grid Table</title>
    <%--  grid 相关css js--%>
    <link rel="stylesheet" type="text/css" href="/SpringDemo/static/js/jqgrid/css/ui.jqgrid.css" />
    <link rel="stylesheet" type="text/css" href="/SpringDemo/static/js/jquery-ui-1.12.1.custom/jquery-ui.css" />

    <%--    <script  type="text/javascript" src="/SpringDemo/static/js/jquery3.5.1/jquery-3.5.1.min.js"></script>--%>
    <script type="text/javascript" src="/SpringDemo/static/js/jqgrid/js/jquery-1.11.0.min.js"></script>
    <script type="text/javascript" src="/SpringDemo/static/js/jqgrid/js/i18n/grid.locale-cn.js"></script> <!-- 支持中文：翻页信息-->
    <script type="text/javascript" src="/SpringDemo/static/js/jquery-ui-1.12.1.custom/jquery-ui.js"></script>
    <script type="text/javascript" src="/SpringDemo/static/js/jqgrid/js/jquery.jqGrid.min.js"></script>
    <script type="text/javascript" src="/SpringDemo/static/js/jqgrid/plugins/grid.addons.js"></script> <%--支持搜索--%>
    <script type="text/javascript" src="/SpringDemo/static/js/common/commonjs.js"></script>

    <style>
        .ui-th-column, .ui-jqgrid .ui-jqgrid-htable th.ui-th-column {
            white-space: pre-wrap;
        }
        .ui-jqgrid .ui-jqgrid-htable .ui-th-div {
            /*表头高度自适应*/
            height: auto;
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            var table = $('#grid_table');
            //设置表格属性及数据
            table.jqGrid({
                url: '/SpringDemo/source/page_data', // 获取数据的地址
                page: 1,//初始页 后台参数索引： page
                rowNum: 10, // 每页显示记录数，后台参数索引： rows
                //sidx: index 某列支持排序点击时会发给后台
                rowList: [5, 10, 15], // 用于改变显示行数的下拉列表框的元素数组
                // postData:{
                //    自定义传递参数
                // }
                datatype: 'json', // 从服务器端返回的数据类型，默认xml。可选类型：xml，local，json，jsonnp，script，xmlstring，jsonstring，clientside
                mtype: 'POST', // 提交方式，默认为GET

                height: 'auto', // 高度，表格高度。可为数值、百分比或'auto'
                // width: 900, // 如果设置则按此设置为主，如果没有设置则按colModel中定义的宽度计算
                autowidth: true,//当表格在首次被创建时会根据父元素比例重新调整表格宽度。如果父元素宽度改变，为了使表格宽度能够自动调整则需要实现函数：setGridWidth
                // scroll:true, //默认不可滚动， 为TRUE时翻页栏被禁用
                // shrinkToFit : true,//自适应 按比例初始化列宽度
                multiselect: true,//显示复选框
                altRows:true,// 设置为交替行表格,默认为false
                rownumbers: true,// 显示左侧的序号
                //sortname:'entranceTime', // 排序列的名称，此参数会被传到后台 默认排序
                //sortorder:'asc', // 排序顺序，升序或者降序（ASC或DESC）后台: sord: asc(default)

                jsonReader: {
                    //json 数据解析节点
                    repeatitems: true,
                    root: "data",//数据数组
                    page: "page",//当前页
                    total: "total",//总页数
                    records: "records",//总记录数 只读属性，定义了返回的记录数
                    cell: "cell",
                    id: "id"
                },
                // caption:'标题',
                colNames: ['ID', '名字', '缩略图', '类型', '时长', '大小', '分辨率', '创建日期', 'url', '操作'], // 列显示名称，是一个数组对象
                colModel: [
                    // name 表示列显示的名称；
                    // index 表示传到服务器端用来排序用的列名称；其和后台交互的参数为sidx
                    // width 为列宽度；
                    // align 为对齐方式；
                    // sortable 表示是否可以排序
                    // editable 是否可编辑
                    // search 在搜索模式下，定义此列是否可以作为搜索列
                    // hidden: true 是否要隐藏此列
                    // label 如果colNames为空则用此值来作为列的显示名称，如果都没有设置则使用name 值
                    //formatter; cellvalue(当前值), options, rowObject（当前行对象，通过colname 获取）
                    {name: 'id', index: 'id', sortable: true, width: '5%', align: 'center'},
                    {name: 'name', index: 'name', sortable: true, width: '10%'},
                    {
                        label: '缩略图', name: 'thumb', align: 'center', width: '15%', search: false,
                        formatter:  function (cellvalue, options, rowObject) {
                            return thumbFormatter(cellvalue);
                        }
                    },
                    {name: 'suffix', index: 'suffix', sortable: false, width: '5%', align: 'center'},
                    {
                        name: 'duration', index: 'duration', sortable: false, width: '5%', align: 'center',
                        formatter:  function (cellvalue, options, rowObject) {
                            return formatTime(cellvalue);
                        }
                    },
                    {
                        name: 'size', index: 'size', sortable: true, width: '10%', align: 'center',
                        formatter: function (cellvalue, options, rowObject) {
                            return formatFileSize(cellvalue);
                        }
                    },
                    {name: 'resolve', index: 'resolve', sortable: false, width: '10%', align: 'center'},
                    {name: 'createdate', index: 'createdate', sortable: true, width: '15%'},
                    {name:'url', index: "url", sortable: false, hidden: true, search: false},
                    {
                        label: '操作', name: 'opt', sortable: false, width: '20%', align: 'center', search: false,
                        formatter:  function (cellvalue, options, rowObject) {
                            return optFormatter(cellvalue, options, rowObject);
                        }
                    }
                ],

                //设置翻页导航栏
                pager: $('#grid_page_nav'), // 定义翻页用的导航栏
                emptyrecords: '暂无数据！',
                viewrecords: true, // 是否在翻页导航栏显示记录总数
            });
            table.jqGrid('setLabel', 'rn', '序号'); // 为序号列命名
            // table.jqGrid('filterToolbar', {
            //     autosearch:true,
            // });//添加搜索栏: 基于每列
            table.setGridHeight($(window).height()-80);//设置固定高度 表头表尾固定，数据可滚动

            //setGrid()设置固定宽高
            // table.setGridWidth($(window).width() - 7);
            // table.setGridHeight($(window).height() - 115);

            //自定义搜索栏
            $('#grid_search').jqGrid('filterGrid', '#grid_table', {
                // gridModel: true,//使用colModel中的属性构造查询条件
                // gridNames: true,//设置查询列的名称
                filterModel: [{
                    label: '搜索',
                    name: 'search',//过滤列名
                    stype: 'text',//输入框类型 /select
                    defval: '',
                    // sopt:{optins for the select},
                }],
                autosearch:true,//当点击回车键触发查询；当select值变化时触发查询
            })
        });

        // $(window).resize(function(){
        //     $(window).unbind("onresize");
        //     $('#grid_table').setGridHeight($(window).height() - 90);//
        //     $(window).bind("onresize", this);
        // });

        function thumbFormatter(cellvalue) {
            return  "<img src=\""+ cellvalue + "\" alt='暂无' width='80' height='45'/>";
        }

        function optFormatter(cellvalue, options, rowObject) {
            const rowid = options.rowId;
            const url = rowObject['url'];
            let content = "";
            content += "<a href=\"" + url + "\" class=\"btn btn-xs btn-info\" target='_blank'>预览</a>&nbsp;";
            content += "<a href=\"#\" class=\"btn btn-xs btn-info\" onclick=\"deleteCell('" + rowid +"')\">" +
                "<i class=\"empty\"></i>删除</a>";
            return content;
        }
    </script>
</head>
<body>
    <div class="grid_view">
        <!--自定义搜索栏-->
        <div id="grid_search" class="grid_search"></div>
        <!-- jqGrid 表格 -->
        <table id="grid_table"></table>
        <!-- 翻页导航栏: 不必给翻页设置任何的css属性-->
        <div id="grid_page_nav" class="pager"></div>
    </div>
</body>
</html>
