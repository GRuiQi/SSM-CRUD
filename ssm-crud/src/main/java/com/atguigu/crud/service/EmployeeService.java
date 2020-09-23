package com.atguigu.crud.service;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.EmployeeExample;
import com.atguigu.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 查询所有员工
     * @return
     */
    public List<Employee> getAll() {
        // TODO Auto-generated method stub
        return employeeMapper.selectByExampleWithDept(null);
    }

    /*
    * 按照员工id查询员工
    * */
    public Employee getEmp(Integer id){
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    /*
    * 校验用户名是否可用
    * */
    public Boolean checkUser(String empName) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(example);
        return count == 0;
      /*  int i = employeeMapper.checkUser(empName);
        if(i==0){
            return true;
        }else{
            return false;
        }*/
    }

    public void update(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);

    }
}