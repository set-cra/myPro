(() => {
    if(!location.search.match(/c_id=\d+/)) open("class.html","_self");
    let c_id = location.search.match(/c_id=\d+/).toString().split("=")[1];
    Ajax("get", `http://127.0.0.1:8088/info/content`, xhr => {
        let info = JSON.parse(xhr.responseText)[0];
        let section = document.getElementById("infoSection");
        document.head.innerHTML += `<title>${info.c_name}</title>`;
        section.className="class-container"
        section.innerHTML += `
        <!-- 主体内容 -->
        <section class="info-section">
            <!-- 文字信息 -->
            <div class="info-box">
                <img src="${info.c_img}">
                <div class="info-text-box">
                    <span class="info-title">${info.c_name}</span>
                    <span class="info-price">${info.c_price == 0 ? "免费" : "&yen;" + info.c_price}</span>
                    <button class="info-btn" disabled>购买</button>
                </div>
            </div>
            <!-- 图片信息 -->
            <div style="font-size:45px;align-self:flex-start;border-bottom:4px solid #e53;margin-bottom:5px;width:100%;">详情介绍</div>
            <img style="width:80%" src="${info.c_detail}">
        </section>
        `;
    },{c_id})
})();
//添加侧边栏
add_aside();
//添加头部
add_header("double only fixed", "double only normal fixed");
//添加脚步
add_footer();