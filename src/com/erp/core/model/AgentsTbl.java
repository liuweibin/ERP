package com.erp.core.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * AgentsTbl entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "agents_tbl")
public class AgentsTbl implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer bail;
	private String agentsCode;
	private String name;
	private String idNumber;
	private Short type;
	private String registerUsername;
	private String registerPassword;
	private String nodeKey;
	private Integer nodeLevel;
	private Integer maxSubAgents;
	private Integer balance;
	private Integer balanceAlarm;
	private String useableBalance;
	private String superPassword;
	private Short auditStatus;
	private String linkman;
	private String fixedPhone;
	private String mobilePhone;
	private String qq;
	private String email;
	private String address;
	private String linkmanSecond;
	private String fixedPhoneSecond;
	private String mobilePhoneSecond;
	private String qqSecond;
	private String emailSecond;
	private String addressSecond;
	private String registeredTime;
	private String remark;
	private String createTime;
	private AgentsTbl upperAgents;
	private Set<AgentsUserTbl> agentsUsers = new HashSet<AgentsUserTbl>(0);
	private Set<AgentsTbl> childsAgents;
	
	// Constructors

	/** default constructor */
	public AgentsTbl() {
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

	 

	@Column(name = "agents_code",nullable=true)
	public String getAgentsCode() {
		return this.agentsCode;
	}

	public void setAgentsCode(String agentsCode) {
		this.agentsCode = agentsCode;
	}

	@Column(name = "name",nullable=true)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "id_number",nullable=true)
	public String getIdNumber() {
		return this.idNumber;
	}

	public void setIdNumber(String idNumber) {
		this.idNumber = idNumber;
	}

	@Column(name = "type",nullable=true)
	public Short getType() {
		return this.type;
	}

	public void setType(Short type) {
		this.type = type;
	}

	@Column(name = "max_sub_agents",nullable=true)
	public Integer getMaxSubAgents() {
		return this.maxSubAgents;
	}

	public void setMaxSubAgents(Integer maxSubAgents) {
		this.maxSubAgents = maxSubAgents;
	}

	@Column(name = "balance",nullable=true)
	public Integer getBalance() {
		return this.balance;
	}

	public void setBalance(Integer balance) {
		this.balance = balance;
	}

	@Column(name = "balance_alarm",nullable=true)
	public Integer getBalanceAlarm() {
		return this.balanceAlarm;
	}

	public void setBalanceAlarm(Integer balanceAlarm) {
		this.balanceAlarm = balanceAlarm;
	}

	@Column(name = "super_password",nullable=true)
	public String getSuperPassword() {
		return this.superPassword;
	}

	public void setSuperPassword(String superPassword) {
		this.superPassword = superPassword;
	}

	@Column(name = "audit_status",nullable=true)
	public Short getAuditStatus() {
		return this.auditStatus;
	}

	public void setAuditStatus(Short auditStatus) {
		this.auditStatus = auditStatus;
	}

	@Column(name = "linkman",nullable=true)
	public String getLinkman() {
		return this.linkman;
	}

	public void setLinkman(String linkman) {
		this.linkman = linkman;
	}

	@Column(name = "fixed_phone",nullable=true)
	public String getFixedPhone() {
		return this.fixedPhone;
	}

	public void setFixedPhone(String fixedPhone) {
		this.fixedPhone = fixedPhone;
	}

	@Column(name = "mobile_phone",nullable=true)
	public String getMobilePhone() {
		return this.mobilePhone;
	}

	public void setMobilePhone(String mobilePhone) {
		this.mobilePhone = mobilePhone;
	}

	@Column(name = "qq",nullable=true)
	public String getQq() {
		return this.qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	@Column(name = "email",nullable=true)
	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(name = "address",nullable=true)
	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Column(name = "linkman_second",nullable=true)
	public String getLinkmanSecond() {
		return this.linkmanSecond;
	}

	public void setLinkmanSecond(String linkmanSecond) {
		this.linkmanSecond = linkmanSecond;
	}

	@Column(name = "fixed_phone_second",nullable=true)
	public String getFixedPhoneSecond() {
		return this.fixedPhoneSecond;
	}

	public void setFixedPhoneSecond(String fixedPhoneSecond) {
		this.fixedPhoneSecond = fixedPhoneSecond;
	}

	@Column(name = "mobile_phone_second",nullable=true)
	public String getMobilePhoneSecond() {
		return this.mobilePhoneSecond;
	}

	public void setMobilePhoneSecond(String mobilePhoneSecond) {
		this.mobilePhoneSecond = mobilePhoneSecond;
	}

	@Column(name = "qq_second",nullable=true)
	public String getQqSecond() {
		return this.qqSecond;
	}

	public void setQqSecond(String qqSecond) {
		this.qqSecond = qqSecond;
	}

	@Column(name = "email_second",nullable=true)
	public String getEmailSecond() {
		return this.emailSecond;
	}

	public void setEmailSecond(String emailSecond) {
		this.emailSecond = emailSecond;
	}

	@Column(name = "address_second",nullable=true)
	public String getAddressSecond() {
		return this.addressSecond;
	}

	public void setAddressSecond(String addressSecond) {
		this.addressSecond = addressSecond;
	}

	@Column(name = "registered_time",nullable=true)
	public String getRegisteredTime() {
		return this.registeredTime;
	}

	public void setRegisteredTime(String registeredTime) {
		this.registeredTime = registeredTime;
	}

	@Column(name = "remark",nullable=true)
	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Column(name = "create_time",nullable=true)
	public String getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "parent_id",referencedColumnName="id")
	public AgentsTbl getUpperAgents() {
		return this.upperAgents;
	}

	public void setUpperAgents(AgentsTbl upperAgents) {
		this.upperAgents = upperAgents;
	}
	
	@OneToMany(fetch=FetchType.LAZY,mappedBy="agents")
	@JoinColumn(name = "agents_id")
	public Set<AgentsUserTbl> getAgentsUsers() {
		return agentsUsers;
	}

	public void setAgentsUsers(Set<AgentsUserTbl> agentsUsers) {
		this.agentsUsers = agentsUsers;
	}

	@Column(name = "bail",nullable=true)
	public Integer getBail() {
		return bail;
	}

	public void setBail(Integer bail) {
		this.bail = bail;
	}
	

	@Column(name = "username_register",nullable=true)
	public String getRegisterUsername() {
		return registerUsername;
	}

	public void setRegisterUsername(String registerUsername) {
		this.registerUsername = registerUsername;
	}

	@Column(name = "password_register",nullable=true)
	public String getRegisterPassword() {
		return registerPassword;
	}

	public void setRegisterPassword(String registerPassword) {
		this.registerPassword = registerPassword;
	}

	@Column(name = "node_level",nullable=true)
	public Integer getNodeLevel() {
		return nodeLevel;
	}

	public void setNodeLevel(Integer nodeLevel) {
		this.nodeLevel = nodeLevel;
	}
	
	@Column(name = "node_key",nullable=true)
	public String getNodeKey() {
		return nodeKey;
	}

	public void setNodeKey(String nodeKey) {
		this.nodeKey = nodeKey;
	}
	
	@OneToMany(fetch = FetchType.LAZY)
	@JoinColumn(name = "parent_id")
	public Set<AgentsTbl> getChildsAgents() {
		return this.childsAgents;
	}

	public void setChildsAgents(Set<AgentsTbl> childsAgents) {
		this.childsAgents = childsAgents;
	}
 
}