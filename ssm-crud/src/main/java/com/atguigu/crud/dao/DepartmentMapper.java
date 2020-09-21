package com.atguigu.crud.dao;

import com.atguigu.crud.bean.Department;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface DepartmentMapper {
    long countByExample(Department example);

    int deleteByExample(Department example);

    int deleteByPrimaryKey(Integer deptId);

    int insert(Department record);

    int insertSelective(Department record);

    List<Department> selectByExample(Department example);

    Department selectByPrimaryKey(Integer deptId);

    int updateByExampleSelective(@Param("record") Department record, @Param("example") Department example);

    int updateByExample(@Param("record") Department record, @Param("example") Department example);

    int updateByPrimaryKeySelective(Department record);

    int updateByPrimaryKey(Department record);


}