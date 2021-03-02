package com.atguigu.crud.bean;

public class Department {
    private Integer id;

    private String deptName;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

	public Department() {
		super();
	}

	public Department(Integer id, String deptName) {
		super();
		this.id = id;
		this.deptName = deptName;
	}
    
}