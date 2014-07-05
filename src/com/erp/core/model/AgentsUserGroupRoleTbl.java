package com.erp.core.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

/**
 * AgentsUserGroupRoleTbl entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "agents_user_group_role_tbl")
public class AgentsUserGroupRoleTbl implements java.io.Serializable {

	// Fields

	private Integer id;
	private String agentsCode;
	private String groupCode;
	private String groupName;
	private Short status;
	private String remark;
	private String createTime;
	private Set<AgentsResourceTbl> agentsResourceTbl;
	private Set<AgentsUserTbl> agentsUserTbls;
	// Constructors

	/** default constructor */
	public AgentsUserGroupRoleTbl() {
	}

	/** minimal constructor */
	public AgentsUserGroupRoleTbl(String agentsCode,String groupCode, String groupName, String createTime) {
		this.agentsCode = agentsCode;
		this.groupCode = groupCode;
		this.groupName = groupName;
		this.createTime = createTime;
	}

	/** full constructor */
	public AgentsUserGroupRoleTbl(String agentsCode,String groupCode, String groupName, String remark, String createTime, Set<AgentsResourceTbl> agentsResourceTbl,
			Set<AgentsUserTbl> agentsUserTbls) {
		this.agentsCode = agentsCode;
		this.groupCode = groupCode;
		this.groupName = groupName;
		this.remark = remark;
		this.createTime = createTime;
		this.agentsResourceTbl = agentsResourceTbl;
		this.agentsUserTbls = agentsUserTbls;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "agents_code", nullable = false, length = 8)
	public String getAgentsCode() {
		return this.agentsCode;
	}

	public void setAgentsCode(String agentsCode) {
		this.agentsCode = agentsCode;
	}
	@Column(name = "group_code", nullable = false, length = 32)
	public String getGroupCode() {
		return groupCode;
	}

	public void setGroupCode(String groupCode) {
		this.groupCode = groupCode;
	}

	@Column(name = "group_name", nullable = false, length = 48)
	public String getGroupName() {
		return this.groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	@Column(name = "status", nullable = false)
	public Short getStatus() {
		return status;
	}

	public void setStatus(Short status) {
		this.status = status;
	}

	@Column(name = "remark", length = 64)
	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Column(name = "create_time", nullable = false, length = 32)
	public String getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	@ManyToMany(targetEntity = AgentsResourceTbl.class, fetch = FetchType.EAGER, cascade = {
			CascadeType.PERSIST, CascadeType.MERGE })
	@JoinTable(name = "agents_group_role_resource_tbl", joinColumns = { @JoinColumn(name = "ROLE_ID") }, inverseJoinColumns = { @JoinColumn(name = "RESOURCE_ID") })
	public Set<AgentsResourceTbl> getAgentsResourceTbl() {
		if (agentsResourceTbl == null) {
			agentsResourceTbl = new HashSet<AgentsResourceTbl>();
		}
		return agentsResourceTbl;
	}

	public void setAgentsResourceTbl(Set<AgentsResourceTbl> agentsResourceTbl) {
		this.agentsResourceTbl = agentsResourceTbl;
	}
	@ManyToMany(targetEntity =  AgentsUserTbl.class, fetch = FetchType.LAZY, cascade = {
		CascadeType.PERSIST, CascadeType.MERGE }, mappedBy = "agentsUserGroupRoleTbl")
	public Set<AgentsUserTbl> getAgentsUserTbls() {
		if (agentsUserTbls == null) {
			agentsUserTbls = new HashSet<AgentsUserTbl>();
		}
		return agentsUserTbls;
	}

	public void setAgentsUserTbls(Set<AgentsUserTbl> agentsUserTbls) {
		this.agentsUserTbls = agentsUserTbls;
	}
}