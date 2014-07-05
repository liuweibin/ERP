package com.erp.core.model;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * AgentsGroupRoleResourceTbl entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "agents_group_role_resource_tbl")
public class AgentsGroupRoleResourceTbl implements java.io.Serializable {

	// Fields

	private Integer id;
	private AgentsUserGroupRoleTbl agentsUserGroupRoleTbl;
	private AgentsResourceTbl agentsResourceTbl;

	// Constructors

	/** default constructor */
	public AgentsGroupRoleResourceTbl() {
	}

	/** full constructor */
	public AgentsGroupRoleResourceTbl(AgentsUserGroupRoleTbl agentsUserGroupRoleTbl, AgentsResourceTbl agentsResourceTbl) {
		this.agentsUserGroupRoleTbl = agentsUserGroupRoleTbl;
		this.agentsResourceTbl = agentsResourceTbl;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "role_id", nullable = false)
	public AgentsUserGroupRoleTbl getAgentsUserGroupRoleTbl() {
		return this.agentsUserGroupRoleTbl;
	}

	public void setAgentsUserGroupRoleTbl(AgentsUserGroupRoleTbl agentsUserGroupRoleTbl) {
		this.agentsUserGroupRoleTbl = agentsUserGroupRoleTbl;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "resource_id", nullable = false)
	public AgentsResourceTbl getAgentsResourceTbl() {
		return this.agentsResourceTbl;
	}

	public void setAgentsResourceTbl(AgentsResourceTbl agentsResourceTbl) {
		this.agentsResourceTbl = agentsResourceTbl;
	}

}