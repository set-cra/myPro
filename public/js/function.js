/**
 * @method add_aside
 * @description 为网页的主体添加一个右侧的辅助栏,回到顶部,wechat,qq 
 */
let add_aside = function () {
    document.head.innerHTML += `<link rel="stylesheet" href="../css/aside.css">`;
        let body = document.body;
        body.innerHTML += `
        <aside class="aside">
            <a href="javascript:void(0);" data-go="top" class="top"></a>
            <div class="wechat">
                <div class="erweima">
                    <img class="img" src="../img/aside/wechat.jpg" title="wechat_erweima">
                    <span>微信扫码<br>或者搜索xxxxx</span>
                </div>
            </div>
            <div class="qq"></div>
        </aside>`;
        let top = document.querySelector("[data-go=top]");
        top.onclick = function () {
            window.scrollTo(0,0);
        }
    
};
/**
 * @method rotation
 * @description 轮播图设置
 */
let rotation=function (){
    //获取全局使用了轮播属性的元素
    let rotation = document.querySelectorAll("[data-fc=rotation]");
    //遍历全局的轮播对象
    for (let key of rotation) {
        //获取参与轮播的内容
        if (!key.querySelector("[data-position=section]")) {
            continue;
        }
        let children = key.querySelector("[data-position=section]").children || {};
        //获取轮播的指示符
        let nav = key.querySelector("[data-position=nav]") || {};
        //获取指示符的元素
        let designator = nav.children || {};
        //将指示符的类数组转为成数组,方便使用API
        let des = Array.from(designator);
        //为每一个child添加动画结束监听
        for (let key of children) {
            key.addEventListener("animationend", () => {
                if (key.className == "rotation-items active out") {
                    key.className = "rotation-items";
                } else if (key.className == "rotation-items active play") {
                    key.className = "rotation-items active";
                }
            })
        }
        //开始轮播
        //轮播计时器回调函数
        function timer() {
            //转换轮播类数组为数组,使用API
            let childrenNode = Array.from(children);
            //查找满足条件的子节点
            childrenNode.find((elem, index, arr) => {
                if (elem.className.match(/rotation-items active/)) {
                    elem.className = "rotation-items active out";
                    des[index].className = "nav-items";
                    if (index == (arr.length - 1)) {
                        index = -1;
                    }
                    arr[index + 1].className = "rotation-items active play";
                    des[index + 1].className = "nav-items active";
                    return true;
                } else {
                    return false;
                }
            })
        }
        //定时器时间
        let times = key.getAttribute("data-time")||3000;
        //开启定时器
        let rotation = setInterval(timer,times);
        //是否存在指示符,且个数是否与轮播子元素相同,存在则添加点击效果
        if (designator.length && designator.length==children.length) {
            //绑定指示符父节点的监听事件
            //利用点击冒泡的特性减少监听函数的赋予
            nav.addEventListener("click", elem_click);
            //设置点击事件
            function elem_click(event) {
                //当触发点击的是子节点是
                if (event.target.nodeName === "LI") {
                    //关闭定时器
                    clearInterval(rotation);
                    let li = event.target;
                    //寻找激活的子节点并关闭,激活点击事件的子节点
                    des.find((elem, index, arr) => {
                        if (elem === li) {
                            if (elem.className == "nav-items active") {
                                (()=>rotation = setInterval(timer,times))();
                                return true;
                            }
                            for (let key of nav.getElementsByClassName("nav-items active")) {
                                //设置指示符对应的轮播图的退出动画
                                key.className = "nav-items";
                                children[arr.indexOf(key)].className = "rotation-items active out";
                            }
                            //激活点击指示对象
                            elem.className = "nav-items active";
                            //激活指示对象对应的轮播对象
                            children[index].className = "rotation-items active play";
                            //重启计时器,避免受到clear影响,函数自调用
                            (()=>rotation = setInterval(timer,times))();
                            return true;
                        } else {
                            return false;
                        }
                    })
                }
            }
            //遍历知识符类数组
            for (let key of designator) {
                //设置每一个指示符的宽高
                key.style.width = `${nav.offsetWidth / designator.length /2}px`;
                key.style.height = `${nav.offsetWidth / designator.length / 2}px`;
            }
        }
    }
};

/**
 * @method Ajax
 * @param {url,data,func}:{url:url,data:Object,func:(xhr)=>{}}
 * @description Ajax异步对象请求数据
 */
let Ajax = function (method,url,func=(xhr=>console.log(xhr.responseText)),data=null) {
    if (!method) {
        throw "method not is empty";
    }
    if (!url) {
        throw "url not is empty";
    }
    if (typeof data != "object") {
        throw "data not a Object";
    }
    //需要发送请求信息时
    Object.defineProperty(Object.prototype,"toQueryString",{
        configurable:true,
        enumerable:false,
        writable: false,
        value(){
            let str = "";
            for (let key in this) {
                str += `${key}=${this[key]}&`;
            }
            return str.slice(0,str.length-1);
        }
    });
    //创建异步对象
    let xhr = new XMLHttpRequest();
    //绑定监听,接受响应
    xhr.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            func(xhr);
        }
    }
    //处理get请求
    if (method == "get") {
        if (data) {
            //将对象转化为查询字符串,拼接到字符串中
            url += "?" + data.toQueryString();
            data = null;
        }
    } else {
        throw "this method is not support";
    }
    //打开请求
    xhr.open("get", url, true);
    //根据处理post请求方式
    if (method=="post") {
        //设置请求头信息内容文本类型
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        //数据对象转化为文本
        data = data.toQueryString();
    }
    //发送请求
    xhr.send(data);
}
/**
 * @method add_header
 * @description 为网页添加头部
 */
function add_header(new_class = "double only fixed", old_class = "double fixed") {
    /*
        优化:
        页面头部引入加载时,出现闪烁:css的link标签和节点同时进入节点树,
        导致link标签需要先进入dom树,再加载css树,所以导致节点有时会因为未被渲染
        而出现二次渲染网页(闪烁),所以将css放在异步请求之外,率先加载css树,
        等待节点异步加载之后直接渲染,解决闪烁问题
     */
    //在头部增加头部css样式
    add_css("../css/header.css");
    Ajax("get", "header.html", (xhr) => {
        //增加一个父节点撑起子元素浮动后之后的高度
        let parent = document.createElement("div");
        //增加网页内部内容
        parent.innerHTML = xhr.responseText;
        //添加的元素
        let elem = parent.firstElementChild;
        elem.style.opacity = 0;
        //修改适应当前页面头部样式
        change_header(elem, new_class, old_class);
        //替换网页节点
        document.getElementById("header").replaceWith(parent);
        //调整当前位置调整头部样式
        btnOpen();
        //当页面滚动时,动态修改头部样式
        window.onscroll = function () {
            change_header(elem, new_class, old_class);
        }
            /*
                优化:
                当头部固定定位之后,脱离文本流,需要使用一个空白的父节点来撑起元素本来的高度,
                以保持页面高度,但是子元素动态修改之后,不会自动刷新自身的值,调用时,只能获取初始值
                所以选择被动式的监听鼠标在页面时,刷新,这种方法需要鼠标进入时有稍微的移动
                因为本页面不是响应式,所以直接写死数值
             */
            // window.onmouseover = function () {
            //     //撑起父节点高度,保持页面高度
            //     parent.setAttribute("style", `height:${elem.offsetHeight}px`);
            //     window.onmouseover = "";
            // }
        
            // if (location.pathname == "/html/index.html") {
            //     parent.style.height='212px';
            // } else {
            //     parent.style.height='74px';
            // }
            /*
                优化:自定义header高度变化监听定时器,当class类渲染之后
                高度发生变化,获取新的高度值与之前的高度值发生变化,执行
                父节点高度撑起.
                原理:设置定时间,动态监听元素的高度变化,获取最高的值,以撑起页面
                监听网页窗口的宽度,当宽度发生变化时,元素高度也会变化,所以新增窗口宽度监听
                当窗口宽度改变,也会重置最大高度
             */
            function onheaderheightchange(header,parent){
                let { offsetHeight: max } = header;
                let { outerWidth: old_width } = window;
                setInterval(() => {
                    let { outerWidth: new_width } = window;
                    if (new_width != old_width) {
                         max  = header.offsetHeight;
                    }
                    let { offsetHeight: new_height } = header;
                    if (new_height > max) {
                        max = new_height;
                    }
                    parent.setAttribute("style", `height:${max}px`);
                    header.style.opacity = 1;
                }, 100);
            };
        onheaderheightchange(elem, parent);
    });
}
/**
 * @description 调整头部样式
 */
function change_header(elem, newc, oldc) {
    let reference = document.querySelector("[data-reference=header-class]");
    let long;
    if (reference) {
        long = reference.scrollHeight / 4 * 3;
    } else {
        long = 120;
    }
    let move = document.documentElement.scrollTop;
    let top = document.querySelector("[data-go=top]");
    if (move > long) {
        elem.setAttribute("class", newc);
        top.className="top active"
    } else {
        elem.setAttribute("class", oldc);
        top.className="top"
    }
    let logo = elem.querySelector(".only .first-row");
    if (logo) {
        logo.firstElementChild.onclick = function (e) {
            if (e.target.parentNode == this) {
                window.open("index.html", "_self");
            }
        }
        if (logo.parentNode.className != "double only fixed") {
            logo.firstElementChild.onclick = "";
        }
    }
}
/**
 * @method add_footer
 * @description 为网页添加脚部
 */
function add_footer(){
    Ajax("get", "footer.html", (xhr) => {
        add_css("../css/footer.css");
        let parent = document.createElement("fooer");
        parent.innerHTML = xhr.responseText;
        document.getElementById("footer").replaceWith(parent);
    })
}
/**
 * @method get_browser
 * @description 获取用户浏览器名称和版本号
 */
let get_browser = function () {
    let uAgent=navigator.userAgent;
    let browser,version;
    if(uAgent.indexOf("IE")!=-1){
        browser="IE";
    }else
        if(uAgent.indexOf("Trident")!=-1){
            browser="IE";
            version=11;
        }else 
            if(uAgent.indexOf("Firefox")!=-1){
                browser="Firefox";
            }else
                if(uAgent.indexOf("OPR")!=-1){
                    browser="OPR";
                }else
                    if(uAgent.indexOf("Edge")!=-1){
                        browser="Edge";
                    }else
                        if(uAgent.indexOf("Chrome")!=-1){
                            browser="Chrome";
                        }else
                            if(uAgent.indexOf("Safari")!=-1){
                                browser="Safari";
                            }
    if(!version){
        version=parseInt(uAgent.slice(uAgent.indexOf(browser)+browser.length+1));
    }
    return { browser, version };
}
/**
 * @description 为data-open元素增加跳转效果
 */
let btnOpen = function () {
    let open_elem = document.querySelectorAll("[data-target=open]");
    for (let key of open_elem) {
        key.onclick = function () {
            if (window.parent) {
                open(key.getAttribute("data-open"),"_self");
            } else {
                open(key.getAttribute("data-open"),"_self");
            }
        }
    }
};
/**
 * @method add_list
 * @param {String} str 拼接的字符串 
 * @param {Object} key 拼接的内容对象
 */
function add_list(str, key) {
    return str+=`
        <!-- 容器 -->
        <div class="floor1-div" data-class-id="${key.c_id}">
            <!-- 图片 -->
            <img src="${key.c_img}" alt="img">
            <!-- VIP标志 -->
            ${key.is_vip?"<span class='vip'>VIP</span>":''}
            <!-- 信息 -->
            <div class="info-parent">
                <!-- 标题和评价 -->
                <div class="first">
                    <span class="title">${key.c_name}</span>
                    <div class="assess">
                        <div class="bg" style="width:${35*key.score/5}%"></div>
                        <div class="assess-img">
                        </div>
                        <span class="assess-font">${key.buy_number}评论</span>
                    </div>
                </div>
                <!-- 购买和收藏价格 -->
                <div class="second">
                    <span class="buy">${key.buy_number}</span>
                    <span class="collect">${key.buy_number}</span>
                    <button class="price">${key.c_price?"￥"+parseFloat(key.c_price).toFixed(2):"免费"}</button>
                </div>
            </div>
        </div>
    `;
}
/**
 * @method add_css
 * @param {String} href css路径
 */
function add_css(href) {
    let link = document.createElement("link");
    let rel = "stylesheet";
    link.setAttribute("rel",rel);
    link.setAttribute("href", href);
    document.head.appendChild(link);
}
/**
 * @method add_pagebtn
 * @param {Object} xhr 
 * @param {function} btn 
 * @description 添加页数下标按钮
 */
function add_pagebtn(xhr,info,page,btn) {
    //获取添加页码按钮的父节点
    let page_list = document.querySelector("#pageList"); 
    //获取本次请求的url,并解析获取查询条件
    let query = xhr.responseURL.slice(xhr.responseURL.indexOf("?") + 1).split(/&|=/g);
    //如果页码按钮不存在,则为该页面内容添加页码按钮
    if (!page_list.children.length) {
        //页码的子内容
        let num = "";
        //设置获取总的页面数的请求信息
        let Obj = { info: info};
        //遍历本次总查询内容,获取限制条件
        for (let key = 0; key < query.length; key += 2){
            if (query[key] != "info") {
                Obj[query[key]] = query[key+1];
            }
        }
        //开始请求总页数
        Ajax("get", xhr.responseURL.slice(0, xhr.responseURL.indexOf("?")), (xhr) => {
            //获取对象并进行数据处理(6个为一个页面)
            let total = Math.floor((JSON.parse(xhr.responseText)[0].total_page) / page);
            //当满足条件个数小于限定值时,但还是有内容时,应当也有一个页面
            if (total <= 1) { total = 1 };
            //开始遍历页码个数
            for (let i = 1; i <= total; i++){
                //为第一个页码加上激活标签
                num += `<li class="item ${i==1?"active":''}">${i}</li>`;
            }
            //检测是否有按钮功能添加函数传入
                page_list.innerHTML += `<ul class="listbar">
                <li class="item ban">上一页</li>
                ${num}
                <li class="item ${total==1?"ban":""}">下一页</li>
                </ul>`;
                btn();
        }, Obj);
    }
}
/**
 * @method add_listbtn
 * @param {Object} xhr 
 * @param {function} add_fn 
 * @description 添加页数下标导航栏点击事件
 */
function add_listbtn(xhr,add_fn) {
    //获取本次请求的url
    let url = xhr.responseURL.slice(0, xhr.responseURL.indexOf("?"));
    //获取本次请求的信息
    let query_arr = xhr.responseURL.slice(xhr.responseURL.indexOf("?") + 1).split(/=|&/g);
    //获取请求的信息名字
    let info = query_arr[query_arr.indexOf("info") + 1];
    //获取页码下标
    let ul = document.querySelector("ul.listbar");
    //获取第一个按钮(上一页)
    let first = ul.firstElementChild;
    //获取最后一个按钮(下一页)
    let last = ul.lastElementChild; 
    //设置上一页的点击事件
    first.addEventListener("click", function () {
        //当按钮不禁用时,才有点击事件
        if (this.className != "item ban") {
            //模拟当前激活的active的页码的前一个按钮的点击,触发点击事件
            document.querySelector("ul.listbar li.active").previousElementSibling.click();
        }
    })
    //设置下一页的点击事件
    last.addEventListener("click", function () {
        //下一页不被禁用时执行
        if (this.className != "item ban") {
            //模拟当前激活的节点的下一个节点的点击事件
            document.querySelector("ul.listbar li.active").nextElementSibling.click();
        }
    })
    //设置页码按钮的点击事件
    ul.addEventListener("click", function (e) {
        //获取触发时间的元素
        let elem = e.target;
        //触发元素是页码ul的子元素
        if (elem.parentNode != this) {
            return;
        }
        //当这个按钮本就激活时,不再重复请求
        if (elem.className == "item active") {
            return;
        }
        //当这个按钮不是第一个和最后一个时,执行请求获取满足条件的课程内容
        if (elem != last && elem != first) {
            //设置已激活的按钮恢复原状
            document.querySelector("ul.listbar li.active").className = "item";
            //将当前节点激活
            elem.className = "item active";
            //当前节点是第一页时禁用上一页按钮,反之启用
            if (elem.previousElementSibling == first) {
                first.className = "item ban";
            } else {
                first.className = "item";
            }
            //当前节点是最后一页时禁用下一页按钮,反之启用
            if (elem.nextElementSibling == last) {
                last.className = "item ban";
            } else {
                last.className = "item";
            }
            //开始发送内容请求
            //调用增加商品内容的函数,将接受的数据放入页面中
            //将条件写入{}中
            Ajax("get", url, xhr=>add_product(xhr,add_fn),{ info, page: elem.innerHTML })
        }
    })
}
/**
 * 
 * @param {Object} xhr 
 * @param {function} add_list 
 * @param {function} btn 可以为空 
 */
//加载内容函数
function add_product(xhr, add_list, btn) {
    //解析JSON为数组
    let arr = JSON.parse(xhr.responseText);
    //获取添加内容的父节点
    let parent = document.querySelector("[data-list=list]");
    
    //课程内容innerHTML
    let str = "";
    //如果课程内容不存在则提示文字
    if (arr.length == 0) {
        str = `<span class="empty_warn">暂无该类型课程,我们正在努力ING<span>`;
    } else {
        //如果课程内容存在执行添加内容函数
        for (let key of arr) {
            str = add_list(str, key);
        }
    }
    //添加课程内容到父节点上
    parent.innerHTML = str;
    
    //当传入按钮添加函数时,执行
    if (btn) {
        btn();
    }
}
//为课程列表添加跳转
function class_detail(parent) {
    parent.addEventListener("click", e => {
        let child = e.target;
        switch (child.nodeName) {
            case "IMG": open(`./class_detail.html?c_id=${child.parentNode.getAttribute("data-class-id")}`, "_self"); break;
            case "SPAN":
                if (child.className == "title") {
                    open(`./class_detail.html?c_id=${child.parentNode.parentNode.parentNode.getAttribute("data-class-id")}`, "_self");
                }
                break;
            case "BUTTON":
                if (child.className == "price") {
                    open(`./class_detail.html?c_id=${child.parentNode.parentNode.parentNode.getAttribute("data-class-id")}`, "_self");
                }
                break;
            default: return;
        }
    });
}
//课程跳转
function to_class_detail(parent){
    if (!parent) {     
        //获取添加内容的父节点
        let parent = document.querySelector("[data-list=list]");
        //添加跳转点击按钮
        class_detail(parent);
    }
};
