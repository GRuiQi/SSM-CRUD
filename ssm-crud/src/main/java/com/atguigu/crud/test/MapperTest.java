package com.atguigu.crud.test;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/*
* 推荐Spring项目就可以使用Spring的单元测试，可以自动注入我们需要的组件
* 导入SpringTest模块
* @ContextConfiguration指定Spring配置文件的二路径
* */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {

   /* @Test
    public void testCrud(){
        //1. 创建SpringIOC容器
        ApplicationContext ioc = new
                ClassPathXmlApplicationContext(
                        "applicationContexct.xml");
        //2.从容器中获取mapper
        DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);

    }*/

   @Autowired
   private DepartmentMapper departmentMapper;

   @Autowired
   private EmployeeMapper employeeMapper;

   @Autowired
   private SqlSession  sqlSession;

   @Test
    public void testCrud(){
       System.out.println(departmentMapper);


       //departmentMapper.insertSelective( new Department(null,"不知道是什么部门"));
       departmentMapper.deleteByPrimaryKey(9);
    }

    @Test
    public void testEmp(){
       employeeMapper.insertSelective(new Employee(null,"Alice","M","34223423@qq.com",1,null));
    }

    @Test
    public void tsetEmpInsert(){
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for(int i = 0;i<1000;i++){
            String uid = "hello"+ UUID.randomUUID().toString().substring(0,5)+i;
            mapper.insertSelective(new Employee(null,uid, "M", uid+"@atguigu.com", 1,null));
        }
        System.out.println("批量完成");
    }
}
