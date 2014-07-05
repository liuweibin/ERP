package com.erp.core.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * AgentsUserTbl entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "agents_user_tbl")
public class AgentsUserTbl implements java.io.Serializable {

	// Fields

	private Integer id;
	private AgentsUserGroupRoleTbl agentsUserGroupRoleTbl;
	private AgentsTbl agents;
	private String username;
	private String password;
	private String mobile;
	private String realName;
	private Short userType;
	private Short loginType;
	private Short bindType;
	private String bindValue;
	private Short mobileBindType;
	private String mobileBindValue;
	private Short status;
	private String lastLoginTime;
	private Short lastLoginType;
	private String remark;
	private String createTime;
	private String code; 
	private String lastModifyPwdTime;
	private String lastLoginIp;
	  
	// Constructors
	@Transient  
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	/** default constructor */
	public AgentsUserTbl() {
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

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "group_id", nullable = false)
	public AgentsUserGroupRoleTbl getAgentsUserGroupRoleTbl() {
		return this.agentsUserGroupRoleTbl;
	}

	public void setAgentsUserGroupRoleTbl(AgentsUserGroupRoleTbl agentsUserGroupRoleTbl) {
		this.agentsUserGroupRoleTbl = agentsUserGroupRoleTbl;
	}

	@Column(name = "username")
	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@Column(name = "password", nullable = false, length = 48)
	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Column(name = "mobile", length = 16)
	public String getMobile() {
		return this.mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	@Column(name = "real_name")
	public String getRealName() {
		return this.realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	@Column(name = "user_type")
	public Short getUserType() {
		return this.userType;
	}

	public void setUserType(Short userType) {
		this.userType = userType;
	}

	@Column(name = "login_type")
	public Short getLoginType() {
		return this.loginType;
	}

	public void setLoginType(Short loginType) {
		this.loginType = loginType;
	}
	@Column(name = "mobile_bind_type")
	public Short getMobileBindType() {
		return mobileBindType;
	}

	public void setMobileBindType(Short mobileBindType) {
		this.mobileBindType = mobileBindType;
	}
	@Column(name = "mobile_bind_value", length = 48)
	public String getMobileBindValue() {
		return mobileBindValue;
	}

	public void setMobileBindValue(String mobileBindValue) {
		this.mobileBindValue = mobileBindValue;
	}
	
	@Column(name = "bind_type")
	public Short getBindType() {
		return this.bindType;
	}

	public void setBindType(Short bindType) {
		this.bindType = bindType;
	}

	@Column(name = "bind_value", length = 32)
	public String getBindValue() {
		return this.bindValue;
	}

	public void setBindValue(String bindValue) {
		this.bindValue = bindValue;
	}

	@Column(name = "status")
	public Short getStatus() {
		return this.status;
	}

	public void setStatus(Short status) {
		this.status = status;
	}

	@Column(name = "last_login_time", length = 32)
	public String getLastLoginTime() {
		return this.lastLoginTime;
	}

	public void setLastLoginTime(String lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}

	@Column(name = "last_login_type")
	public Short getLastLoginType() {
		return this.lastLoginType;
	}

	public void setLastLoginType(Short lastLoginType) {
		this.lastLoginType = lastLoginType;
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

	@ManyToOne(fetch=FetchType.EAGER)
	@JoinColumn(name="agents_id")
	public AgentsTbl getAgents() {
		return agents;
	}

	public void setAgents(AgentsTbl agents) {
		this.agents = agents;
	}

	@Column(name = "last_modify_pwd_time")
	public String getLastModifyPwdTime() {
		return lastModifyPwdTime;
	}

	public void setLastModifyPwdTime(String lastModifyPwdTime) {
		this.lastModifyPwdTime = lastModifyPwdTime;
	}

	@Column(name = "last_login_ip")
	public String getLastLoginIp() {
		return lastLoginIp;
	}

	public void setLastLoginIp(String lastLoginIp) {
		this.lastLoginIp = lastLoginIp;
	}
}