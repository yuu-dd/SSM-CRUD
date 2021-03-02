package com.atguigu.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.EmployeeMapper;
/**
 * 	测试dao层工作
 * @author 10522
 *	推荐使用spring单元测试，可以自动注入我们所需的组件
 *	导入springTest模块
 *	数据库列名不使用标准命名方式（即类似于：xxx_id 的格式）的话，逆向工程会出现重复字段
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

	@Autowired
	DepartmentMapper dept;
	
	@Autowired
	EmployeeMapper emp;
	
	@Autowired
	SqlSession sqlSession;
	
	@Test
	public void testCRUD() {
//		//1.创建IOC容器
//		ClassPathXmlApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
//		//2.从容器中获取mapper
//		DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);
		
		System.out.println(dept);
		
//		dept.insertSelective(new Department(null,"开发部"));
//		dept.insertSelective(new Department(null,"测试部"));
//		
//		emp.insertSelective(new Employee(null,"nagi","F","nagi@168.com",1));
//		emp.insertSelective(new Employee(null,"hayate","F","hayate@168.com",2));
		
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int i = 0;i<1000;i++) {
			String uid = UUID.randomUUID().toString().substring(0,5) + i;
			mapper.insertSelective(new Employee(null,uid,"M", uid + "@168.com",1));
		}
		System.out.println("批量完成");
	}
}
