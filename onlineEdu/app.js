//获取express组件,构建服务器
const express = require("express");
//使用body-parser解析post请求主体为对象
const bodyparser=require("body-parser");
//使用cors解决跨域
const cors=require("cors");
//获取pc端页面路由
const info=require("./routes/info");
//获取后台页面路由
const backstage=require("./routes/backstage");
//获取express-session来确定用户对象
const expressSession = require("express-session");


//创建服务器
let server = express();
///监听窗口8088
server.listen(8088);
//打印监听窗口
console.log("listen 8088");


//使用cors伪装解决跨域
server.use(cors({
    origin:['http://127.0.0.1:8080','http://localhost:8080'],
    credentials:true
}))

//使用session标记用户
server.use(expressSession({
    secret:"128位字符串",
    resave:true,
    saveUninitialized:true,//是否保存未初始化的会话
    cookie:{maxAge:1000*60*60*4}//设置4小时安全验证
}))

//使用bodyparse解析post主体为对象
server.use(bodyparser.urlencoded({
    extended: false
}))


//挂载客户端页面路由
server.use("/info",info);
//挂载后台路由
server.use("/backstage",backstage);
