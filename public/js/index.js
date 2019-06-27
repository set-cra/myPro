//添加侧边栏
add_aside();
//DOM数加载完成之后执行
//添加头部
add_header();
//添加脚步
add_footer();

//异步对象加载首页
(()=>{
    //使用异步对象获取floor1数据
    Ajax("get", "http://127.0.0.1:8088/info/index", xhr => {
        let arr = JSON.parse(xhr.responseText);
        let parent = document.querySelector(".floor1-section");
        let innerHTML = "";
        for (let key of arr) {
            innerHTML = add_list(innerHTML, key);
        }
        parent.innerHTML += innerHTML;
        class_detail(parent);
    }, { info: "floor1" });
    //使用异步对象获取教师轮播图数据
    Ajax("get", "http://127.0.0.1:8088/info/index", xhr => {
        let arr = JSON.parse(xhr.responseText);
        let parent = document.querySelector(".rotation.teacher[data-fc=rotation]");
        let child = document.createDocumentFragment();
        let ul = document.createElement("ul");
        ul.innerHTML = "";
        child.innerHTML = `<div class="rotation-section" data-position="section">`;
        for (let i = 0; i < arr.length; i += 2) {
            child.innerHTML += `<div class="rotation-items ${i == 0 ? "active" : ""}">`
            for (let key of arr.slice(i, i + 2)) {
                child.innerHTML += `
                    <div class="people">
                        <div class="one" style="background-image:url('${key.t_img}')"></div>
                        <div class="font">
                            <span>“</span><br>
                            <span class="name">${key.t_name}</span>
                            <span class="job">${key.t_job}</span>
                            <p class="detail">${key.t_detail}</p>
                            <span>”</span>
                        </div>
                    </div>
                `;
            }
            child.innerHTML += `</div>`;
            ul.innerHTML += `<li class="nav-items ${i == 0 ? "active" : ""}"></li>`;
        }
        child.innerHTML += `</div>`;
        child.innerHTML += `
        <ul class="rotation-nav" data-position="nav">
        ${ul.innerHTML}
        </ul>`;
        parent.innerHTML = child.innerHTML;
        //调用轮播
        rotation();
    }, { info: "teacher" });
    //动态加载新闻列表
    Ajax("get", "http://127.0.0.1:8088/info/index", xhr => {
        //转换json对象数组字符串
        let arr = JSON.parse(xhr.responseText);
        //获取加载新闻的父节点
        let parent = document.querySelector(".newinfo .section");
        //创建innerHTML字符串
        let innerHTML = "";
        //热点新闻1-4
        //top
        innerHTML += `<!-- 热点 -->
        <div class="top">
            <img src="${arr[0].n_img}" alt="热点新闻配图">
            <span class="top-title">${arr[0].n_title}</span>
            <article class="top-detail">${arr[0].n_detail.slice(arr[0].n_detail.indexOf("<p>") + 3, arr[0].n_detail.indexOf("</p>") - 1)}</article>
        </div>`;
        //其余新闻
        innerHTML += "<!-- 最新动态 --><div class='new'>";
        for (let key of arr) {
            if (key.n_id != arr[0].n_id) {
                innerHTML += `<div>
                <!-- 日期 -->
                <div class="new-date">
                    <span>${(new Date(key.n_date)).getDate()}</span>
                    <span>${(new Date(key.n_date)).getMonth()},${(new Date(key.n_date)).getFullYear()}</span>
                </div>
                <!-- 信息 -->
                <div class="new-info">
                    <span class="new-title">${key.n_title}</span>
                    <p class="new-detail">${key.n_detail.slice(key.n_detail.indexOf("<p>") + 3, key.n_detail.indexOf("</p>") - 1)}</p>
                </div>
            </div>`;
            }
        }
        innerHTML += "</div>";
        parent.innerHTML = innerHTML;
    }, { info: "news" });
})();