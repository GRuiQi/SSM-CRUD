package com.atguigu.crud.dao;

import com.atguigu.crud.bean.Employee;

import java.util.List;

import com.atguigu.crud.bean.EmployeeExample;
import org.apache.ibatis.annotations.Param;

public interface EmployeeMapper {
    long countByExample(EmployeeExample example);

    int deleteByExample(Employee example);

    int deleteByPrimaryKey(Integer empId);

    int insert(Employee record);

    int insertSelective(Employee record);

    List<Employee> selectByExample(Employee example);

    Employee selectByPrimaryKey(Integer empId);

    List<Employee> selectByExampleWithDept(Employee example);

    Employee selectByPrimaryKeyWithDept(Integer empId);

    int updateByExampleSelective(@Param("record") Employee record, @Param("example") Employee example);

    int updateByExample(@Param("record") Employee record, @Param("example") Employee example);

    int updateByPrimaryKeySelective(Employee record);

    int updateByPrimaryKey(Employee record);

    int checkUser(String empName);
}