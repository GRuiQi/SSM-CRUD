<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%--
    web路径
    不以/开始的相对路径，找资源，以当前资源路径为基准，经常容易出问题
    以/开始相对路径，找资源，以服务器路径为标准 http://localhost:8080/项目名
--%>

<html>
<head>
    <title>员工列表</title>

    <%--引入jQuery--%>
    <script src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
    <%--引入样式--%>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <%--引入js--%>
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

</head>
<body>


    <!-- 修改员工的Modal -->
    <div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">员工修改</h4>
                </div>
                <div class="modal-body">
                    <%--弹框的具体内容--%>
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <p class="form-control-static" id="empName_update_static"></p>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="email" id="email_update_input" placeholder="email">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="empGender" id="gender1_update_input" value="M" checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="empGender" id="gender2_update_input" value="F"> 女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">deptName</label>
                            <div class="col-sm-4">
                                <select class="form-control" name="deptId">

                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button type="button" class="btn btn-primary" id="emp_update_btn">保存</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>



    <!-- 员工新增的Modal -->
    <div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">员工添加</h4>
                </div>
                <div class="modal-body">
                   <%--弹框的具体内容--%>
                   <form class="form-horizontal">
                       <div class="form-group">
                           <label  class="col-sm-2 control-label">empName</label>
                           <div class="col-sm-10">
                               <input type="text" class="form-control" name="empName" id="empName_add_input" placeholder="empName">
                               <span class="help-block"></span>
                           </div>
                       </div>
                       <div class="form-group">
                           <label class="col-sm-2 control-label">email</label>
                           <div class="col-sm-10">
                               <input type="text" class="form-control" name="email" id="email_add_input" placeholder="email">
                               <span class="help-block"></span>
                           </div>
                       </div>
                       <div class="form-group">
                           <label  class="col-sm-2 control-label">gender</label>
                           <div class="col-sm-10">
                               <label class="radio-inline">
                                   <input type="radio" name="empGender" id="gender1_add_input" value="M" checked="checked"> 男
                               </label>
                               <label class="radio-inline">
                                   <input type="radio" name="empGender" id="gender2_add_input" value="F"> 女
                               </label>
                           </div>
                       </div>
                       <div class="form-group">
                           <label class="col-sm-2 control-label">deptName</label>
                           <div class="col-sm-4">
                               <select class="form-control" name="deptId">

                               </select>
                           </div>
                       </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
                        </div>
                   </form>
                </div>
            </div>
        </div>
    </div>


    <%--搭建显示页面--%>
    <div class="container">
        <%--标题--%>
        <div class="row">
            <div class="col-md-12">
                <h1>SSM-CRUD</h1>
            </div>
        </div>

        <%--按钮--%>
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-primary" id="emp_add_modal_btn"> 新增</button>
                <button class="btn btn-danger" id="emp_del_modal_btn"> 删除</button>
            </div>
        </div>

            <!-- 显示表格数据 -->
            <div class="row">
                <div class="col-md-12">
                    <table class="table table-hover" id="emps_table">
                        <thead>
                            <tr>
                                <th>
                                    <input type="checkbox" id="check_all"/>
                                </th>
                                <th>#</th>
                                <th>empName</th>
                                <th>gender</th>
                                <th>email</th>
                                <th>deptName</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>

                        </tbody>
                    </table>
                </div>
            </div>

        <%--显示分页信息--%>
        <div class="row">
            <%--分页文字信息--%>
            <div class="col-md-6" id="page_info_area">

            </div>
            <%--分页条信息--%>
            <div class="col-md-6" id="page_nav_area">


            </div>
        </div>
    </div>

    <script type="text/javascript">
        var totalRecord;
        var currentPage;

        //1、页面加载完成以后，直接去发送ajax请求,要到分页数据
        $(function(){
          //去首页
          to_page(1);
        });

        function to_page(pn) {
            $.ajax({
                url: "${APP_PATH}/emps",
                data: "pn="+pn,
                type: "GET",
                success:function(result){
                    //console.log(result);
                    //1.解析并显示员工星星
                    build_emps_table(result);
                    //2.解析并显示分页信息
                    build_page_info(result);
                    //3、解析显示分页条数据
                    build_page_nav(result);
                }
            });
        }

        function build_emps_table(result) {
            /*清空form表格*/
            $("#emps_table tbody").empty();

            var emps = result.extend.pageInfo.list;
            $.each(emps,function(index,item){
                var checkBoxId = $("<td><input type='checkbox' class='check_item'/></td>");

                //console.log(item.empName);
                var empIdTd = $("<td></td>").append(item.empId);
                var empNameTd = $("<td></td>").append(item.empName);
                //var empGender = item.empGender == "M"?"男":"女";
                var empGenderTd = $("<td></td>").append(item.empGender == "M"?"男":"女");
                var emailTd =  $("<td></td>").append(item.email);
                var deptNameTd = $("<td></td>").append(item.department.deptName);

                var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");

                /*为编辑按钮添加一个自定义属性，来表示当前员工的id*/
                editBtn.attr("edit-id",item.empId);

                var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");

                /*为删除按钮添加一个自定义属性，来表示当前删除员工的id*/
                delBtn.attr("del-id",item.empId);

                var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn)
                /*append方法执行完成后还是返回原来的元素*/
                $("<tr></tr>").append(checkBoxId)
                    .append(empIdTd)
                    .append(empNameTd)
                    .append(empGenderTd)
                    .append(emailTd)
                    .append(emailTd)
                    .append(deptNameTd)
                    .append(btnTd)
                    .appendTo("#emps_table tbody");

            });
        }

        //解析显示分页信息
        function  build_page_info(result){
            $("#page_info_area").empty();
            $("#page_info_area").append(
                "当前"+result.extend.pageInfo.pageNum+"页,总"+
                result.extend.pageInfo.pages+"页,总"+
                result.extend.pageInfo.total+"条记录"
            )
            totalRecord = result.extend.pageInfo.total;
            currentPage = result.extend.pageInfo.pageNum;
        }


        //解析显示分页条，点击分页要能去下一页....
        /*https://v3.bootcss.com/components/#pagination*/
        function build_page_nav(result){
            $("#page_nav_area").empty();

            var ul = $("<ul></ul>").addClass("pagination");

            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            var prePageLi = $("<li></li>").append($("<a></a>").append("<"));
            if(result.extend.pageInfo.hasPreviousPage==false){
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }else{
                firstPageLi.click(function () {
                    to_page(1);
                });

                prePageLi.click(function () {
                    to_page(result.extend.pageInfo.pageNum -1);
                });
            }

            var nextPageLi = $("<li></li>").append($("<a></a>").append(">"));
            var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
            if(result.extend.pageInfo.hasNextPage==false){
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else{
                nextPageLi.click(function () {
                    to_page(result.extend.pageInfo.pageNum +1);
                });
                lastPageLi.click(function () {
                    to_page(result.extend.pageInfo.pages);
                });
            }

            //添加首页和前一页
            ul.append(firstPageLi).append(prePageLi);

            //1,2，3遍历给ul中添加页码提示
            $.each(result.extend.pageInfo.navigatepageNums,function(index,item){

                var numLi = $("<li></li>").append($("<a></a>").append(item));
                if(result.extend.pageInfo.pageNum == item){
                    numLi.addClass("active");
                }
                numLi.click(function(){
                    to_page(item);
                });
                ul.append(numLi);
            });

            //添加下一页和末页的提示
            ul.append(nextPageLi).append(lastPageLi);

            //把ul添加到nav
            var navEle = $("<nav></nav>").append(ul);

            navEle.appendTo("#page_nav_area");
        }


        //清空表单样式及其内容
        function reset_form(ele){
           // console.log($(ele)[0]);
            $(ele)[0].reset();
            //清空样式
            $(ele).find("*").removeClass("has-error has success");
            $(ele).find(".help-block").text("");
        }

        /*点击新增按钮弹出模态框*/
      $("#emp_add_modal_btn").click(function () {
          //清除表单数据，jquery没有reset()方法，用到的是dom元素的
          //$("#empAddModal form")[0].reset();

          reset_form("#empAddModal form");

          //发送ajax请求，查出部门信息显示在下拉框中
          getDepts("#empAddModal select");
          //弹出模态框
          $('#empAddModal').modal({
              backdrop: "static"
          });
      });

      //查出所有的不萌信息并显示在下拉列表中
      function getDepts(ele){
          //清空之前下拉列表的值
          $(ele).empty();
          $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (result) {
                //console.log(result);
                //$("#empAddModal select")
                /*
                * 0: {deptId: 1, deptName: "开发部"}
                    1:
                    deptId: 2
                    deptName: "人事部"
                * */
                $.each(result.extend.depts,function(){
                   var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                   optionEle.appendTo(ele);
                });
            }
          });
      }

      /*校验表单数据*/
        function validate_add_form(){
           /*1。拿到要校验的数据，使用正则表达式
           * https://jquery.cuishifeng.cn/regexp.html*/
           var empName =  $("#empName_add_input").val();
           var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
            if(!regName.test(empName)){
                //alert("用户名必需是2-5位中文或者6-16位英文组合");
                //应该清空这个元素之前的样式
              /*  $("#empName_add_input").parent().addClass("has-error");
                $("#empName_add_input").next("span").text("用户名必需是2-5位中文或者6-16位英文组合");*/

                show_validate_msg("#empName_add_input","error","用户名必需是2-5位中文或者6-16位英文组合");
                return false;
            }else{
               /* $("#empName_add_input").parent().addClass("has-success");*/
                show_validate_msg("#empName_add_input","success","");
            }

           var empEmail = $("#email_add_input").val();
           var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if(!regEmail.test(empEmail)){
                //alert("邮箱格式不正确");
               /* $("#email_add_input").parent().addClass("has-error");
                $("#email_add_input").next("span").text("邮箱格式不正确");*/
                show_validate_msg("#email_add_input","error","邮箱格式不正确");
                return false;
            }else{
               /* $("#email_add_input").parent().addClass("has-success");*/
                show_validate_msg("#email_add_input","success","");
            }

            return true;
        }


        //抽取信息提示
        function show_validate_msg(ele,status,msg){
            $(ele).parent().removeClass("has-success has-error");
            $(ele).next("span").text("");
            if("success"==status){
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text(msg);
            }else if("error"==status){
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
            }
        }


        //校验用户名是否可用
        $("#empName_add_input").change(function(){
            //发送ajax请求校验用户名是否可用
            var empName = this.value;

            $.ajax({
                url:"${APP_PATH}/checkuser",
                data: "empName="+empName,
                type:"POST",
                success:function(result){
                    if(result.code==100){
                        show_validate_msg("#empName_add_input","success","用户名可用");
                        $("#emp_save_btn").attr("ajax-va","success");
                    }else{
                        show_validate_msg("#empName_add_input","error",result.extend.va_mag);
                        $("#emp_save_btn").attr("ajax-va","error");
                    }
                }
            });
        });

        /*点击保存员工的方法*/
      $("#emp_save_btn").click(function(){

          /*先对要提交给服务器的数据进行校验*/
          if(!validate_add_form()){
              return false;
          }

          if($("#emp_save_btn").attr("ajax-va")=="error"){
              return false;
          }
          //console.log( $("#empAddModal form").serialize());
          /*发送ajax请求保存员工*/
          $.ajax({
              url: "${APP_PATH}/emp",
              type: "POST",
              /*
              * 序列化的表单中的标签name属性要和实体类中的相同
              * */
              data: $("#empAddModal form").serialize(),
              success: function(result){

                  //alert(result.msg);
                  if(result.code == 100){
                      //员工保存成功；
                      //1、关闭模态框
                      $("#empAddModal").modal('hide');

                      //2、来到最后一页，显示刚才保存的数据
                      //发送ajax请求显示最后一页数据即可
                      to_page(totalRecord);
                  }else{
                      //显示失败信息
                      //console.log(result);
                      //有哪个字段的错误信息就显示哪个字段的；
                      if(undefined != result.extend.errorFields.email){
                          console.log(result);
                          //显示邮箱错误信息
                          show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                      }
                      if(undefined != result.extend.errorFields.empName){
                          //显示员工名字的错误信息
                          show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
                      }
                  }

              }
          });

      });


      //jQuery的事件绑定在页面加载时就已经完成，所以之后添加的class将无法绑定上事件
      //需要用到 .on("click",id选择器，方法)
      $(document).on("click",".edit_btn",function(){
          //alert("edit");

          //查出员工信息，并显示员工信息
          getEmp($(this).attr("edit-id"));

          //查出部门信息，并显示部门信息
          getDepts("#empUpdateModal select");
          $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));

          /*触发模态框*/
          $("#empUpdateModal").modal({
             backdrop:"static"
          });
      })

      //模态框显示员工的数据
      function getEmp(id){
          $.ajax({
              url: "${APP_PATH}/emp/"+id,
              type: "GET",
              success:function (result) {
                  var empData = result.extend.emp;
                  $("#empName_update_static").text(empData.empName);
                  $("#email_update_input").val(empData.email);
                  $("#empUpdateModal input[name=empGender]").val([empData.empGender]);
                  $("#empUpdateModal select").val([empData.deptId]);
              }
          });
      }

      //点击更新，更新员工信息
         $("#emp_update_btn").click(function(){
          //验证邮箱是否合法
          //1.验证邮箱信息
            var empEmail = $("#email_update_input").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if(!regEmail.test(empEmail)){
                show_validate_msg("#email_add_input","error","邮箱格式不正确");
                return false;
            }else{
                show_validate_msg("#email_add_input","success","");
            }

            //2.发送ajax请求保存更新员工的数据
             $.ajax({
                 url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
                 type: "PUT",
                 data: $("#empUpdateModal form").serialize(),
                 success: function (result) {
                     //关闭对话框
                     $("#empUpdateModal").modal("hide");
                     //回到本页面
                     to_page(currentPage);
                 }

             });

        });

      //单个删除
        $(document).on("click",".delete_btn",function () {
            //1.弹出是否确认删除对话框
            var empName = $(this).parents("tr").find("td:eq(2)").text();
            var empId = $(this).attr("del-id");
            /*confirm() 方法用于显示一个带有指定消息和 OK 及取消按钮的对话框。
             * 如果用户点击确定按钮，则 confirm() 返回 true。如果点击取消按钮，
			 * 则 confirm() 返回 false。
			*/
            if(confirm("确认删除["+empName+"]吗？")){
                //确认，发送ajax请求即可
               $.ajax({
                    url: "${APP_PATH}/emp/"+empId,
                    type: "DELETE",
                    success:function (result) {
                        alert(result.msg);

                        //回到本页
                        to_page(currentPage);
                    }
                });
            }

        });

        //完成全选/全不选功能
        $("#check_all").click(function () {
            //attr获取checked是undefined;
            //attr获取自定义属性的值；
            //prop修改和读取dom原生属性的值
            $(".check_item").prop("checked",$(this).prop("checked"));
        });

        $(document).on("click",".check_item",function () {
            //判断当前的元素是否全部被选中（5个）
            var flag = $(".check_item:checked").length == $(".check_item").length;
            $("#check_all").prop("checked",flag);
        })

        //点击全部删除，就批量删除
        $("#emp_del_modal_btn").click(function () {
            var empNames = "";
            var del_idstr = "";
            $.each($(".check_item:checked"),function () {
                //this
                empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
                //组成员工id字符串
                del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
            });
            //去除empName多于的逗号
            empNames = empNames.substring(0,empNames.length-1);
            //去除删除的id多于的-
            del_idstr = del_idstr.substring(0,del_idstr.length-1);

            if(confirm("确认删除["+empNames+"]吗？")){
                //确认，发送ajax请求即可
                $.ajax({
                    url: "${APP_PATH}/emp/"+del_idstr,
                    type: "DELETE",
                    success:function (result) {
                        alert(result.msg);

                        //回到本页
                        to_page(currentPage);
                        //删除成功后，全选框需要取消
                        $("#check_all").prop("checked",false);
                    }
                });
            }
        });
    </script>
</body>
</html>
