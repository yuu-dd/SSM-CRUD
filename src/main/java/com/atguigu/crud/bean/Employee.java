package com.atguigu.crud.bean;

import org.hibernate.validator.constraints.Length;

import jakarta.validation.constraints.Pattern;

public class Employee {
   

	public Department getDept() {
		return dept;
	}

	public void setDept(Department dept) {
		this.dept = dept;
	}

	@Override
	public String toString() {
		return "Employee [id=" + id + ", empName=" + empName + ", gender=" + gender + ", email=" + email + ", dId="
				+ dId + ", dept=" + dept + "]";
	}

	
	private Integer id;
	
	@Pattern(regexp="(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})",message = "用户名需要2-5位中文或6-16位英文或数字（组合）")
    private String empName;

    private String gender;

    @Pattern(regexp="^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$")
    private String email;

    private Integer dId;
    
    private Department dept;
    
    

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }

	public Employee() {
		super();
	}

	public Employee(Integer id, String empName, String gender, String email, Integer dId) {
		super();
		this.id = id;
		this.empName = empName;
		this.gender = gender;
		this.email = email;
		this.dId = dId;
	}

	public Employee(Integer id, String empName, String gender, String email, Integer dId, Department dept) {
		super();
		this.id = id;
		this.empName = empName;
		this.gender = gender;
		this.email = email;
		this.dId = dId;
		this.dept = dept;
	}
	
	
    
    
}