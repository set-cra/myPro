#设置服务器编码
SET NAMES UTF8;

#检测数据库是否存在,存在则删除
DROP DATABASE IF EXISTS OnlineEdu;

#创建数据库
CREATE DATABASE OnlineEdu CHARSET=UTF8;

#使用数据库
USE OnlineEdu;

#创建用户数据表
CREATE TABLE user(
    u_id INT PRIMARY KEY AUTO_INCREMENT,#用户编号,自增
    u_name VARCHAR(12) NOT NULL UNIQUE,#用户登录名
    u_pwd VARCHAR(16) NOT NULL#用户登录密码
);

#创建课程类型表
CREATE TABLE class_type(
    ct_id INT PRIMARY KEY AUTO_INCREMENT,#课程类型编号,自增
    ct_name VARCHAR(12) NOT NULL#课程类型名称
);

#创建课程数据表
CREATE TABLE class(
    c_id INT PRIMARY KEY AUTO_INCREMENT,#课程编号,自增
    c_name VARCHAR(25) NOT NULL,#课程名字
    c_img VARCHAR(500) NOT NULL,#课程配图
    c_detail VARCHAR(500),#课程细节
    c_price DECIMAL(6,2),#课程价格
    t_id INT,#授课教师编号
    c_tid INT,#课程类型
    is_VIP TINYINT,#是否为会员课程
    degree TINYINT#难度1,2,3,4,5共五级难度
);

#创建课程教师列表
CREATE TABLE teacher(
    t_id INT PRIMARY KEY AUTO_INCREMENT,#授课教师编号
    t_name VARCHAR(6),#教师姓名
    t_img VARCHAR(200),#教师头像
    t_job VARCHAR(50),#教师职位
    t_detail varchar(500)#教师简介
);

#学生购买和评价课程(购买后才可评价)
CREATE TABLE buy_class(
    c_id INT,#购买的课程编号
    u_id INT,#购买课程的用户编号
    score TINYINT,#1~5评分
    comment VARCHAR(500) #用户评论
);

#收藏
CREATE TABLE collect(
    c_id INT,#收藏的课程编号
    u_id INT#收藏课程的用户编号
);

#新闻表格
CREATE TABLE news(
    n_id INT PRIMARY KEY AUTO_INCREMENT,#新闻编号
    n_title VARCHAR(25),#新闻标题
    n_img VARCHAR(100),#新闻配图
    n_detail VARCHAR(10000),#新闻详情
    n_date BIGINT#内容时间
);

#考题类型
CREATE TABLE exam(
    e_id INT PRIMARY KEY AUTO_INCREMENT,#试题类型编号
    e_title VARCHAR(25),#考题标题
    e_img VARCHAR(100)#考题配图
);

#考题
CREATE TABLE problem(
    e_id INT,#考题所属类型
    p_id INT PRIMARY KEY AUTO_INCREMENT,#考题编号
    p_content VARCHAR(500),#考题题目
    p_options VARCHAR(1000),#题目选项数组
    is_multi TINYINT,#是否为多选
    p_answer VARCHAR(50),#正确答案的下标
    p_why VARCHAR(1000)#题目解析
);

#创建管理员数据表
CREATE TABLE adminer(
    ad_id INT PRIMARY KEY AUTO_INCREMENT,#管理员编号
    ad_name VARCHAR(12),#管理员账号
    ad_pass VARCHAR(32),#管理员密码
    ad_power TINYINT #管理员权限1-最高,2-不能授权,3-不能操作用户删除,4-只能操作网页数据,5-只能操作用户密码重置
);

#管理员数据录入
INSERT INTO adminer VALUES(NULL,"adminFirst",md5("qfonlineadmin2019530"),1);

#课程类型插入
#JAVA类
INSERT INTO class_type VALUES(NULL,"JAVA");
#UI类
INSERT INTO class_type VALUES(NULL,"商业插画");
#移动开发/游戏
INSERT INTO class_type VALUES(NULL,"移动开发/游戏");
#营销/产品/运营
INSERT INTO class_type VALUES(NULL,"营销/产品/运营");
#数字艺术
INSERT INTO class_type VALUES(NULL,"数字艺术");

#课程信息插入
#java基础内容
INSERT  INTO class VALUES (NULL,"JAVA基础入门","../img/product/java_base/3F8E6CFD23254E0B84934B1D25C9A505.png","../img/product/java_base/2F79BC5BD536490FB2F4DCDF272AFC55.png",199.00,1,1,0,1);
#Java项目实战课-双色球程序
INSERT  INTO class VALUES (NULL,"Java项目实战课--双色球程序","../img/product/java_base/22587A1C43064414A07C6A089825944D.png","../img/product/java_base/4D66C58C436C48A89498477589F410DD.png",59.00,2,1,0,3);
#Java项目实战课-从编程角度看丝血反杀
INSERT  INTO class VALUES (NULL,"Java项目实战课-从编程角度看丝血反杀","../img/product/java_base/EB8E33BD44CF4A4BAAE26E5C3AF380F5.png","../img/product/java_base/F92CD8A5B8B84F52A9567D1236EFF658.jpg",199.00,3,1,0,4);
#Java基础实战 | 对接图灵机器人
INSERT  INTO class VALUES (NULL,"Java基础实战 | 对接图灵机器人","../img/product/java_base/768FADF5B6FD4E9B91305027F99A9197.png","../img/product/java_base/EE10F34F9B4A421F90DE77FF1B552027.png",199.00,4,1,1,2);
#Java小白入门系列课
INSERT  INTO class VALUES (NULL,"Java小白入门系列课","../img/product/java_base/0B694145A17544FC927675F603326B8F.png","../img/product/java_base/03F89F3803B744CB94BB9F331CFD86C7.png",69.00,5,1,0,1);
#JAVA入门之核心
INSERT  INTO class VALUES (NULL,"JAVA入门之核心","../img/product/java_base/3F8E6CFD23254E0B84934B1D25C9A505.png","../img/product/java_base/2F79BC5BD536490FB2F4DCDF272AFC55.png",59.00,6,1,0,2);
#Java培优—门店管理系统
INSERT  INTO class VALUES (NULL,"Java培优—门店管理系统","../img/product/java_base/24CD7D8F51AA42F4ACD13D4834EF67EA.png","../img/product/java_base/AD0B09822A3A48F4B62B95D17812167D.png",199.00,1,1,1,4);

#UI类
#商业插画零基础手绘教程内容
INSERT  INTO class VALUES (NULL,"商业插画零基础手绘教程","../img/product/UI/8D4204DFC45C40BCBF68150E442E1D18.png","../img/product/UI/box5_e1.jpg",599.00,1,2,0,3);
#在线商业插画内容
INSERT  INTO class VALUES (NULL,"在线商业插画","../img/product/UI/191D3A8F59074764920BF9641D47B61C.png","../img/product/UI/1C6EEA889F994B83B45089F95B08E844.jpg",9800.00,2,2,0,2);
#十二星座插画内容
INSERT  INTO class VALUES (NULL,"商业插画-十二星座Q版形象手绘体验课","../img/product/UI/658ADAB82B9A49859AE1E3EE3B7595B7.jpg","../img/product/UI/7F543810D4CF4EF79A9D2DFA3D40EE5E.jpg",0.00,3,2,1,3);
#在线游戏原画内容
INSERT  INTO class VALUES (NULL,"在线游戏原画","../img/product/UI/9487AD18F1B045049C75C722B2C86D01.jpg","../img/product/IU/E25D63F1DDDB46FFAA925E0546CFF2AF.jpg",9800.00,4,2,0,1);
#ps技能内容
INSERT  INTO class VALUES (NULL,"快速学会PS的2种操作8大技能","../img/product/UI/E80C4F977E5C4FA79121D757C41D9689.png","../img/product/UI/E20C676A127941A2ABBF5BBA87CCCB34.jpg",59.00,5,2,0,2);

#移动开发/游戏
#游戏原画-游戏技能图标-中级
INSERT  INTO class VALUES (NULL,"游戏原画-游戏技能图标-中级","../img/product/MT/726ACB58649C41E0B925956859EE3FFC.jpg","../img/product/MT/916589141B394683B4442879063A0B1F.jpg",0.00,3,3,1,3);
#游戏原画-Q版人物造型-高级
INSERT  INTO class VALUES (NULL,"游戏原画-Q版人物造型-高级","../img/product/MT/351F5E6E1A904B309739D23E6DFDFEA6.jpg","../img/product/MT/1B61A18B5ADE4FC5B862F215D9F28150.jpg",0.00,4,3,1,4);
#游戏原画-游戏图标-初级
INSERT  INTO class VALUES (NULL,"游戏原画-游戏图标-初级","../img/product/MT/AF34ED73349D4CB8A9E474CEE2E99FB0.jpg","../img/product/MT/AF34ED73349D4CB8A9E474CEE2E99FB0.jpg",0.00,1,3,1,2);
#Java快速进阶架构师
INSERT  INTO class VALUES (NULL,"Java快速进阶架构师","../img/product/MT/3B7B5A65CA2040EFA88CDB3789632AB0.png","../img/product/MT/3A3388D9A322498C9DE8053CAD44FBEB.png",9800.00,6,3,1,3);
#Java高手框架进阶及高级并发进阶
INSERT  INTO class VALUES (NULL,"Java高手框架进阶及高级并发进阶","../img/product/MT/07A0BB16D26545079CFF40A96DDE9FCB.jpg","../img/product/MT/AFA6BF02BDC0474EB850C5F6579D35D9.png",6000.00,4,3,1,4);

#营销/产品/运营
#网络营销
INSERT  INTO class VALUES (NULL,"网络营销","../img/product/online/C15B0CA9F2F94944A87F831BA58B1244.png","../img/product/online/7AA9A0E998CE43728C17587023CECD15.png",399.00,1,4,0,1);
#新媒体运营
INSERT  INTO class VALUES (NULL,"新媒体运营","../img/product/online/32C15FFF48E740D7AADFEDD4D9FB5E1F.png","../img/product/online/D093B2B4C4CD4ECA911E5194753F6BD4.png",59.00,3,4,0,2);
#PS蒙版合成特效
INSERT  INTO class VALUES (NULL,"PS蒙版合成特效","../img/product/online/EE20F4D9581345688C7B8B6D8E5E571D.png","../img/product/online/9AA238A020224BF0AD5711204A81E978.png",59.00,3,4,0,3);
#SEM低预算企业破局之道
INSERT  INTO class VALUES (NULL,"SEM低预算企业破局之道","../img/product/online/3BB5FAC43E3E4A718F2AD904F37DEB0E.png","../img/product/online/951241DF565C48A481AC8859E6A1CD3E.png",59.00,5,4,0,4);

#数字艺术
#GO语言精品课
INSERT  INTO class VALUES (NULL,"GO语言精品课","../img/product/digital/920404D685294D9A9CFC15522BE4C25F.jpg","../img/product/digital/B904EC03F985462F852C7B98870F3510.jpg",59.00,5,3,1,1);
#数字货币精品课
INSERT  INTO class VALUES (NULL,"数字货币精品课","../img/product/digital/58B04B6E47E74C6EB12BC653896BCA3F.jpg","../img/product/digital/AFD72AD0E956413F8553D29E04BCC9D7.jpg",59.00,5,5,1,3);
#资深设计总监教你掌握高效率的设计思维
INSERT  INTO class VALUES (NULL,"资深设计总监教你掌握高效率的设计思维","../img/product/digital/A47D33EDB10D49178B7C736F781F38BC.png","../img/product/digital/35EB4D7821A743508AE24A23BD44F896.png",59.00,5,5,1,2);

#插入评价数据
INSERT INTO buy_class VALUES (1,0,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (2,0,5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (3,0,4.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (4,0,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (5,0,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (6,0,2.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (7,0,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (8,0,0,"balabalabalabalaba");
INSERT INTO buy_class VALUES (9,0,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (10,0,2.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (11,0,1.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (12,0,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (1,1,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (2,1,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (3,1,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (5,1,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (6,1,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (7,1,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (8,1,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (9,1,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (10,1,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (1,2,0.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (2,2,1.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (3,2,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (4,2,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (5,2,1.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (7,2,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (8,2,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (9,2,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (10,2,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (1,3,2.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (2,3,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (3,3,1.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (4,3,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (6,3,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (7,3,0.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (8,4,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (9,5,1.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (10,6,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (12,6,1.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (11,6,1,"balabalabalabalaba");
INSERT INTO buy_class VALUES (13,1,2,"balabalabalabalaba");
INSERT INTO buy_class VALUES (14,2,3,"balabalabalabalaba");
INSERT INTO buy_class VALUES (15,3,4,"balabalabalabalaba");
INSERT INTO buy_class VALUES (16,4,5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (17,6,4.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (18,6,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (19,5,2.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (20,3,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (21,2,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (22,4,1.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (23,1,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (24,2,4.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (16,1,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (22,2,4.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (24,3,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (16,4,1.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (15,6,2.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (18,6,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (19,5,5.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (12,3,1.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (21,2,2.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (15,4,3.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (16,1,1.5,"balabalabalabalaba");
INSERT INTO buy_class VALUES (21,2,4.5,"balabalabalabalaba");

#插入教师数据
#瞎编老师1数据
INSERT INTO teacher VALUES (NULL,"徐海建","../img/teacher/xu.png","广东深圳/项目经理","在正规的外资快消企业，市场营销的架构都是按照科特勒体系搭建的，我把课程笔记做成了“实战应用笔记”，简直是为工作量身定制了一本红宝书，让我入职阶段快速的适应了500强公司。");
#瞎编老师2数据
INSERT INTO teacher VALUES (NULL,"达利园","../img/teacher/da.png","爱丽丝吉他/项目总监","在正规的外资快消企业，市场营销的架构都是按照科特勒体系搭建的，我把课程笔记做成了“实战应用笔记”，简直是为工作量身定制了一本红宝书，让我入职阶段快速的适应了500强公司。");
#瞎编老师3数据
INSERT INTO teacher VALUES (NULL,"宋千情","../img/teacher/song.png","杭州宋城/项目经理","在正规的外资快消企业，市场营销的架构都是按照科特勒体系搭建的，我把课程笔记做成了“实战应用笔记”，简直是为工作量身定制了一本红宝书，让我入职阶段快速的适应了500强公司。");
#瞎编老师4数据
INSERT INTO teacher VALUES (NULL,"吴鞍山","../img/teacher/wu.png","安徽黄山/项目经理","在正规的外资快消企业，市场营销的架构都是按照科特勒体系搭建的，我把课程笔记做成了“实战应用笔记”，简直是为工作量身定制了一本红宝书，让我入职阶段快速的适应了500强公司。");
#瞎编老师5数据
INSERT INTO teacher VALUES (NULL,"周海媚","../img/teacher/zhou.png","广东深圳/产品经理","在正规的外资快消企业，市场营销的架构都是按照科特勒体系搭建的，我把课程笔记做成了“实战应用笔记”，简直是为工作量身定制了一本红宝书，让我入职阶段快速的适应了500强公司。");
#瞎编老师6数据
INSERT INTO teacher VALUES (NULL,"朱建国","../img/teacher/xu.png","上海/产品经理","在正规的外资快消企业，市场营销的架构都是按照科特勒体系搭建的，我把课程笔记做成了“实战应用笔记”，简直是为工作量身定制了一本红宝书，让我入职阶段快速的适应了500强公司。");

#插入新闻1
INSERT INTO news VALUES (NULL,"在线教育烧钱模式盈利难，线下实体店为何突围了？","../img/news/new1.jpg","<p>就在两三年之前，我们突然发现其实服务业的公司很多还没有线上化，其中一个最大的领域就是教育行业。我们知道服务业毛利是非常高的，但是服务业也有一个很大的问题就是做不大，主要是受制于管理半径、管理效率这两个问题，但互联网其实很好解决了这个问题。</p>
<p>对教育行业来说，互联网技术对教育行业的改变是非常深刻的。它提升了管理效率、扩大了管理半径，使这样一个原来传统上不能够做得很大的公司，有可能做成上千亿市值的公司，我们近两年布局了能够通过一些新技术来提升这个行业管理效率，扩大管理半径的公司。</p>
<p>这是我们一个大的投资逻辑，很多项目都是在这个逻辑下投出来的。</p>
<p>蔡翔：从好未来角度来说，我们认为教育是一个非常宽的赛道，它的特点在于各个垂直领域都会出现头部的领头羊，所以在垂直领域里面去找能够成为第一的公司，是我们非常在意的一点。并且，我们希望大家能够形成很好的协同和协作，这是一种很典型的上市企业投资思路。</p>
<p>另外一方面，我们会关注横向大的机会点或者说横向的逻辑架构，比如在教育领域里我们会看中三个线条：
第一，触达。任何生意要能够形成真正完整的付费流程，触达是第一位。好未来线下开培训班实现的是对百万级学生的触达，线上通过互联网的形态是对百万甚至千万用户的触达，这是我们非常看好一种新模式。虽然我们自己的学而思网校也已经有200万的学生，跟线下触达量相近，但我相信市场上还会有非常牛的公司。</p>
<p>第二，内容。教育离不开内容这个内核。那些通过长期的积累、独特的视角做出非常好的内容形态的公司，我们也愿意进行投资。</p>
<p>第三，数据。有了触达和推送过去的内容后，还要能形成闭环。对数据这端我们非常在意，互联网只是形成了当前教育改造的第一步，但从长远来看，能把教育品质做好、能够真正做到因材施教需要有大量数据回馈而且做到精准分析和匹配。所以，对于数据获取端、对于教育数据的分析能力或者说形成完整的数据闭环，这种商业模式的公司也是我们关注的重点。</p>
<p>总结一下，从大的投资逻辑来讲，触达、内容和数据是我们非常看好的环节。</p>
<p>此外，我觉得对于教育行业来说，有些泡沫是有价值的。教育产业是一个大产业，中国教育产业做得相当不成熟，但如果以资本力量快速推进了这个产业本身发展，也是好事情。但确实需要清醒的是，资本求快，教育求稳，教育这件事情本身是一个慢活，投资人要给予更多的信心和时间，让教育公司做进一步成长。</p>",1557921441858);
#插入新闻2
INSERT INTO news VALUES (NULL,"浙江大学发明可以秒变止血救生衣的T恤","../img/news/34358-20190515193123374-1445312297.jpg","<p>　　血液是生命之源，失血过多是意外创伤致死的首要原因。据统计，全球每年有 190 万人死于失血过多。因此，在事发第一时间对患者的出血进行有效控制，是争取治疗时间、挽救生命的关键。当医疗救援到来前，常见的急救方式就是用毛巾、衣服等捂住伤口，但这样的止血效果往往是&ldquo;螳臂当车&rdquo;。</p>
<p>　　为了解决紧急救生止血的问题，浙江大学化学系范杰教授课题组采用原位微载技术将介孔单晶菱沸石结合到棉纤维表面，制备了一种柔性沸石棉纤维复合物，该止血材料具备高效的止血性能和可靠的安全性。</p>
<p>　　近日，这项研究被国际知名期刊《自然&middot;通讯》在线发表。论文第一作者为浙江大学化学系博士生余丽莎，通讯作者为浙江大学化学系范杰教授、浙江工业大学化工学院朱艺涵教授。</p>
<p>　　大量研究和应用表明，在重度出血情况下，沸石类的无机止血材料是最有效的，因此，美国急救医学技术委员会推荐沸石止血剂作为院前急救的必要手段。&ldquo;我们长期从事沸石止血方面的研究，原有的沸石止血产品具有明显的弊端，&rdquo;范杰介绍。国外使用的A型沸石止血剂在战争中拯救了上千名士兵的生命，但该产品在使用过程中遇水或血液会放出大量的热，伤口局部温度高达 90℃以上，导致皮肤灼伤和影响伤口愈合，这是困扰该国多年的难题。</p>
<p>　　范杰教授对沸石的组成和表面结构进行改造与升级，得到了止血效果优良且放热温和（伤口温度小于 45℃）的沸石止血剂，该止血剂在今年年初获得了 II 类医疗器械注册证和生产许可证，即将面市。</p>
<p>　　但是，由于现有的沸石止血剂是坚硬的无机粉体材料，容易黏附在伤口，不利于伤口清创，因此，如何将坚硬的无机粉体止血剂变成柔性、安全、便捷止血材料，成为了新的挑战。棉纤维吸水性好，成本低，可通过编制成适用于不同伤口形状的止血织物，因此棉纤维是沸石生长理想的载体。此外，课题组发现，在微孔沸石中引入介孔，增加了沸石的孔径，中断沸石的微孔骨架并减少的扩散长度，有利于促进血液中水分子的更快吸收和扩散。</p>
<p>　　沿着这样的设计思路，经过两年的探索，范杰团队由此开发了一种原位微载技术，将介孔菱沸石生长到棉纤维表面，并使得棉纤维与沸石通过化学键紧密结合。该材料完美地保留了沸石的物理化学性质和稳定性，同时通过中断骨架来产生介孔，从而大大增强物质的吸附，更有利于止血。该止血材料的外观与手感与普通的纤维几乎没有区别，具有良好的柔软性，并且沸石与棉纤维结合非常牢固。</p>
<p>　　有着救命神器之称的作战纱布，是一种浸渍高岭土的无机止血材料，但这种纱布遇水或血液后，活性成分高岭土很容易脱落，存在较大的安全隐患。范教授团队研发的&ldquo;紧密结合的&rdquo;沸石纤维复合物不怕水洗，也不怕水冲，甚至超声波震荡半小时也震不下来。</p>
<p>　　不仅如此，在非常挑战性的猪颈动脉致死模型试验中，作战纱布在伤口按压 10 分钟仍然血流不止，而沸石纤维复合物纱布在伤口按压 5 分钟就已经成功止血，使用过程中没有放热效应。在造成人员受伤大出血的突发事故现场往往缺乏现成的有效止血材料。范杰认为&ldquo;把沸石纤维做成止血衣&lsquo;穿&rsquo;在身上是最保险的救援方式，实现了随时随地的紧急止血救援。</p>
<p>　　据范杰介绍，紧急止血救生衣有望于今年 8 月份问世。此外，还可以制造止血毛巾、止血纱布等多种产品，成为户外运动、极限运动、赛车等特殊人群的保护装备，也可以作为急救装备，在战争、交通、地震等意外事故中发挥作用。</p>
<p>　　文章链接：https://www.nature.com/articles/s41467-019-09849-9</p>",1557919860000);
#插入新闻3
INSERT INTO news VALUES (NULL,"下沉，下沉！教育培训行业的中场战事","../img/news/34358-20190513142429317-2068543256.png",
"<p>4 月 26 日，在精锐收购巨人后的第一次新闻发布会上，张熙高调宣布“城市合伙人”计划。这个策略的核心是：招募二三线城市愿意做教育行业的人一起开办校区，精锐和巨人将从教学、招生、运营、技术四个方面提供支持。</p>
<p>无独有偶。</p>
<p>八天前，高思宣布获得 1.4 亿美元D轮融资，并表示这笔融资全部用于 B2C 战略的探索。创始人须佶成表示：“不会再在北京以外的地方开设学校”，而是用 OMO 模式去覆盖全国 90% 以上的县市。</p>
<p>一个是新的组织结构，一个是新的模式，看似不同的选择，却在瞄准同一方战场——三线及以下城市。</p>
<p>他们用不同的策略和方式，尝试解决一个问题：怎样才能快速在这个蓝海、却又十分分散的市场中获得自己的“领地”？事实上，这场下沉市场争夺战早已在教培行业全面打响。</p>
<p>2014、2015 年开始，新东方、好未来就率先开始了对下沉市场的探索，只是两者选择了不同的侧重点。
<p>51Talk 在其发布的《全国青少儿在线英语学习行为报告》中提到，2017 年 51Talk 非一线城市的新付费学员是一线城市的 1.3 倍，且该数字是 2 年前的 4.7 倍。</p>
<p>当在线流量花费迅速走高之时，还有一干在下沉市场摸索良久的在线品牌正用自己的方式去探索流量，比如今年宣布获得 1 亿元融资的阿卡索、久趣、Proud Kids。</p>
<p>这种迫切感或许可以用湃洞传媒 CEO 沈帅波那句被刷屏的玩笑话来形容：“三四线的同胞们知道一线的人天天在琢磨怎么收割自己吗？”</p>
<p>下沉，正成为更多企业搏命逆袭的核心。</p>
<p>下沉！下沉！</p>
<p>2015 年，刚结束一场紧急会议的俞敏洪宣布：“新东方将大力开拓二三线城市市场。”当时俞敏洪初步拟定了三种方式，其中有两个对当时的新东方而言是颠覆性的。</p>
<p>第一、继续在规模较大的地级市开设直营校区；第二、对不满足开直营校区的小城市采用投资控股、收购的方式和当地有影响力的机构合作；第三、在更小的城市和县城里开设免费学习中心，为学生提供免费的在线课程，将此作为新东方产品的流量入口。</p>
<p>尔后的三年，新东方选择双向出击：一方面单独成立了新的全资子公司双师东方，用线下双师模式开设新东方双师学校在中小城市发展；另一方面，新东方在线成立子公司东方优播，用在线单师模式做并线突围。</p>
<p>而好未来则选择了另一种思路。</p>
<p>在 2014 年探索成熟了线下双师模式之后，好未来一边开设线下双师学校，一边思考用新的模式走进这片广阔的市场：除了新开分校，是否还有别的打法？比如在线、又比如 To B？</p>
<p>与新东方的大范围推进不同，好未来起初只在小范围内试行双师，有意突出其教学质量。</p>
<p>2018 年，好未来正式推出 To B 业务“未来魔法校”，和各地的地方机构合作，输出产品、课程、技术。同时，学而思在线的探索更加基于本地化。在 2018 年的 GES 大会上，未来魔法校方面给出的数据显示，其在一年间总计授课 1690 次，覆盖学生 24683 名。</p>
<p>好未来创始人兼 CEO 张邦鑫在“魔法年会”上表示，教育行业将形成线下、线上、AI 智能三代机构并存、三股浪潮叠加的趋势，未来几年会出现一批依托双师平台成长的机构。</p>
<p>双师打法，算是较早基于B端进行下沉探索的模式，也符合小城市缺乏优质教师的资源困境。</p>
<p>在 To B 这条线上，这几年高思不断迭代爱学习平台。</p>
<p>2015 年，高思已经通过 To B 产品“爱学习”抢先触达中小机构，在做双师课堂时，又选择了先从深度使用“爱学习”系统的机构中筛选出初期双师课堂的合作伙伴，随后几年，高思不断围绕双师场景、语音等方面进行多维升级。温鑫曾对多知网表示，2019 年，五六线城市双师教室会达到 5000-8000 间，而爱学习单品双师会达到 5000 间。</p>
<p>可以说，线下是最先开始下沉之战的阵队；而双师模式是最早切入低线市场，解决师资问题的利器。</p>
<p>但是，开学校依然受限于效率和产能。</p>
<p>故此，后来者精锐则希望通过借助组织关系的改革，能让这突围的速度来得更快。精锐和巨人共同设立 50 亿元教育基金，以不低于 10 倍市盈率的估值收购、并购校区，城市合伙人可自由选择是否参与回购。</p>
<p>加速二三线市场的布局规划，已成为精锐未来三年的核心战略。</p>
<p>在公考赛道，据中公教育发布的 2018 财年年报显示，中公教育直营分支机构总数为 701 个，比 2017 年的 551 个净增长 150 个，增幅为 27.22%。目前，中公教育已建立覆盖 319 个地级市的 701 个学习中心网点。未来几年，县城将成为其渠道下沉的新重点。</p>
<p>随着时间推移，线上品牌也成为突围低线城市的生力军。</p>
<p>根据 QuestMobile 数据，截止 2018 年 6 月，我国移动互联网用户的城市层级分布为一二线城市占比最多，合计为 45.5%，三四线城市及以下占比 54.5%。按照 11.07 亿的 MAU 来计算，三四线及以下城市的月活大致为 6 亿人，市场空间广大。</p>
<p>如同有人说“流量下沉是技术普及对弱势群体的赋权”，三四线城市对于在线教育的需求，也在这几年被动或主动地快速增长着。</p>
<p>在在线阵营中，定位做更经济的菲教品牌 51Talk 自然表现得更加迫切。</p>
<p>2019 年初，51Talk 不断聚焦“一带一路”战略，促进中菲教育优质资源互补，并宣布将在五年内引进 10 万优质菲教资源。据 51Talk 公布的数据显示，在 2018 年第四季度，每 4 个首单客户里就有 3 个来自二、三线城市。</p>
<p>同样迫切的，还有今年累计融资几近两亿元的阿卡索。阿卡索自 2011 年初步探索在线教育的模式时，直接采取错位打法向三四线城市下沉。</p>
<p>阿卡索 CEO 王志彬在接受多知网采访时曾表示，阿卡索并不刻意争取消费金字塔顶端的用户。而是从社会需求出发，走“低价高质”教育产品的经营模式。“阿卡索的课单价最低 13-15 元/节/25 分钟，相对于 LV，阿卡索效仿快时尚品牌 ZARA 的商业模式，要做在线教育的 ZARA。”</p>
<p>就连三四线市场需求并没有那么旺盛的自考教育也不例外，有业内人士透露，尚德内部也在讨论是否将其作为新的战略目标进行下沉。</p>
<p>一二线城市流量红利捉襟见肘，猛攻三四线势在必行……</p>
<p>如同 2019 年初腾讯·企鹅智库在《寻找中国互联网的“未饱和”2019-2020 中国互联网趋势报告》中开篇所提及的那样：</p>
<p>“有些事情向上，有些事情向下。有些事情正在饱和，有些事情正在生长。”</p>
<p>千帆竞技：下沉首要“接地气”</p>
<p>三四线城市的市场策略，显然需要更接地气。</p>
<p>“养猪种树铺马路，发财致富靠百度”，“生活要想好，赶紧上淘宝”，如果不是亲眼看到，或许你很难相信这是 BAT 其中之二的刷墙广告。</p>",1557728700000);
#插入新闻4
INSERT INTO news VALUES (NULL,"微软成功实现文化和战略转型 纳德拉有三大绝招","../img/news/34358-20190513133247875-1698481296.jpg","<p>腾讯科技讯，5 月 13 日消息，据外媒报道，微软最新公布的季度业绩几乎超过了所有业绩指标。该公司在第三财季财报中宣称，营收为 306 亿美元，净利润 88 亿美元，每股收益 1.14 美元，较 2018 年同期的营收 268 亿美元、净利润 74 亿美元以及每股收益 0.95 美元相比，均有大幅提高，微软的云计算业务推动了强劲的业绩增长。</p>
　　<p>这些数字进一步证明，微软代表了近代历史上最引人注目的扭亏为盈故事之一。2014 年初，当萨蒂亚·纳德拉(Satya Nadella)从史蒂夫·鲍尔默(Steve Ballmer)手中接过这家科技巨头时，微软即将完成对诺基亚设备和服务部门 70 亿美元的收购，以提振其黯淡的 Windows Phone 业务。当时，微软的 Windows 8 操作系统也受到了广泛的批评。</p>
　　<p>微软无法从苹果手中夺取智能手机市场，无法从亚马逊手中夺取云计算市场，也无法从谷歌手中夺取搜索市场。当微软还在赚取超过收入的时候，它的股价在过去十年的大部分时间里却始终处于停滞状态。简而言之，2014 年 1 月，当纳德拉成为首席执行官时，这家科技巨头还处于昔日辉煌的阴影中。尽管任命了新的首席执行官，但许多人认为，其最美好的日子已经一去不复返了。</p>
　　<p>然而仅仅过去 5 年，微软就在纳德拉的领导下发生了令人瞩目的转变。微软股价上涨了两倍，一度超过 1 万亿美元的市值，并恢复了世界上最富有上市公司的地位，排在亚马逊和苹果之上。</p>
　　<p>那么，纳德拉到底是怎么实现这种转变的？这可以追溯到他作为微软首席执行官给员工发出的第一封电子邮件。当时，纳德拉没有把重点放在过去，而是在展望未来，特别提到云计算和移动业务对微软增长的重要性。至关重要的是，他还写道：“我们的行业不尊重传统，它只尊重创新。”纳德拉并不依赖微软 90 年代鼎盛时期的辉煌来追求增长。</p>
　　<p>把他的话付诸行动，纳德拉已经实现了微软的文化和战略转型，这其间他有三大绝招：</p>
　　<h3>1. 创造协作文化和职场环境</h3>
　　<p>在鲍尔默辞去首席执行官一职后，微软移除了过时且适得其反的管理结构，这些结构在这个笨重的组织中随处可见。在 2013 年推出该结构之前，微软的管理人员被鼓励分配一定数量的负面绩效考核。换句话说，管理者被迫给员工负面评价，即使他们不应得到负面评价。</p>
　　<p>而纳德拉则致力于创造更具协作性的工作环境，在管理结构变化的基础上再接再厉，微软每年一度的“世界上最大私人黑客马拉松”活动的创建就证明了这一点。黑客马拉松鼓励来自不同业务领域的员工在项目上合作。在黑客马拉松之前，单独的 Windows 办公室被孤立起来，并不断地相互竞争。黑客马拉松帮助创建了一种快速移动的协作组织，以在当今“数字优先”的世界中竞争。</p>
　　<h3>2. 打造积极合作伙伴战略<h3>
　　<p>在 2016 年举行的 WSJD Live 大会上，纳德拉承认：“我们显然错过了手机崛起的良机，这是毫无疑问的。”他承认，微软最好的选择不是用 Windows Phone 与苹果和三星等公司的旗舰产品竞争。从那时起，微软就开始努力将 Windows 拥有的应用程序移植到安卓和 iOS 系统上。值得注意的是，纳德拉还放弃了微软针对竞争对手的激进战略（鲍尔默曾称竞争操作系统 Linux 为“癌症”)，并欢迎与合作伙伴合作。</p>
　　<p>这种积极的合作伙伴战略是最成熟的数字组织所采取的一种思想。它基于这样一种理解，即快速发展的专业合作伙伴能够针对规模更大的传统公司可能难以应对的特定挑战，并提供相应的专业知识和创新。机构和咨询公司通常被雇佣作为外包价值链的一部分或完成独立项目的手段，但合作应该超越这一点。</p>
　　<p>例如，纳德拉在 Windows Store 中列出了 Linux 发行版，以使开发人员能够访问。2017 年，微软成为世界上最大的开放源代码贡献者。通过对引进新伙伴持开放态度，微软已经确立了自己在这一领域最大参与者的地位。此外，微软还以 75 亿美元收购了开源平台 GitHub，并在此期间击败了竞争对手谷歌。</p>
　　<h3>3. 押更少但更大的赌注<h3>
　　<p>通过投资云计算和人工智能，纳德拉在未来技术方面加倍押注。2017 年，微软推出了独立 AI 部门，拥有 5000 多名计算机科学家和软件工程师。该公司还推出了智能云（Intelligent Cloud），其中包括服务器和 Azure 等产品。在为大企业的云计算需求提供服务方面，它现在是亚马逊 AWS 的最大竞争对手。事实上，微软现在已经超过了亚马逊，并且仍然是世界上最大的商业云公司。</p>",1557725520000);

#插入考试数据
#插入java考试
INSERT INTO exam VALUES (NULL ,"java考试","../img/exam/u=1782181891,1073794494&fm=26&gp=0.jpg");
#插入c++考试
INSERT INTO exam VALUES (NULL ,"c++考试","../img/exam/u=3937144425,1129498947&fm=11&gp=0.jpg");
#插入js考试
INSERT INTO exam VALUES (NULL ,"javaScript考试","../img/exam/download.jpg");
#网络运营
INSERT INTO exam VALUES (NULL ,"网络运营考试","../img/exam/u=3354991782,3848189275&fm=26&gp=0.jpg");
#电子商务
INSERT INTO exam VALUES (NULL ,"电子商务考试","../img/exam/u=1786607667,3563028485&fm=26&gp=0.jpg");

#插入题目
#java试题
INSERT INTO problem VALUES (1,NULL,"在java中，由java编译器自动导入，而无需在程序中用import导入的包是","['java.applet','java.lang','java.util',' java.awt']",0,'[2]','无');
INSERT INTO problem VALUES (1,NULL,"下列方法中可以用来创建一个新线程的是","['实现java.lang.Runnable接口并重写run()方法','实现java.lang.Runnable接口并重写start()方法','实现java.lang.Thread类并实现start()方法',' 继承java.lang.Thread类并重写run()方法']",1,'[1,4]','Java中创建线程主要有三种方式：
一、继承Thread类创建线程类
（1）定义Thread类的子类，并重写该类的run方法，该run方法的方法体就代表了线程要完成的任务。因此把run()方法称为执行体。
（2）创建Thread子类的实例，即创建了线程对象。
（3）调用线程对象的start()方法来启动该线程。
二、通过Runnable接口创建线程类
（1）定义runnable接口的实现类，并重写该接口的run()方法，该run()方法的方法体同样是该线程的线程执行体。
（2）创建 Runnable实现类的实例，并依此实例作为Thread的target来创建Thread对象，该Thread对象才是真正的线程对象。
（3）调用线程对象的start()方法来启动该线程。
三、通过Callable和Future创建线程
（1）创建Callable接口的实现类，并实现call()方法，该call()方法将作为线程执行体，并且有返回值。
（2）创建Callable实现类的实例，使用FutureTask类来包装Callable对象，该FutureTask对象封装了该Callable对象的call()方法的返回值。
（3）使用FutureTask对象作为Thread对象的target创建并启动新线程。
（4）调用FutureTask对象的get()方法来获得子线程执行结束后的返回值');
INSERT INTO problem VALUES (1,NULL,"下列代码中，讲引起一个编译错误的行是
1 public class Test{
2 int m,n;
3 public Test(){}
4 public Test(int a){m=a;}
5 public static void main(String args[]){
6 Test t1,t2;
7 int j,k;
8 j=0;k=0;
9 t1=new Test();
10 t2=new Test(j,k);
11 }
12}
","['第三行','第五行','第六行',' 第十行']",0,'[4]','无');
INSERT INTO problem VALUES (1,NULL,"Socket通信使用的底层协议是","['UDP协议','TCP/IP协议','FTP协议','TELNET协议']",0,'[2]','无');
INSERT INTO problem VALUES (1,NULL,"下列叙述中，正确的是","['java语言的标识符是区分小写的','源文件名与public类名可以不相同','源文件名其扩展为.jar','源文件中public类的数目不限']",0,'[4]','只能有一个main方法');
INSERT INTO problem VALUES (1,NULL,"下列属于合法的java标识符的是","['_cat','5books','+static','-3.14159']",0,'[1]','无');
INSERT INTO problem VALUES (1,NULL,"下面代码运行的结果是
Public class Demo{
Public int add(int a,int b){
Try{
Return a+b;
}catch(Exception e){
System.out.println(“Catch 语句块”);
}finally{
System.out.println(“finally 语句块”);}
}
Return 0;
}
Public static void main(String[] args){
Demo demo = new Demo();
System.out.println(“和是：”+demo.add(9,34));
}
","[' 编译异常','Finally语句块和是：43','和是：43finally语句块','Catch语句块和是：43']",0,'[2]','无');
INSERT INTO problem VALUES (1,NULL,"关于转发和重定向以下哪些说法是正确的","['转发url不会改变','重定向url不会改变','重定向保持request中存放参数','转发能保持request中存放参数']",1,'[1,4]','无');
INSERT INTO problem VALUES (1,NULL,"关于转发和重定向以下哪些说法是正确的","['POST ','GET ','两者都会']",0,'[2]','无');

#c++题目输入
INSERT INTO problem VALUES (2,NULL,"关于this指针的说法正确的是","['this指针必须显式说明','定义一个类后，this指针就指向该类 ','成员函数拥有this指针','静态成员函数拥有this指针']",0,'[3]','无');
INSERT INTO problem VALUES (2,NULL,"下列关于类和对象的说法中，正确的是","['编译器为每个类和类的对象分配内存','类的对象具有成员函数的副本 ','类的成员函数由类来调用 ','编译器为每个对象的数据成员分配内存']",0,'[4]','无');
INSERT INTO problem VALUES (2,NULL,"在类定义的外部，可以被访问的成员有","['所有类成员','private或protected的类成员 ','public的类成员','public或private的类成员']",0,'[3]','无');
INSERT INTO problem VALUES (2,NULL,"若有以下说明，则在类外使用对象objX成员的正确语句是
class X
{   int a;
    voidfun1();
  public:
    voidfun2();
};
X objX;","['objX.a=0; ','objX.fun1();  ','objX.fun2();','X::fun1();']",0,'[4]','无');
INSERT INTO problem VALUES (2,NULL,"下列类的定义中正确的是","['class a{int x=0;int y=1;} ','class b{intx=0;int y=1;};  ','class c{int x;inty;}  ','class d{int x;inty;};']",0,'[4]','无');

#javaScript考题
INSERT INTO problem VALUES (3,NULL,"以下关于 Array 数组对象的说法不正确的是","['对数组里数据的排序可以用 sort 函数，如果排序效果非预期，可以给 sort 函数加一个排序函数的参数','reverse 用于对数组数据的倒序排列','向数组的最后位置加一个新元素，可以用 pop 方法','unshift 方法用于向数组删除第一个元素']",1,"[3,4]","无");
INSERT INTO problem VALUES (3,NULL,"关于变量的命名规则，下列说法正确的是","['首字符必须是大写或小写的字母，下划线（_）或美元符（$）','除首字母的字符可以是字母，数字，下划线或美元符','变量名称不能是保留字','长度是任意的','区分大小写']",1,"[1,2,3,4,5]","无");
INSERT INTO problem VALUES (3,NULL,"var x = 1; function fn(n){n = n+1}; y = fn(x); y 的值为","['2','1','3','undefined']",0,"[4]","无");
INSERT INTO problem VALUES (3,NULL,'var n = "miao wei ke tang".indexOf("wei",6)；n的值为',"['-1','5','error','-10']",0,"[1]","无");

#网络运营
INSERT INTO problem VALUES (4,NULL,'"网络营销的本质',"['抓住顾客，满足顾客','网上拍卖','销售产品','建立网络渠道']",0,"[1]","无");

#电子商务
INSERT INTO problem VALUES (5,NULL,'下面哪儿些是常见的网络威胁',"['身份欺骗','篡改数据','信息暴露','拒绝服务']",1,"[1,2,3,4]","无");
