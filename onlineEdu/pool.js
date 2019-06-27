//获取数据库模块
const mysql=require("mysql");

//创建连接池
let pool=mysql.createPool({
    port:3306,
    host:"localhost",
    user:"root",
    password:"",
    connectionLimit:15,
    database:"OnlineEdu"
})

//分享pool
module.exports=pool;