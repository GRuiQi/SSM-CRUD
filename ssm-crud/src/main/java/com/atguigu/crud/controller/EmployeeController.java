package com.atguigu.crud.controller;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;


    /*
    * 删除员工
    * 单个批量二合一
    * */
    @ResponseBody
    @RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("ids")String ids){
        //批量删除
        if(ids.contains("-")){
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            //组装id的集合
            for(String string :str_ids){
                del_ids.add(Integer.parseInt(string));
            }
            employeeService.deleteBatch(del_ids);
        }else{
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }


    /*
    * 员工更新
    */
    @RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmp(Employee employee){
        System.out.println("将要更新的员工数据"+employee);
        employeeService.update(employee);
        return Msg.success();
    }


    /*
    * 根据id查询员工
    * */
    @RequestMapping(value="/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id")Integer id){
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }


    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson (
            @RequestParam(value = "pn",defaultValue = "1") Integer pn){
        //查出很多数据，这不是一个分页查询
        //引入PageHelper插件
        //在查询之前只需要调用  PageHelper.startPage
        //传入页码，以及每页的大小
        PageHelper.startPage(pn,5);
        //startPage后面紧跟的查询就是一个分页查询

        List<Employee> emps = employeeService.getAll();
        //System.out.println(emps);
        //由PageInfo来包装分页查询后的结果，只需将PageInfo交给页面即可
        //详细封装了分页的信息，包括我们查询出来的数据,传入连续的页数
        PageInfo page = new PageInfo(emps,5);

        return Msg.success().add("pageInfo",page);
    }

    /*
    * @Valid代表数据绑定的时候需要校验
    * */
    @RequestMapping(value="/emp",method=RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee ,BindingResult result ){

        if(result.hasErrors()){
            Map<String,Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for(FieldError fieldError:errors){
                System.out.println("错误的字段名"+fieldError.getField());
                System.out.println("错误信息"+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else {
            //System.out.println(employee);
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    /*
    * 检查用户名是否可用
    * */
    @ResponseBody
    @RequestMapping(value="/checkuser",method = RequestMethod.POST)
    public Msg chekuser(@RequestParam("empName") String empName){

        /*判断用户名是否合法
        * /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2.5}$)/;
        * */
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
        if(!empName.matches(regx)){
            return Msg.fail().add("va_mag","用户名必须是6-16位数字和字母的组合或者2-5位中文");
        }
        Boolean b = employeeService.checkUser(empName);
        System.out.println(empName);
        if(b){
            return Msg.success();
        }else{
            return Msg.fail().add("va_mag","用户名不可用");
        }
    }

    @RequestMapping("/emps0")
    public String getEmps(
            @RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model){
        //查出很多数据，这不是一个分页查询
        //引入PageHelper插件
        //在查询之前只需要调用  PageHelper.startPage
        //传入页码，以及每页的大小
        PageHelper.startPage(pn,5);
        //startPage后面紧跟的查询就是一个分页查询

        List<Employee> emps = employeeService.getAll();
        System.out.println(emps);
        //由PageInfo来包装分页查询后的结果，只需将PageInfo交给页面即可
        //详细封装了分页的信息，包括我们查询出来的数据,传入连续的页数
        PageInfo page = new PageInfo(emps,5);
        model.addAttribute("pageInfo",page);

        return "list";
    }
}
