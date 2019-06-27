const express=require("express");
const pool=require("../pool");
const router=express.Router();

router.get("/index",(req,res)=>{
    let str;
    switch(req.query.info){
        case "floor1":
            str="SELECT class.c_id,class.c_name,class.c_img,class.c_price,COUNT(buy_class.c_id) AS buy_number,SUM(buy_class.score)/COUNT(buy_class.u_id) AS score FROM class  RIGHT JOIN buy_class ON class.c_id=buy_class.c_id GROUP BY class.c_id ORDER BY score DESC LIMIT 1,6;";
            break;
        case "teacher":
            str="SELECT t_name,t_img,t_job,t_detail FROM teacher";
            break;
        case "news":
            str="SELECT n_id,n_title,n_img,n_detail,n_date FROM news";
            break;
        case "list":
            str=`SELECT class.c_id,class.c_name,class.c_img,class.c_price,class.is_vip,class.degree,COUNT(buy_class.c_id) AS buy_number,SUM(buy_class.score)/COUNT(buy_class.u_id) AS score FROM class  LEFT JOIN buy_class ON class.c_id=buy_class.c_id ${req.query.fee||req.query.class_type||req.query.degree?"where ":""}${req.query.class_type?' c_tid='+req.query.class_type:''}${req.query.class_type&&req.query.degree?" AND ":""}${req.query.degree?' degree='+req.query.degree:''}${(req.query.class_type||req.query.degree)&&req.query.fee?" AND ":""}${req.query.fee==0?' c_price=0':(req.query.fee==1?' is_VIP=1':(req.query.fee==2?' c_price != 0 AND is_VIP=0':''))} GROUP BY class.c_id ORDER BY score DESC LIMIT ${6*(req.query.page-1)},6`;
            break;
        case "total_page":
            str=`SELECT COUNT(c_id) AS total_page FROM class ${req.query.fee||req.query.class_type||req.query.degree?" where ":""}${req.query.class_type?' c_tid ='+req.query.class_type:''}${req.query.class_type&&req.query.degree?" AND ":""}${req.query.degree?' degree='+req.query.degree:''}${(req.query.class_type||req.query.degree)&&req.query.fee?" AND ":""}${req.query.fee==0?' c_price=0':(req.query.fee==1?' is_VIP=1':(req.query.fee==2?' c_price != 0 AND is_VIP=0':''))}`;
            break;
        case "class_type":
            str="SELECT ct_name,ct_id FROM class_type";
            break;
        case "exam":
            str=`SELECT exam.e_id,exam.e_title,exam.e_img,COUNT(problem.p_id) AS exam_total FROM exam LEFT JOIN problem ON exam.e_id=problem.e_id ${req.query.exam_type ? "WHERE exam.e_id="+req.query.exam_type:''} GROUP BY exam.e_id Limit ${12*(req.query.page-1)},12`;
            break;
        case "exam_page":
            str=`SELECT COUNT(e_id) as total_page FROM exam`;
            break;
        case "exam_type":
            str=`SELECT e_id,e_title FROM exam`;
            break;
        default:
            res.send({msg:"err"});return;
    };
    
    pool.query(str,(err,result)=>{
        if(err) throw err;
         res.writeHead(200,{
             "Access-Control-Allow-Origin":"*",
             "Content-Type":"Applaction/Json;Charset='UTF-8'"
         })
         res.write(JSON.stringify(result));
         res.end();
    })
})
//请求详细信息
router.get("/content",(req,res)=>{
    let str;
    console.log(typeof req.query.e_id);
    if(req.query.e_id){
        str=`SELECT p_id,p_content,p_options,is_multi FROM problem WHERE e_id=${req.query.e_id}`;
    }else 
        if(req.query.c_id){
            str=`SELECT c_name,c_img,c_detail,c_price,is_vip FROM class WHERE c_id=${req.query.c_id}`;
        }else if(req.query.n_id){
            str=`SELECT n_title,n_img,n_detail,n_date FROM news WHERE n_id=${req.query.n_id}`;
        }else{
            console.log(404)
            res.send(404);
            return ;
        }
    pool.query(str,(err,result)=>{
        if(err) throw err;
        console.log(result)
        res.send(result);
    })
})
//请求题目答案
router.get("/proanswer",(req,res)=>{
    pool.query(`SELECT p_id,p_answer,p_why FROM problem WHERE e_id=${req.query.eid}`,(err,result)=>{
        if(err) throw err;
        let arr=[];
        for(let key of result){
            arr[arr.length]={
                p_id:key.p_id,
                p_answer:key.p_answer,
                p_right:`${req.query[key.p_id]}`==key.p_answer?1:0,
                p_why:key.p_why
            }
        }
        res.writeHead(200,{
            "Access-Control-Allow-Origin":"*",
            "Content-Type":"Applaction/Json;Charset='UTF-8'"
        })
        res.write(JSON.stringify(arr));
        res.end();
    })
})
module.exports=router;