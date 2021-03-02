package com.atguigu.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import jakarta.validation.Valid;

@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;
	
	
	
	/**
	 * 	单个/批量删除
	 * 	批量删除：1-2-3
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
	public Msg deleteEmpById(@PathVariable("ids")String ids) {
		if(ids.contains("-")) {
			List<Integer> del_ids = new ArrayList<Integer>();
			String[] str_ids = ids.split("-");
			for(String id : str_ids) {
				del_ids.add(Integer.parseInt(id));
			}
			employeeService.deleteBatch(del_ids);
		}else {
			int id = Integer.parseInt(ids);
			employeeService.deleteEmp(id);
		}
		return Msg.success();
	}
	
	
	@RequestMapping(value="/emp",method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result) {
		
		if(result.hasErrors()) {
			//校验失败，应该返回失败，在模态框中显示校验失败的错误信息
			Map<String,Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for(FieldError f : errors) {
				System.out.println("错误字段名:" + f.getField());
				System.out.println("错误信息：" + f.getDefaultMessage());
				map.put(f.getField(), f.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else {
			employeeService.saveEmp(employee);
		return Msg.success();
		}
		
	}
	
	
	
	/**
	 * 	员工更新方法
	 * @param employee
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/emp/{id}",method = RequestMethod.PUT)
	public Msg saveEmp(Employee employee) {
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	
	
	/**
	 * 	根据id查询员工
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/emp/{id}",method = RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id) {
		
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	
	
	@ResponseBody
	@RequestMapping("/checkuser")
	public Msg checkUse(@RequestParam(value = "empName")String empName) {
		//先判断是否是合法的表达式
		String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
		
		if(!empName.matches(regx)) {
			return Msg.fail().add("va_msg", "用户名需要2-5位纯中文或6-16位英文及数字（组合）,不可使用除 _   - 之外的符号，包括空格");
		}
		
		//数据库用户名重复校验
		boolean b = employeeService.checkUse(empName);
		if(b) {
			return Msg.success();
		}else {
			return Msg.fail().add("va_msg", "用户名已存在");
		}
	}
	
	
	
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn,Model model) {
		PageHelper.startPage(pn,5);
		//startPage后面紧跟的查询就是分页查询
		List<Employee> emps = employeeService.getAll();
		//使用pageInfo包装查询后的结果,传入连续显示的页数
		PageInfo page = new PageInfo(emps,5);
		return Msg.success().add("pageInfo",page);
		
	}
	
	/**
	 * 	分页查询数据
	 * @return
	 */
	//@RequestMapping("/emps")
	public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn,Model model) {
		//引入pageHelper分页插件
		//查询前调用方法传入页码
		PageHelper.startPage(pn,5);
		//startPage后面紧跟的查询就是分页查询
		List<Employee> emps = employeeService.getAll();
		//使用pageInfo包装查询后的结果,传入连续显示的页数
		PageInfo page = new PageInfo(emps,5);
		
		model.addAttribute("pageInfo",page);
		
		return "list";
	}
}
