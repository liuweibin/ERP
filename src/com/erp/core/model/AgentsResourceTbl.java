package com.erp.core.model;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

/**
 * AgentsResourceTbl entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "agents_resource_tbl")
public class AgentsResourceTbl implements java.io.Serializable {

	// Fields

	private Integer id;
	private String name;
	private String url;
	private Integer enabled;
	private String remark;
	private String createTime;
	private String pid;
	private Integer order;
	private Integer isNode;
	//private Set<AgentsGroupRoleResourceTbl> agentsGroupRoleResourceTbls = new HashSet<AgentsGroupRoleResourceTbl>(0);
	private Set<AgentsUserGroupRoleTbl> agentsUserGroupRoleTbl;

	// Constructors

	/** default constructor */
	public AgentsResourceTbl() {
	}

	/** minimal constructor */
	public AgentsResourceTbl(String name, String url, Integer enabled) {
		this.name = name;
		this.url = url;
		this.enabled = enabled;
	}

	/** full constructor */
	public AgentsResourceTbl(String name, String url, Integer enabled, String remark, String createTime, Set<AgentsUserGroupRoleTbl> agentsUserGroupRoleTbl,String pid,Integer order,Integer isNode) {
		this.name = name;
		this.url = url;
		this.enabled = enabled;
		this.remark = remark;
		this.createTime = createTime;
		this.agentsUserGroupRoleTbl = agentsUserGroupRoleTbl;
		this.pid = pid;
		this.order = order;
		this.isNode = isNode;
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

	@Column(name = "name", nullable = false, length = 50)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "url", nullable = false, length = 100)
	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	@Column(name = "enabled", nullable = false)
	public Integer getEnabled() {
		return this.enabled;
	}

	public void setEnabled(Integer enabled) {
		this.enabled = enabled;
	}

	@Column(name = "remark", length = 64)
	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Column(name = "create_time", length = 32)
	public String getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	@ManyToMany(targetEntity =  AgentsUserGroupRoleTbl.class, fetch = FetchType.LAZY, cascade = {
		CascadeType.PERSIST, CascadeType.MERGE }, mappedBy = "agentsResourceTbl")
	public Set<AgentsUserGroupRoleTbl> getAgentsUserGroupRoleTbl() {
		return agentsUserGroupRoleTbl;
	}

	public void setAgentsUserGroupRoleTbl(
			Set<AgentsUserGroupRoleTbl> agentsUserGroupRoleTbl) {
		this.agentsUserGroupRoleTbl = agentsUserGroupRoleTbl;
	}
	@Column(name = "pid", nullable = false)
	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	@Column(name = "order", nullable = false)
	public Integer getOrder() {
		return order;
	}

	public void setOrder(Integer order) {
		this.order = order;
	}

	@Column(name = "isNode", nullable = false)
	public Integer getIsNode() {
		return isNode;
	}

	public void setIsNode(Integer isNode) {
		this.isNode = isNode;
	}


}