const express=require("express");
const pool=require("../pool");
const router=express.Router();
//管理员登录
router.post('/adminlogo',(req,res)=>{
    console.log("login");
    console.log(req.sessionID);    
    let{adminname:ad_name,adminpass:ad_pass}=req.body;
    let str=`SELECT ad_id,ad_power FROM adminer WHERE ad_name='${ad_name}' AND ad_pass=md5('${ad_pass}')`;
    pool.query(str,(err,data)=>{
        if(err) throw err;
        if(data.length>0){
            req.session.admin=data[0];
            console.log(req.session);
            res.send({code:1,message:"登录成功",data});
            return;
        }else{
            res.send({code:-1,message:"登录失败"});
        }
    })
})
//验证管理员是否登录
router.post('/confirm',(req,res)=>{
    console.log("confirm");
    console.log(req.sessionID);
    console.log(req.session.admin)
    if(!req.session.admin){
        res.send({code:-1,message:'未登录'});
        return;
    }
    let {ad_id:adid,ad_power:adpower}=req.session.admin;
    res.send({code:1,message:'登录',data:{adid,adpower}});
    
})
module.exports=router