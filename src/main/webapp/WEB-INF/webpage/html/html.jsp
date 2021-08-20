<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/8/5
  Time: 8:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<!--html：HyperText Markup Language文件申明（不区分大小写）-->
<!--
1. HTML 文档由相互嵌套的 HTML 元素构成;
2. 关闭标签是可选的; 在 XHTML、XML 以及未来版本的 HTML 中，所有元素都必须被关闭;
3. HTML 标签对大小写不敏感, 而在未来 (X)HTML 版本中强制使用小写;
4. 对于 HTML，无法通过在 HTML 代码中添加额外的空格或换行来改变输出的效果; （当显示页面时，浏览器会移除源代码中多余的空格和空行。所有连续的空格或空行都会被算作一个空格）
5. 空标签，只包含属性，并且没有闭合标签；
-->
<html>
<!--<html manifest="demo.appcache"> 
启用应用程序缓存: manifest 的页面在用户对其访问时都会被缓存
一旦文件被缓存，则浏览器会继续展示已缓存的版本，即使您修改了服务器上的文件-->
<head> <!-- 开始标签常被称为起始标签（opening tag）-->
    <!--title：标题标签（必须的）可以在左侧显示logo等图片-->
    <title>
        HTML5 知识点
    </title>

    <!-- rel：relationship 当前页面与href所指定文档的关系; 通常出现在a,link标签中
        alternate -- 定义交替出现的链接
        appendix -- 定义文档的附加信息
        bookmark -- 书签
        chapter -- 当前文档的章节
        contents
        copyright -- 当前文档的版权
        glossary -- 词汇
        help -- 链接帮助信息
        index -- 当前文档的索引
        next -- 记录文档的下一页.(浏览器可以提前加载此页)
        nofollow -- 不被用于计算PageRank
        prev -- 记录文档的上一页.(定义浏览器的后退键)
        section -- 作为文档的一部分
        start -- 通知搜索引擎,文档的开始
        stylesheet -- 定义一个外部加载的样式表
        subsection -- 作为文档的一小部分
        me--告诉搜索引擎，这是自己的内容
        home--告诉搜索引擎，这是返回首页
        license--描述版权
        friend--这是朋友的
        tag--标签
        same--相同的链接
    -->
    <link rel="icon" href="/SpringDemo/static/res/icon/icon_logo2.ico"/>

    <!--属性：（如 href）
        1. 一般描述于开始标签;
        2. 总是以名称/值对的形式出现，比如：name="value";
        3. 属性值应该始终被包括在引号【双引号、单引号】内; （在某些情况下，如属性值本身就含有双引号，则必须使用单引号）
        4. 属性和属性值对大小写不敏感，而新版本的 (X)HTML 要求使用小写属性；
        5. id 属性只能单独设置 id=" "（只能填写一个，多个无效）；
    -->

    <!-- meta: 
    描述HTML文档的描述，关键词，作者，字符集等；
    不显示在页面上；
    每30秒钟刷新当前页面: http-equiv="refresh" content="30"
    -->
    <meta charset="utf-8" name="author" content="Virgo"/><!--中文网页需要声明编码（utf-8、GBK），否则会出现乱码-->

    <!-- base: 定义页面中所有链接默认的链接目标地址 target="_blank"-->
    <!--<base href="F:\ZSLWORK\documents\html\">-->
    <!--		<base href="F:\ZSLWORK\documents\html\"/>-->

    <!-- link: 定义文档与外部资源之间的关系, 通常用于链接到样式表（css）可链接多个css文件-->
    <link rel="stylesheet" type="text/css" href="/SpringDemo/static/css/htmlpage.css"/>

    <!-- style: 定义HTML文档的样式文件引用地址-->
    <!--<style type="text/css">
        body {background-color:geeen}
        p {color:blue}
    </style> -->

    <!-- script：加载脚本文件 js-->
    <script type="text/javascript" src="/SpringDemo/static/js/htmlpage.js"></script>

    <!--不支持 JavaScript 的浏览器会使用 <noscript> 元素中定义的内容（文本）来替代-->
    <noscript>抱歉，你的浏览器不支持 JavaScript!</noscript>

</head> <!-- 结束标签常称为闭合标签（closing tag）-->

<!--可见页面内容-->
<body>
<div class="div_header">
<%--    onclick="window.open('')"--%>
    <h1>VIRGO.NOTE</h1>
</div>

<div class="div_nav">
    <ul class="ul_nav">
        <li><a href="/SpringDemo/home">首页</a></li>
        <li><a href="/SpringDemo/html" class="nav_selected">Html</a></li>
        <li><a href="/SpringDemo/source">Source</a></li>
        <li><a href="/SpringDemo/mine">Mine</a></li>

        <!--				<li><a href="./html_home.html">首页</a></li>-->
        <!--				<li><a href="" class="nav_selected">HTML</a></li>-->
        <!--				<li><a href="./html_css.html">CSS</a></li>-->
        <!--				<li><a href="./html_js.html">JS</a></li>-->
    </ul>
</div>

<div id="main" class="div_main">
    <!-- 路径引用：F:\ZSLWORK\documents\html\
    ../ : file:///F:/ZSLWORK/documents/
    ./  : file:///F:/ZSLWORK/documents/html/
    / 	: file:///F:/
    <a href="#end" style="float:right"><img src="./res/icon_end.png" width="32" height="32"></a>
    -->
    <a href="#main" class="div_end_icon"><img src="/SpringDemo/static/res/icon/icon_end.png" width="32" height="32"/></a>

    <div class="div_menu">
        <ul class="ul_menu">
            <li class="li_menu menu_dropdown">
                <a href="#c_text" title="文本">文本 text</a>
                <!--下拉菜单-->
                <div class="menu_drop_cont">
                    <a href="#c_text_h" title="标题">标题 h</a>
                    <a href="#c_text_p" title="段落">段落 p</a>
                    <a href="#c_text_format" title="文本格式化">文本格式化</a>
                </div>
            </li>
            <li class="li_menu">
                <a href="#c_a" title="链接">链接 a</a>
            </li>
            <li class="li_menu">
                <a href="#c_image" title="图片">图片 image</a>
            </li>
            <li class="li_menu">
                <a href="#c_table" title="表格">表格 table</a>
            </li>
            <li class="li_menu">
                <a href="#c_list" title="列表">列表 list</a>
            </li>
            <li class="li_menu">
                <a href="#c_block" title="区块">区块 block</a>
            </li>
            <li class="li_menu">
                <a href="#c_form" title="表单">表单 form</a>
            </li>
            <li class="li_menu">
                <a href="#c_frame" title="框架">框架 frame</a>
            </li>
            <li class="li_menu">
                <a href="#c_entity" title="字符实体">字符实体 entity</a>
            </li>
            <li class="li_menu">
                <a href="#c_canvas" title="画布">画布 canvas</a>
            </li>
            <li class="li_menu">
                <a href="#c_math" title="数学符号">数学符号 mathml</a>
            </li>
            <li class="li_menu">
                <a href="#c_drag_drop" title="拖放">拖放 drag drop</a>
            </li>
            <li class="li_menu">
                <a href="#c_location" title="定位">定位 location</a>
            </li>
            <li class="li_menu">
                <a href="#c_video" title="视频">视频 video</a>
            </li>
            <li class="li_menu">
                <a href="#c_audio" title="音频">音频 audio</a>
            </li>
            <li class="li_menu">
                <a href="#c_sql" title="数据库">数据库 sql</a>
            </li>
            <li class="li_menu">
                <a href="#c_worker" title="服务">服务 worker</a>
            </li>
        </ul>
    </div>

    <div class="div_content">
        <div id="c_text" class="div_c_text">
            <h2 class="div_title">文本</h2>
            <hr/>

            <!--1. 文本 -->
            <!--1.1 标题: h1-h6
                1. <h1> 定义最大的标题, <h6> 定义最小的标题;
                2. 浏览器会自动地在标题的前后添加空行;
                3. 请确保将 HTML 标题 标签只用于标题; 不要仅仅是为了生成粗体或大号的文本而使用标题;
                4. 应该将 h1 用作主标题（最重要的），其后是 h2（次重要的），再其次是 h3，以此类推;
                5. 1到6号标题与1到6号字体逆序对应;
            -->
            <div id="c_text_h">
                <h1>标题h1</h1>
                <h2>标题h2</h2>
                <h3>标题h3</h3>
                <h4>标题h4</h4>
                <h5>标题h5</h5>
                <h6>标题h6</h6>
            </div>

            <hr/>
            <!--1.2 段落: p （将文档分割为若干段落）
                1. 浏览器会自动地在段落的前后添加空行；
                2. 浏览器在显示 HTML 时，会省略源代码中多余的空白字符（空格或回车等）;
                3. 段落的行数依赖于浏览器窗口的大小; 如果调节浏览器窗口的大小，将改变段落中的行数;
            -->
            <div id="c_text_p">
                <p>十步杀一人，千里不留行</p>
                <p>酒入豪肠<br/>七分酿成了月光<br/>余下三分<br/>啸成了剑气<br/>秀口一吐<br/>便是是半个盛唐</p>

                <h3>春晓</h3>
                <!--浏览器忽略了源代码中的排版（省略了多余的空格和换行）-->
                <p>
                    春眠不觉晓，
                    处处闻啼鸟。
                    夜来风雨声，
                    花落知多少。
                </p>

                <p class="c_text_p_column">
                    黄初三年，余朝京师，还济洛川。
                    古人有言，斯水之神，名曰宓妃。
                    感宋玉对楚王神女之事，遂作斯赋。
                    其辞曰：余从京域，言归东藩。
                    背伊阙，越轘辕，经通谷，陵景山。
                    日既西倾，车殆马烦。
                    尔乃税驾乎蘅皋，秣驷乎芝田，容与乎阳林，流眄乎洛川。
                    于是精移神骇，忽焉思散。
                    俯则末察，仰以殊观，睹一丽人，于岩之畔。
                    乃援御者而告之曰：“尔有觌于彼者乎？彼何人斯？若此之艳也！”
                    御者对曰：“臣闻河洛之神，名曰宓妃。然则君王所见，无乃日 乎？其状若何？臣愿闻之。”
                </p>
            </div>


            <!--1.3 水平线: hr （用于分隔内容）-->
            <hr/>  <!--空元素在开始标签中进行关闭（以开始标签的结束而结束）-->

            <!--1.4 换行: br -->
            <br/> <!--一个空的 HTML 元素, 由于关闭标签没有任何意义，因此它没有结束标签-->


            <!--1.5 文本格式化: 加粗、斜体、放大、缩小、上标、下标
                1. <b> 与<i> 定义粗体或斜体文本；
                2. <strong> 或者 <em>意味着你要呈现的文本是重要的，<strong> 替换加粗标签 <b> 来使用, <em> 替换 <i>标签使用
            -->
            <div id="c_text_format">
                <b>加粗</b> <strong>加重</strong>
                <br/>
                <i>斜体</i> <em>着重</em>
                <br/>
                <big>放大</big>
                <small>缩小</small>
                <br/>
                <sup>上标</sup>
                <sub>下标</sub>
                <br/>
                <ins>插入</ins> <del>删除</del> <u>下划线</u>

                <br/>
                <hr/>

                <code>计算机代码
                    int a=1;
                    int b=2;
                    println(a+b);
                </code><br/>

                <dfn>定义项目
                    int a=1;
                    int b=2;
                    println(a+b);
                </dfn><br/>

                <kbd>键盘码
                    int a=1;
                    int b=2;
                    println(a+b);
                </kbd><br/>

                <samp>代码样本
                    int a=1;
                    int b=2;
                    println(a+b);
                </samp><br/>

                <var>变量
                    int a=1;
                    int b=2;
                    println(a+b);
                </var><br/>

                <!--保留格式-->
                <pre>预格式文本
						int a=1;
						int b=2;
						println(a+b);
						</pre>

                <!-- abbr 缩写 title:原文-->
                <abbr title="World Health Organization">WHO</abbr>

                <!-- bdo （Bi-Directional Override） 文字方向 dir:方向[ltr、rtl]-->
                <bdo dir="rtl">该段落文字从右到左显示。</bdo>

                <!-- blockquote 长的引用： cite: 规定引用的来源
                    定义一个摘自另一个源的块引用
                    浏览器通常会对 <blockquote> 元素进行缩进。
                -->
                <blockquote cite="http://www.worldwildlife.org/who/index.html">
                    WWF works in 100 countries and is supported by 1.2 million members in the United States and close to 5 million globally.
                </blockquote>

                <!-- q 短引用： 插入引号  cite: 规定引用的来源 -->
                <q>Build a future where people live in harmony with nature.</q>

                <!-- cite: 定义作品的标题, 以斜体显示-->
                <cite><a href="https://fanyi.youdao.com/" target="_blank">翻译一下</a></cite>
            </div>
        </div>

        <div id="c_a" class="div_c_a">
            <h2 class="div_title">链接</h2>
            <hr/>
            <!--2 a: 链接；
            href：链接地址，后面为 "链接文本"
            target：定义被链接的文档在何处显示; ["_blank"：新窗口；"_top"：顶部]
                1. 超链接可以是一个字，一个词，或者一组词，也可以是一幅图像，您可以点击这些内容来跳转到新的文档或者当前文档中的某个部分。
                2. 图片或其他 HTML 元素都可以成为链接;
                3. herf = "#tagId" （关联其他标签）
                4. 请始终将正斜杠添加到子文件夹（后面斜杠）
                5. 单词之间的空格使用 %20 代替，以确保浏览器可以正常显示文本
            -->

            <a href="https://www.csdn.net/" target="_blank"><cite>csdn </cite>点我跳转</a>
            <a href="/SpringDemo/html" target="_top">我自己</a>
            <a href="#main">跳到开头</a>

            <!--url: 统一资源定位器(Uniform Resource Locators)
            scheme://host.domain:port/path/filename
                scheme：特网服务的类型(http、https、ftp、file...）
                host：  域主机（默认www）
                domin： 因特网域名（xxx.com、xxx.cn）
                :port： 端口号（http 的默认端口号是 80）
                path：  服务器上的路径（如果省略，则文档必须位于网站的根目录中）
                filename： 文档/资源的名称
            ps:
                1. URL 不能包含空格;
                2. 只能使用 ASCII 字符集;
                3. 
            -->
        </div>

        <div id="c_image" class="div_c_image">
            <h2 class="div_title">图片</h2>
            <hr/>
            <!--3. img: 图片; 
                1. <img> 是空标签，意思是说，它只包含属性，并且没有闭合标签;
                2. 浏览器将图像显示在文档中图像标签出现的地方;
                3. 为页面上的图像都加上替换文本属性是个好习惯;
                4. 指定图像的高度和宽度是一个很好的习惯;
                5. 加载图片是需要时间的，所以：慎用图片;
                
                loading="lazy", 
                border="1", 边框
                src="xxxx", 图片源
                alt="txt", 为图像定义一串预备的可替换的文本（图片无法正常显示时显示xxx）
                width、height: 属性值默认单位为像素
                align="middle" 对齐方式（默认底部对齐）[bottom, middle, top] 在HTML 4中 align 属性已废弃，HTML5 已不支持该属性，可以使用 CSS 代替。
                usemap="#mapid" 图像映射
            -->
            <img class="c_image_1" src="/SpringDemo/static/res/img/img1.jpg" width="192" height="108" alt="美女哦" usemap="#map"/>

            <!--3.1 map：图像映射； 带有可点击区域的图像映射：
                1. <img> 中的 usemap 属性可引用 <map> 中的 id 或 name 属性（取决于浏览器）;
                2. 在 HTML5 中, 如果 id 属性在<map> 标签中指定, 则你必须同样指定 name 属性;
                3. area 元素永远嵌套在 map 元素内部, 可定义图像映射中的区域;
            -->
            <map id="map" name="map">
                <!-- shape：形状 
                    1. rect: 矩形 左上角顶点坐标为(x1,y1)，右下角顶点坐标为(x2,y2)；
                    2. circle: 圆形 (圆心坐标为(X1,y1)，半径为r)；
                    3. poly: 多边形 (各顶点坐标依次为(x1,y1)、(x2,y2)、(x3,y3) ......)；
                -->
                <area shape="rect" coords="0,0,82,126" href="" alt="1">
                <area shape="circle" coords="90,58,3" href="" alt="2">
                <area shape="circle" coords="124,58,8" href="" alt="3">
            </map>

            <img id="image_2" class="c_image_2" src="/SpringDemo/static/res/img/img2.jpg" width="192" height="108" alt="混沌圣炎" onclick="showImgDialog()"/>
            <!-- The Modal -->
            <div id="img_dialog" class="c_img_dialog">
                <span id="dialog_close" class="c_dialog_close" onclick="closeImgDialog()">×</span>
                <img id="dialog_content" class="c_dialog_content"/>
                <div id="dialog_caption"></div>
            </div>
        </div>

        <div id="c_table" class="div_c_table">
            <h2 class="div_title">表格</h2>
            <hr/>
            <!--5. table: 表格
            border="1" 边框，默认不显示
            cellpadding="10" 单元格边距（内部内容）
            cellspacing="10" 单元格间距（与其他单元格）
                <caption>：标题
                <colgroup>：列组（按列控制每列样式）
                    <col> 某一列
                <tr>：行 table row
                <th>：表头 table head: 显示为粗体居中的文本
                    colspan="2"：跨列； rowspan="2" 跨行
                <td>：单元格 table data：包含文本、图片、列表、段落、表单、水平线、表格等
            -->
            <table border="1">
                <caption>简单表格</caption>
                <a href="/SpringDemo/html/table" target="_blank" style="float:right">牛逼的表格</a>
                <tr>
                    <th>id</th>
                    <th>name</th>
                    <th>sex</th>
                </tr>
                <tr>
                    <td>1</td>
                    <td>小明</td>
                    <td style="text-align:center">男</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>小红</td>
                    <td style="text-align:center">女</td>
                </tr>
            </table>
        </div>

        <div id="c_list" class="div_c_list">
            <h2 class="div_title">列表</h2>
            <hr/>
            <!--6. list: 列表 有序、无序和定义列表（有无序号）
                <ol>：order list 有序列表: 列表项目使用数字进行标记；
                    start="1" 起始序号（默认为1）；
                    type="A" 序列类型[A, a, I, i]（默认为数字）
                <ul>：unorder list 无序列表: 项目使用粗体圆点（典型的小黑圆圈）进行标记；
                    style="list-style-type:square" 标记类型[disc 圆点，circle 圆形，square 正方形]（默认圆点）
                    
                    <li>：list item 列表项；
                
                <dl>：definition list 自定义列表不仅仅是一列项目，而是项目及其注释的组合；
                    <dt>：definition term 自定义列表项；
                    <dd>：definition description 自定义列表项的定义；
                
                ps: 列表项内部可以使用段落、换行符、图片、链接以及其他列表等等
            -->
            <ol start="10" type="I">
                <li>book1</li>
                <li>book2</li>
                <li>book3</li>
            </ol>

            <ul>
                <li>book1</li>
                <li>book2
                    <!--嵌套列表-->
                    <ul>
                        <li>CHAPTER1</li>
                        <li>CHAPTER2</li>
                    </ul>
                </li>
                <li>book3</li>
            </ul>

            <dl>
                <dt>Coffee</dt>
                <dd>- black hot drink</dd>
                <dt>Milk</dt>
                <dd>- white cold drink</dd>
            </dl>
        </div>

        <div id="c_block" class="div_c_block">
            <h2 class="div_title">区块</h2>
            <hr/>
            <!--7. div & span 区块
                1. 块级元素：块级元素在浏览器显示时，通常会以新行来开始（和结束）；
                    <h1>, <p>, <ul>, <table>
                2. 内联元素：内联元素在显示时通常不会以新行开始；
                    <b>, <td>, <a>, <img>
                
                <div> ：形成一个大块
                    1. 块级元素，可用于组合其他 HTML 元素的容器;
                    2. 与 CSS 一同使用，<div> 元素可用于对大的内容块设置样式属性;
                    3. 另一个常见的用途是文档布局;
                    
                <span> ；切割、更细化
                    1. 内联元素，可用作文本的容器；
                    2. 当与 CSS 一同使用时，<span> 元素可用于为部分文本设置样式属性；
                -->

            <ins>div</ins> 定义了文档的区域，块级 (<span style="color:red">block-level</span>)<br/>
            <ins>span</ins> 用来组合文档中的行内元素，内联元素(<span style="color:green">inline</span>)
        </div>

        <div id="c_form" class="div_c_form">
            <h2 class="div_title">表单</h2>
            <hr/>
            <!--8. form 表单 (一个包含表单元素的区域)
                1. 表单本身并不可见;
            
            <input>； 输入标签
                type：输入类型
                    1. text: 文本;
                    1.1 image: 图片；
                    1.2 file: 文件；
                    
                    2. password: 密码;
                    3. radio: 单选按钮； （所属项name一样）
                    4. checkbox：复选框；（所属项name一样）
                        value；选项对应的值；
                        checked="checked"：预选;
                    5. select：下拉列表；
                        <option>：列表项；（selected 预选， 默认为第一个)
                    6. button；按钮；
                        value：显示内容；
                    7. submit：提交；
                        value：显示内容；
                    8. reset: 重置；（回到初始状态）
                    
                    //html 5
                    1. color //选取颜色
                    
                    2. date //选择一个日期
                    3. datetime //google 不支持
                    4. datetime-local //选择一个日期和时间 (无时区).、
                    5. time //选择一个时间(hh:mm)（无时区）
                    6. month //仅选择月份
                    7. week //选择周和年
                    
                    8. number //仅数字(设定对所接受的数字的限定 min="1" max="5")
                        disabled	规定输入字段是禁用的
                        max			规定允许的最大值
                        maxlength	规定输入字段的最大字符长度
                        min			规定允许的最小值
                        pattern		规定用于验证输入字段的模式
                        readonly	规定输入字段的值无法修改
                        required	规定输入字段的值是必需的
                        size		规定输入字段中的可见字符数
                        step		规定输入字段的合法数字间隔
                        value		规定输入字段的默认值
                    9. range //显示为滑动条(min="1" max="10" step - 规定合法的数字间隔 value - 规定默认值)
                        
                    10. email //自动验证 email 域的值是否合法有效:
                    11. tel //输入电话号码字段: google 不支持
                    12. url //会自动验证 url 域的值
                    13. search
                    
            <textarea>：文本域
                rows：行数；
                cols：列数；
                
            <keygen>：用于表单的密钥对生成器字段；
            <output>：用于不同类型的输出，比如计算或脚本输出：
            
            
            ---表单/输入框属性----
            1. autocomplete="on/off"（用于输入框，g根据标签名记忆，会记忆之前输入过的信息）
            2. novalidate（无校验）,autofocus（获取焦点）,multiple（多个值）,required（必填）（boolean 属性，添加为true,否则false）
            3. list 规定输入域的 datalist(输入域的选项列表)
            4. pattern 描述了一个正则表达式用于验证 <input> 元素的值
            5. placeholder 提供一种提示（hint）描述输入域所期待的值
            6. step 输入域规定合法的数字间隔(可以与 max 和 min 属性创建一个区域值)
            -->

            <form action="" autocomplete="on">
                <!-- <fieldset> 定义了一组相关的表单元素，并使用外框包含起来-->
                <fieldset>
                    <!-- <legend> 定义了 <fieldset> 元素的标题-->
                    <legend>Info Register:</legend>
                    Name:<br/><input type="text" size="20" name="name" placeholder="username"><br/>
                    Password:<br/><input type="password" size="20" name="password" placeholder="password"><br/>
                    E-mail:<br/><input type="email" size="20" name="email"><br/><br/>
                    <input type="submit" value="register" >
                </fieldset>
            </form>

            <br/>
            <form oninput="form_output_1.value=parseInt(a.value)+parseInt(b.value)">0
                <input type="range" id="a" value="50">100
                +<input type="number" id="b" value="50">
                =<output name="form_output_1" for="a b"></output>
            </form>

            <br/>
            <div class="div_form_button">
                <h3>英雄召唤</h3>
                <form action="">
                    <!--单选框-->
                    <input type="radio" name="gender" value="male"/> 公的<br/>
                    <input type="radio" name="gender" value="female" checked="checked"/> 母的<br/>

                    <br/>
                    <!--复选框-->
                    <input type="checkbox" name="attr" value="leg"/>大长腿<br/>
                    <input type="checkbox" name="attr" value="face" checked="checked"/>瓜子脸<br/>
                    <input type="checkbox" name="attr" value="breast"/>丰乳房<br/>
                    <input type="checkbox" name="attr" value="fair"/>长头发<br/>

                    <br/>
                    <!--下拉框-->
                    <!--可自输入，提供参考-->
                    名字
                    <input type="text" list="form_data_list"/><br/>
                    <datalist id="form_data_list">
                        <option value="貂蝉"></option>
                        <option value="吕布"></option>
                        <option value="赵云"></option>
                        <option value="阿离"></option>
                    </datalist>

                    <!--只能从选项里选择-->
                    服装
                    <select>
                        <option value="1">广袖流仙裙</option>
                        <option value="2">烈火战甲</option>
                        <option value="3">嗜血魔铠</option>
                        <option value="4">三重荣耀圣装</option>
                    </select>

                    <br/>
                    <br/>
                    <input type="button" value="召唤"/>
                    <input type="reset" value="重置"/>
                </form>
            </div>
        </div>

        <div id="c_frame" class="div_c_frame">
            <h2 class="div_title">框架</h2>
            <hr/>

            <!-- iframe：框架: 在同一个浏览器窗口中显示不止一个页面
                src="xxx"：该URL指向不同的网页；
                frameborder="0"：定义iframe表示是否显示边框
                loading="lazy"：加载模式（lazy：延时加载）
                
                ps；有些网页不希望被嵌套, 响应头中有一选项
                X-Frame-Options:
                DENY：表示该网站页面不允许被嵌套，即便是在自己的域名的页面中也不能进行嵌套。
                SAMEORIGIN：表示该页面可以在相同域名页面中被嵌套展示。
                ALLOW-FROM uri：表示该页面可以在指定来源页面中进行嵌套展示。
            -->

            <nav>
                <a href="http://www.baidu.com/" target="iframe_1"><span>百度</span></a> |
                <a href="https://www.runoob.com/" target="iframe_1"><span>菜鸟</span></a> |
                <a href="https://huaban.com/" target="iframe_1"><span>花瓣</span></a> |
            </nav>

            <div>
                <!--width: 相对于div-->
                <iframe src="/SpringDemo/html/table" name="iframe_1" frameborder="0" width="100%" height="300px"></iframe>
            </div>
        </div>

        <div id="c_entity" class="div_c_entity">
            <h2 class="div_title">字符实体</h2>
            <hr/>

            <table class="entity_table font_center">
                <tr class="table_head">
                    <th style="width:20%">显示结果</th>
                    <th style="width:20%">描述</th>
                    <th style="width:30%">实体名称</th>
                    <th style="width:30%">实体编号</th>
                </tr>

                <tr class="table_row_odd">
                    <td>&nbsp;</td>
                    <td>空格</td>
                    <td>&amp;nbsp;</td>
                    <td>&amp;#160;</td>
                </tr>

                <tr class="table_row_even">
                    <td>&lt;</td>
                    <td>小于号</td>
                    <td>&amp;lt;</td>
                    <td>&amp;#60;</td>
                </tr>

                <tr class="table_row_odd">
                    <td>&gt;</td>
                    <td>大于号</td>
                    <td>&amp;gt;</td>
                    <td>&amp;#62;</td>
                </tr>

                <tr class="table_row_even">
                    <td>&amp;</td>
                    <td>和号</td>
                    <td>&amp;amp;</td>
                    <td>&amp;#38;</td>
                </tr>

                <tr class="table_row_odd">
                    <td>"</td>
                    <td>引号</td>
                    <td>&amp;quot;</td>
                    <td>&amp;#34;</td>
                </tr>

                <tr class="table_row_even">
                    <td>'</td>
                    <td>撇号&nbsp;</td>
                    <td>&amp;apos; (IE不支持)</td>
                    <td>&amp;#39;</td>
                </tr>

                <tr class="table_row_odd">
                    <td>￠</td>
                    <td>分</td>
                    <td>&amp;cent;</td>
                    <td>&amp;#162;</td>
                </tr>

                <tr class="table_row_even">
                    <td>£</td>
                    <td>镑</td>
                    <td>&amp;pound;</td>
                    <td>&amp;#163;</td>
                </tr>

                <tr class="table_row_odd">
                    <td>¥</td>
                    <td>人民币/日元</td>
                    <td>&amp;yen;</td>
                    <td>&amp;#165;</td>
                </tr>

                <tr class="table_row_even">
                    <td>€</td>
                    <td>欧元</td>
                    <td>&amp;euro;</td>
                    <td>&amp;#8364;</td>
                </tr>

                <tr class="table_row_odd">
                    <td>§</td>
                    <td>小节</td>
                    <td>&amp;sect;</td>
                    <td>&amp;#167;</td>
                </tr>

                <tr class="table_row_even">
                    <td>©</td>
                    <td>版权</td>
                    <td>&amp;copy;</td>
                    <td>&amp;#169;</td>
                </tr>

                <tr class="table_row_odd">
                    <td>®</td>
                    <td>注册商标</td>
                    <td>&amp;reg;</td>
                    <td>&amp;#174;</td>
                </tr>

                <tr class="table_row_even">
                    <td>™</td>
                    <td>商标</td>
                    <td>&amp;trade;</td>
                    <td>&amp;#8482;</td>
                </tr>

                <tr class="table_row_odd">
                    <td>×</td>
                    <td>乘号</td>
                    <td>&amp;times;</td>
                    <td>&amp;#215;</td>
                </tr>

                <tr class="table_row_even">
                    <td>÷</td>
                    <td>除号</td>
                    <td>&amp;divide;</td>
                    <td>&amp;#247;</td>
                </tr>
            </table>
        </div>

        <h1>html 5</h1>
        <div id="c_canvas" class="div_c_canvas">
            <h2 class="div_title">画布</h2>
            <hr/>

            <!-- canvas: 画布：（通过 JavaScript 来绘制 2D 图形）
                1. 只是图形容器，必须使用脚本来绘制图形;
                2. 默认情况下 <canvas> 元素没有边框和内容;
            -->
            <canvas id="canvas_1" class="div_c_canvas_1" width="300px" height="300px"></canvas>

            <!-- SVG: Scalable Vector Graphics （一种使用 XML 描述 2D 图形的语言）
            version：定义所使用的 SVG 版本；
            xmlns：定义 SVG 命名空间；
                1. SVG 图像可通过文本编辑器来创建和修改;
                2. SVG 图像可被搜索、索引、脚本化或压缩;
                3. SVG 是可伸缩的;
                4. SVG 图像可在任何的分辨率下被高质量地打印;
                5. SVG 可在图像质量不下降的情况下被放大;
            -->

            <svg xmlns="" version="1.0" height="200px" class="div_c_svg">
                <!--矩形 (width, height) 
                    rx,ry: 可使矩形产生圆角，默认为(0, 0)
                -->
                <rect width="300" height="200" rx="10" ry="10" class="c_svg_rect" filter="url(#f1)"/>

                <!--圆形 （cx, cy, r) 
                    cx,cy: 圆点的x和y坐标，默认为(0, 0)
                    r: 圆的半径；
                -->

                <circle cx="0" cy="20" r="20" class="c_svg_circle">
                    <!--起点为图形原起点-->
                    <animateMotion path="M 0 20 L 60 20 L 60 60 L 100 60 L 100 100 L 140 100 L 140 140 Z" dur="5s" fill="freeze" repeatCount="indefinite"/>
                </circle>

                <!--椭圆 (cx, cy, rx, ry)
                    rx: 水平半径
                    ry: 垂直半径-->
                <ellipse cx="200" cy="25" rx="50" ry="20" class="c_svg_ellipse"/>

                <!--线 (x1, y1, x2, y2)-->
                <line x1="0" y1="0" x2="200" y2="200" class="c_svg_line"/>

                <!--多边形 points-->
                <polygon points="100,10 40,180 190,60 10,60 160,180" class="c_svg_polygon">
                    <animate attributeType="CSS" attributeName="opacity" from="1" to="0.4" dur="1s" repeatCount="indefinite"/>
                </polygon>

                <!--折线 points 创建任何只有直线的形状-->
                <polyline points="0,40 40,40 40,80 80,80 80,120 120,120 120,160" class="c_svg_polyline"/>

                <!--路径
                    M = moveto 起点
                    L = lineto 直线到
                    H = horizontal lineto 水平直线
                    V = vertical lineto	  竖直直线
                    C = curveto 
                    S = smooth curveto
                    Q = quadratic Bézier curve 二次方贝塞尔曲线 （起点，控制点，终点）
                    T = smooth quadratic Bézier curveto
                    A = elliptical Arc
                    Z = closepath 闭合
                    
                    ps: 大写表示绝对定位，小写表示相对定位;
                -->
                <path d="M 0 100 L 100 10" stroke="red" stroke-width="3" fill="none" />
                <path d="M 200 100 L 100 10" stroke="red" stroke-width="3" fill="none" />
                <path id="path_q" d="M 0 100 Q 100 10 200 100" stroke="blue" stroke-width="5" fill="none" />

                <!--文本（x,y）文字左上点-->
                <!--链接文本 xlink:-->
                <a href="https://www.runoob.com/svg/svg-tutorial.html" target="_blank">
                    <text x="165" y="30" class="c_svg_text">I am SVG</text>
                </a>

                <text x="10" y="100" fill="url(#lg1)">
                    <textPath xlink:href="#path_q">神鬼莫测 难知如阴 战无不胜</textPath>
                </text>

                <!--效果-->
                <defs><!--定义短并含有特殊元素（如滤镜）定义-->
                    <!--滤镜: filter="url(#f1)" 调用方法-->
                    <filter id="f1" x="0" y="0">
                        <feGaussianBlur in="SourceGraphic" stdDeviation="5" />
                    </filter>

                    <!--渐变： <linearGradient> <radialGradient> 
                        fill="url(#lg1)"
                        两点控制渐变方向-->
                    <linearGradient id="lg1" x1="0%" y1="0%" x2="100%" y2="0%">
                        <stop offset="0%" style="stop-color:rgb(255,0,0);stop-opacity:1" />
                        <stop offset="100%" style="stop-color:rgb(0,0,255);stop-opacity:1" />
                    </linearGradient>

                    <!--CX，CY和r属性定义的最外层圆和
                    Fx和Fy定义的最内层圆
                    offset属性用来定义渐变色开始和结束-->
                    <radialGradient id="rg1" cx="50%" cy="50%" r="50%" fx="50%" fy="50%">
                        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:0" />
                        <stop offset="100%" style="stop-color:rgb(0,0,255);stop-opacity:1" />
                    </radialGradient>
                </defs>

                <!--动画: 用于某一标签内部
                <animate attributeType="CSS" attributeName="opacity" from="1" to="0" dur="5s" repeatCount="indefinite"/>
                <animateColor attributeType="CSS" attributeName="fill" from="lime" to="red" begin="2s" dur="4s" fill="freeze" />
                <animateMotion path="M 0 0 L 100 100" dur="5s" fill="freeze" />
                <animateTransform attributeType="XML" attributeName="transform"  type="rotate" from="-30" to="0" begin="1s" dur="5s" fill="freeze" /> 
                
                attributeName：动画类型（opacity：透明度；x、y：横纵坐标; fill：填充颜色; transform: 旋转、平移、缩放）
                dur：时间（ns）
                from：起始值
                to：结束值
                repeatCount：重复次数（n, indefinite）
                
                --color--
                by：相对偏移值
                
                --motion--
                calcMode="动画的插补模式。可以是'discrete', 'linear', 'paced', 'spline'"
                path="运动路径"
                keyPoints="沿运动路径的对象目前时间应移动多远"
                rotate="应用旋转变换"
                xlink:href="一个URI引用<path>元素，它定义运动路径"
                
                --transform--
                by="相对偏移值"
                from="起始值"
                to="结束值"
                type="类型的转换其值是随时间变化。可以是 'translate', 'scale', 'rotate', 'skewX', 'skewY'"
                -->
            </svg>

            <!--SVG 文件嵌入 HTML 文档:
                1. <embed src="circle1.svg" type="image/svg+xml" /> 允许使用脚本
                2. <object data="circle1.svg" type="image/svg+xml"></object> 不允许使用脚本
                3. <iframe src="circle1.svg"></iframe> 允许使用脚本
            -->

            <br/>
            <button type="button" onclick="draw()">draw</button>

            <!-- Canvas 与 SVG 的比较
                1. SVG 中，每个被绘制的图形均被视为对象。如果 SVG 对象的属性发生变化，那么浏览器能够自动重现图形;
                2. Canvas 是逐像素进行渲染的。在 canvas 中，一旦图形被绘制完成，它就不会继续得到浏览器的关注。
                如果其位置发生变化，那么整个场景也需要重新绘制，包括任何或许已被图形覆盖的对象;
                
                canvas：
                    依赖分辨率
                    不支持事件处理器
                    弱的文本渲染能力
                    能够以 .png 或 .jpg 格式保存结果图像
                    最适合图像密集型的游戏，其中的许多对象会被频繁重绘
                svg:
                    不依赖分辨率
                    支持事件处理器
                    图像中的文本是可选的，同时也是可搜索的（很适合制作地图）
                    最适合带有大型渲染区域的应用程序（比如谷歌地图）
                    复杂度高会减慢渲染速度（任何过度使用 DOM 的应用都不快）
                    不适合游戏应用
            -->
        </div>

        <div id="c_math" class="div_c_math">
            <h2 class="div_title">数学符号</h2>
            <hr/>
            <!--math：google 不支持？
                1. <mi>: 变量;
                2. <mn>: 数字;
                3. <mo>: 操作符;
                4. <msup>: 上标（幂）；
                5. <mrow>: 
            -->
            <!--申明命名空间 xlmns="./"-->
            <math>
                <!-- a^2+b^2 = c^2 -->
                <mrow>
                    <msup>
                        <mi>a</mi>
                        <mn>2</mn>
                    </msup>

                    <mo>+</mo>

                    <msup>
                        <mi>b</mi>
                        <mn>2</mn>
                    </msup>

                    <mo>=</mo>

                    <msup>
                        <mi>c</mi>
                        <mn>2</mn>
                    </msup>
                </mrow>
            </math>
        </div>

        <div id="c_drag_drop" class="div_c_drag_drop">
            <h2 class="div_title">拖放</h2>
            <hr/>

            <!--将拖动目标id传递给容器，然后通过id锁定对象添加到容器内；
            1. 需使用js函数；
            2. 目标元素设置属性 draggable="true"；
            3. ondragstart(拖动目标) -> ondragover（容器） -> ondrop（容器）;
            4. 承接容器；
            -->
            <div>
                <div class="tip_master">
                    <img id="drap_img" src="/SpringDemo/static/res/icon/icon.png" width="52" height="52" draggable="true" ondragstart="drag(event)"/>
                    <span class="tip_left">drag me</span>
                </div>
                <div class="div_c_drag_div" ondrop="drop(event)" ondragover="dragOver(event)"></div>
                <div class="div_c_drag_div" ondrop="drop(event)" ondragover="dragOver(event)"></div>
                <div class="div_c_drag_div" ondrop="drop(event)" ondragover="dragOver(event)"></div>
                <div class="div_c_drag_div" ondrop="drop(event)" ondragover="dragOver(event)"></div>
                <img src="/SpringDemo/static/res/icon/icon.png" class="drap_img2" width="52" height="52"/>
            </div>
            <br/>
        </div>

        <div id="c_location" class="div_c_location">
            <h2 class="div_title">定位</h2>
            <hr/>

            <!-- -->
            <p>我的位置：<span id="lat_lng" class="color_red">未知</span></p>
            <button onclick='getLocation("lat_lng")'>刷新</button>
            <div id="c_location_map"></div>
        </div>

        <div id="c_video" class="div_c_video">
            <h2 class="div_title">视频</h2>
            <hr/>
            <!--video 视频: 宽高，controls 控制栏
                1. HTML5 规定了一种通过 video 元素来包含视频的标准方法；
                2. 如果没有设置宽高，页面就会根据原始视频的大小而改变；
                3. <video> 与</video> 标签之间插入的内容是提供给不支持 video 元素的浏览器显示的；
                4. 支持多个 <source> 元素. 可以链接不同的视频文件[MP4(video/mp4), WebM(video/webm), Ogg(video/ogg)]，浏览器将使用第一个可识别的格式；
                5. <video> 和 <audio> 元素同样拥有方法、属性和事件;
            -->
            <div>
                <video id="video1" width="320" height="240" controls><!--controls-->
                    <!--src:资源路径，type:类型-->
                    <source src="/SpringDemo/static/res/video/video.mp4" type="video/mp4">
                    <!--track: 规定外部文本轨道，也就是字幕(.vtt)
                        default：默认轨道
                        src：资源路径
                        kind：文本类型 [captions,chapters,descriptions,metadata,subtitles]
                        srclang：语言类型
                    -->
<%--                    <track default kind="captions" srclang="en" src="../res">--%>
                    不支持提示
                </video>
                <br/>
                <button onclick='playPause("video1")'>播放|暂停</button>
                <button onclick='makeFull("video1")'>全屏</button>
                <button onclick='makeSmall("video1")'>缩小</button>
                <button onclick='makeNormal("video1")'>正常</button>
            </div>
        </div>

        <div id="c_audio" class="div_c_audio">
            <h2 class="div_title">音频</h2>
            <hr/>
            <!--audio 音频: 宽高，controls 控制栏
                1. <audio> 和 <video> 元素同样拥有方法、属性和事件;
                2. 支持类型：mp3(audio/mpeg), wav(audio/wav), ogg(audio/ogg)；
            -->
            <audio id="audio1" width="120" height="40" controls><!--controls-->
                <!--src:资源路径，type:类型-->
                <source src="/SpringDemo/static/res/audio/audio.mp3" type="audio/mpeg">
                不支持提示
            </audio>
        </div>

        <div id="c_sql" class="div_c_sql">
            <h2 class="div_title">数据库</h2>
            <hr/>

            <nav>
                <button onclick="createTable()">创建英雄池</button>
                <button onclick="deleteTable()">销毁英雄池</button>
                <button onclick="summon()">召唤</button>
                <button onclick="listHero()">查看</button>
                <button onclick="clearAll()">清空</button>
            </nav>

            <div id="c_sql_div" class="c_sql_div"> 快来召唤你的英雄吧！</div>
            <div id="c_sql_div_data" name="c_sql_div_data">空空如也的英雄池！</div>
        </div>

        <div id="c_worker" class="div_c_worker">
            <h2 class="div_title">后台服务</h2>
            <hr/>

            <!-- web worker: 运行在后台的 JavaScript，不会影响页面的性能
                1. 当在 HTML 页面中执行脚本时，页面的状态是不可响应的，直到脚本已完成;
                2. web worker 是运行在后台的 JavaScript，独立于其他脚本，不会影响页面的性能;
            -->
            <p>计数： <output id="c_worker_result"></output></p>
            <button onclick="startWorker()">开始</button>
            <button onclick="stopWorker()">停止</button>

        </div>
    </div>

    <div id="footer" class="div_footer">
        <hr/>
        我是有底线的<br/>
        Copyright@Forever <span class="span_hl_blue">Virgo</span>
    </div>
</div>
</body>
</html>