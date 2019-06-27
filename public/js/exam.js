//添加侧边栏
add_aside();
//添加头部
add_header("double only fixed", "double only normal fixed");
//添加脚步
add_footer();

/**
 * @method add_exam
 * @param {String} str 
 * @param {Object} key
 * @description 添加考试列表 
 */
function add_exam(str,key) {
    return str += `<!-- 子元素 -->
    <div class="exam-div" data-eid="${key.e_id}">
        <!-- 图片 -->
        <img src="${key.e_img}" class="img">
        <!-- 文字 -->
        <div class="span">
            <span class="title">${key.e_title}</span>
            <span class="number">共收录${key.exam_total}道试题</span>
        </div>
    </div>`;
}
{
    Ajax("get", "http://127.0.0.1:8088/info/index", xhr => {
        //解析获取的数据并添加到页面上
        add_product(xhr, add_exam, () => {
            //添加按钮
            add_pagebtn(xhr,"exam_page",12,() => {
                //给按钮点击事件传参
                add_listbtn(xhr,add_exam);
            });
        })
    },{info:"exam",page:"1"})
}
//按钮下拉和选择事件
(() => {
    //动态添加课程类型
    //获取被替换的节点的父节点
    let select = document.querySelector(".container .select:first-child");
    let options = select.lastElementChild;
    Ajax("get", "http://127.0.0.1:8088/info/index", (xhr) => {
        let arr = JSON.parse(xhr.responseText);
        let str = "";
        for (let key of arr) {
            str += `<span data-id="${key.e_id}" class="item">${key.e_title}</span>`;
        }
        options.innerHTML = str;
    },{info:"exam_type"})
    //绑定全局点击监听,实现下拉菜单
    window.addEventListener("click", function (event) {
        //遍历时间冒泡路径
        for (let key of event.path) {
            //获取路径中有.select的元素标签
            if (key.className == "select") {
                //检查该元素是否要添加下拉功能
                if (key.getAttribute("data-fn") == "select") {
                    //处理点击事件,检测该元素选项的当前状态
                    if (key.lastElementChild.className == "option") {
                        //处于隐藏式,激活该选项卡
                        key.lastElementChild.className = "option active";
                        key.lastElementChild.setAttribute("style", `height:${key.lastElementChild.childElementCount * key.lastElementChild.firstElementChild.offsetHeight}px`)
                    } else {
                        //处于显示时隐藏选项卡
                        key.lastElementChild.className = "option";
                        key.lastElementChild.removeAttribute("style");
                    }
                } else {
                    return;
                }
            }
            //option子元素点击后修改显示内容
            if (key.className == "item") {
                if (key.parentNode.parentNode.className == "select") {
                    key.parentNode.parentNode.firstElementChild.innerHTML = key.innerHTML;
                    key.parentNode.parentNode.firstElementChild.setAttribute("data-id", key.getAttribute("data-id"));
                }
            }
        }
        //获取选项列表
        let select = document.querySelectorAll("[data-fn=select]");
        //遍历选项列表
        for (let key of select) {
            //判断触发的对象是否是自身,不是则关闭自身弹窗
            if (key.firstElementChild != event.target) {
                if (key.firstElementChild) {
                    key.lastElementChild.className = "option";
                }
            }
        }
        //搜索按钮的请求绑定
        if (event.target.getAttribute("data-fn") == "submit") {
            //设置请求信息
            let Obj = { info: "exam", page: "1" };
            //遍历下拉列表
            for (let key of select) {
                //获取列表显示内容中的data-id属性
                key.firstElementChild.getAttribute("data-id")
                    ? (
                        //存在id值，则获取父节点的数据类型
                        key.getAttribute("data-content")
                            ?
                            //父节点存在数据类型，子节点有id属性,则将id值加入请求信息对象的对应数据类型中
                            Obj[key.getAttribute("data-content")] = key.firstElementChild.getAttribute("data-id")
                            //父节点不存在数据类型就跳过执行
                            : '')
                    //子节点上不存在id值跳过执行对象属性添加
                    : '';
            }
            Ajax("get", "http://127.0.0.1:8088/info/index", (xhr) => {
                //内容脚部重置按钮
                console.log(xhr.responseText);
                let page_list = document.querySelector("#pageList"); 
                page_list.innerHTML = "";
                add_product(xhr, add_exam, () => {
                    //添加按钮
                    add_pagebtn(xhr,"exam_page",12,() => {
                        //给按钮点击事件传参
                        add_listbtn(xhr,add_exam);
                    });
                })
            }, Obj);
        }
        //重置按钮内容并向服务器请求初始内容
        if(event.target.getAttribute("data-fn")=="reset"){
            for(let key of document.querySelectorAll("[data-fn=select]")){
                key.firstElementChild.innerHTML=key.firstElementChild.getAttribute("data-words");
            }
            Ajax("get", "http://127.0.0.1:8088/info/index", xhr => {
                //解析获取的数据并添加到页面上
                add_product(xhr, add_exam, () => {
                    //内容脚部重置按钮
                    let page_list = document.querySelector("#pageList");
                    page_list.innerHTML = "";
                    //添加按钮
                    add_pagebtn(xhr,"exam_page",12,() => {
                        //给按钮点击事件传参
                        add_listbtn(xhr,add_exam);
                    });
                })
            }, { info: "exam", page: "1" })
        }
    });
})();
//全局监听点击事件
function to_detail_page(querystr, fn) {
    document.querySelector(querystr).addEventListener("click", function (e) {
        let target = e.target;
        fn(target);
    })
}
to_detail_page("#examList", target => {
    let e_id;
    switch (target.className) {
        case "img": e_id = target.parentNode.getAttribute("data-eid"); break;
        case "title": e_id = target.parentNode.parentNode.getAttribute("data-eid"); break;
        default: e_id = null;
    }
    if (e_id) {
        open("online_exam.html?e_id="+e_id, "_self");
    }
})