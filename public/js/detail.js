(() => {
    let c_id = location.search.match(/c_id=\d+/).toString().split("=")[1];
    if (c_id) {
        Ajax("get", `http://127.0.0.1:8088/info/content`, xhr => {
            let info = JSON.parse(xhr.responseText)[0];
            let section = document.getElementById("section");
            document.head.innerHTML += `<title>${info.c_name}</title>`;
            section.className="class-container"
            section.innerHTML = `
                
            `;
        },{c_id})
    } else {
        open("class.html","_self");
        }
})();
//添加侧边栏
add_aside();
//添加头部
add_header("double only fixed", "double only normal fixed");
//添加脚步
add_footer();