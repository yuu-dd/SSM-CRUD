package com.atguigu.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.EmployeeExample;
import com.atguigu.crud.bean.EmployeeExample.Criteria;
import com.atguigu.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	private EmployeeMapper employeeMapper;
	
	public List<Employee> getAll(){
		return employeeMapper.selectByExampleWithDept(null);
	}

	//保存员工数据
	public void saveEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.insertSelective(employee);
		
	}
	
	/**
	 * 	检验用户名是否可用
	 * @param empName
	 * @return	true代表可用；false不可用
	 */
	public boolean checkUse(String empName) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long countByExample = employeeMapper.countByExample(example);
		return countByExample == 0;	
	}

	
	/**
	 * 	按照id查询员工
	 * @param id
	 * @return
	 */
	public Employee getEmp(Integer id) {
		Employee employee = employeeMapper.selectByPrimaryKey(id);
		return employee;
	}

	
	/**
	 * 	员工更新
	 * @param employee
	 */
	public void updateEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
		
		
	}

	/**
	 * 	删除操作
	 * @param id
	 */
	public void deleteEmp(Integer id) {
		employeeMapper.deleteByPrimaryKey(id);
	}

	public void deleteBatch(List<Integer> ids) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		
		criteria.andIdIn(ids);
		employeeMapper.deleteByExample(example);
		
	}
	
}
