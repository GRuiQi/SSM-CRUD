[TOC]



## 项目简介

SSM_CRUD

Create 创建

Retrieve 查询

Update 更新

Delete 删除

功能点：

1. 分页
2. 数据校验  前端+JSR303后端校验
3. ajax
4. Rest风格的URI;使用HTTP协议请求方式的动词，来表示对资源的操作GET(查询)，POST(新增)，PUT(修改)，DELETE(删除)

技术点：

基础框架SSM

数据库 Mysql

前端框架  bootstrap 快速搭建简洁美观的界面

项目的依赖管理 Maven

分页 pagehelper

逆向工程 Mybatis Generator

## 基础环境搭建

• 1、创建一个maven工程
• 2、引入项目依赖的jar包
• spring
• springmvc
• mybatis
• 数据库连接池，驱动包
• 其他（jstl，servlet-api，junit）
• 3、引入bootstrap前端框架 https://v3.bootcss.com/getting-started/
• 4、编写ssm整合的关键配置文件
• web.xml，spring,springmvc,mybatis，使用mybatis的逆向工程生成对应的bean以
及mapper 

mybatis官方文档 https://mybatis.org/mybatis-3/

逆向工程使用文档：http://mybatis.org/generator/

• 5、测试mapper



## 功能实现



查询
• 1、访问index.jsp页面
• 2、index.jsp页面发送出查询员工列表请求
• 3、EmployeeController来接受请求，查出员工数据
• 4、来到list.jsp页面进行展示
• 5、pageHelper分页插件完成分页查询功能  https://github.com/pagehelper/Mybatis-PageHelper/blob/master/wikis/en/HowToUse.md

需要在mybatis配置文件中注册

##### 使用`PageInfo`的用法：

```
//获取第1页，10条内容，默认查询总数count
PageHelper.startPage(1, 10);
List<User> list = userMapper.selectAll();
//用PageInfo对结果进行包装
PageInfo page = new PageInfo(list);
//测试PageInfo全部属性
//PageInfo包含了非常全面的分页属性
assertEquals(1, page.getPageNum());
assertEquals(10, page.getPageSize());
assertEquals(1, page.getStartRow());
assertEquals(10, page.getEndRow());
assertEquals(183, page.getTotal());
assertEquals(19, page.getPages());
assertEquals(1, page.getFirstPage());
assertEquals(8, page.getLastPage());
assertEquals(true, page.isFirstPage());
assertEquals(false, page.isLastPage());
assertEquals(false, page.isHasPreviousPage());
assertEquals(true, page.isHasNextPage());
```



• URI：/emps

http://t.cn/A64pr5Zc?m=4548439079395321&u=7033386319

http://t.cn/A64bnDBW?m=4544296327585915&u=7033386319



查询Ajax

1. index.jsp页面直接发送ajax请求进行员工分页数据的查询

2. 服务器将查出的数据，以json字符串的形式返回给浏览器

3. 浏览器收到js字符串，可以使用js对json进行解析，使用js通过dom

   增删改改变页面

   append() 在某一个父级元素的最后一个子元素添加内容

4. 返回json，实现客户端无关性

### 新增逻辑

1. 在index.jsp页面点击新增
2. 弹出新增对话框
3. 数据库查询部门列表，显示在对话框中
4. 用户输入数据，进行校验
   jquery前端校验，ajax用户名重复校验，后端校验（JSR303）
5. 保存



### URI

/emp/{id}  GET 查询员工

/emp   POST 保存员工

/emp/{id}  PUT 修改员

/emp/{id}  DELETE 删除员工

### 数据校验

jquery文档 https://jquery.cuishifeng.cn/



前端校验只是防君子不防小人

安全校验：前端+后端+数据库约束



### 更新员工遇到的问题

```java
/**
	 * 如果直接发送ajax=PUT形式的请求
	 * 封装的数据
	 * Employee 
	 * [empId=1014, empName=null, gender=null, email=null, dId=null]
	 * 
	 * 问题：
	 * 请求体中有数据；
	 * 但是Employee对象封装不上；
	 * update tbl_emp  where emp_id = 1014;
	 * 
	 * 原因：
	 * Tomcat：
	 * 		1、将请求体中的数据，封装一个map。
	 * 		2、request.getParameter("empName")就会从这个map中取值。
	 * 		3、SpringMVC封装POJO对象的时候。
	 * 				会把POJO中每个属性的值，request.getParamter("email");
	 * AJAX发送PUT请求引发的血案：
	 * 		PUT请求，请求体中的数据，request.getParameter("empName")拿不到
	 * 		Tomcat一看是PUT不会封装请求体中的数据为map，只有POST形式的请求才封装请求体为map
	 * org.apache.catalina.connector.Request--parseParameters() (3111);
	 * 
	 * protected String parseBodyMethods = "POST";
	 * if( !getConnector().isParseBodyMethod(getMethod()) ) {
                success = true;
                return;
            }
	 * 
	 * 
	 * 解决方案；
	 * 我们要能支持直接发送PUT之类的请求还要封装请求体中的数据
	 * 1、配置上HttpPutFormContentFilter；
	 * 2、他的作用；将请求体中的数据解析包装成一个map。
	 * 3、request被重新包装，request.getParameter()被重写，就会从自己封装的map中取数据
	 * 员工更新方法
	 */
```



### 删除员工