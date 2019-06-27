//添加侧边栏
add_aside();
//添加头部
add_header("double only fixed", "double only normal fixed");
//添加脚步
add_footer();

(() => { 
    window.onload = function () {
        let str = location.search.slice(1, location.search.indexOf("="));
        let num = parseInt(location.search.slice(location.search.indexOf("=")+1));
        switch (str) {
            case "e_id": exam_content(num); break;
            case "c_id": class_content(num); break;
            case "n_id": new_content(num); break;
            default: alert("网址错误"); open("index.html","_self");
        }
    }
})();
function exam_content(e_id) {
    Ajax("get", "http://127.0.0.1:8088/info/content", xhr => {
        let arr = JSON.parse(xhr.responseText);
        let parent = document.getElementById("problem-container");
        let str='';
        if (!arr) {
            str = "不存在题目";
        }else {
            let only=[];
            let multi=[];
            for (let key of arr) {
                if (key.is_multi) {
                    multi[multi.length] = key;
                } else {
                    only[only.length] = key;
                }
            }
            let pro_num=0;
            if (only.length) {
                str += `<span class="only">单选题</span><hr/>`;
                for (let key of only) {
                    str += `<div class="problem-div" id="pro${key.p_id}">
                    <div class="problem-title">
                    ${++pro_num}.${key.p_content}
                    </div>
                    <div class="problem-option">
                    ${option(key.p_id,key.p_options,key.is_multi)}
                    </div>
                    <div class="problem-answerAndWhy">
                    
                    </div>
                </div>`; 
                }
            }
            if (multi.length) {
                str += `<span class="multi">多选题(多选或少选都是错误)</span><hr/>`;
                for (let key of multi) {
                    str += `<div class="problem-div" id="pro${key.p_id}">
                    <div class="problem-title">
                    ${++pro_num}.${key.p_content}
                    </div>
                    <div class="problem-option">
                    ${option(key.p_id,key.p_options,key.is_multi)}
                    </div>
                    <div class="problem-answerAndWhy">
    
                    </div>
                </div>`; 
                }
            }
        }
        str += `<button id="submit_btn">交卷</button>`;
        parent.innerHTML = str;
        submit_btn(arr);
    }, {e_id})
}

function option(id,arr, bool) {
    let str='';
    let $arr = Array.from(eval(arr));
    let num = 65;
    for (let key of $arr) {
        if (!bool) {
            str += `<div><input class="option-item" type="radio" name="pro${id}" id="pro${id}_${num}" value="${num-64}"><label for="pro${id}_${num}">${String.fromCharCode(num++)}、${key}</label></div>`;
        } else {
            str += `<div><input class="option-item" type="checkbox" name="pro${id}" id="pro${id}_${num}" value="${num-64}"><label for="pro${id}_${num}">${String.fromCharCode(num++)}、${key}</label></div>`;
        }
    }
    return str;
}

function submit_btn(arr) {
    let btn = document.getElementById("submit_btn");
    let query = location.search;
    let obj = { eid: `${query.slice(query.indexOf("e_id=")+5, query.indexOf("&", query.indexOf("e_id=")+5)==-1?query.length:query.indexOf("&", query.indexOf("e_id=") + 5))}` };//答案对象
    window.addEventListener("click", function (e) {
        //每一次选择点击,更新一次答案对象
        if (e.target.tagName == "INPUT") {
            for (let key of arr) {
                let input = document.getElementsByName(`pro${key.p_id}`);
                let arr = [];
                for (let checked of input) {
                    if (checked.checked) {
                        arr[arr.length] = parseInt(checked.value);
                    }
                    if (arr.length) {
                        obj[key.p_id] = `[${arr}]`;
                    }
                }
            }
            //当题目做完时,激活提交按钮
            if (Object.keys(obj).length == arr.length+1) {
                btn.className = "active";
            } else {
                btn.removeAttribute("class");
            }
        } else
            if (e.target == btn) {
                if (btn.className) {
                    Ajax("get", "http://127.0.0.1:8088/info/proanswer", (xhr) => {
                        let arr = JSON.parse(xhr.responseText);
                        btn.parentNode.removeChild(btn);
                        for (let key of document.getElementsByTagName("input")) {
                            key.disabled = true;
                        }
                        for (let key of arr) {
                            let prodiv = document.getElementById(`pro${key.p_id}`);
                            if (!key.p_right) {
                                prodiv.className = "problem-div error";
                            }
                            let answer = '';
                            let str=key.p_answer.slice(key.p_answer.indexOf("[") + 1, key.p_answer.indexOf("]")).split(",");
                            for (let i of str) {
                                if (answer.length) answer += ",";
                                answer += String.fromCharCode(64 + parseInt(i));
                            }
                            console.log(answer);
                            prodiv.lastElementChild.innerHTML = `答案${answer}<br/>解析:
                            ${key.p_why}`;
                        }
                    },obj)
                } else {
                    alert("题目未完成,请继续答题");
                }
            }
    })
}