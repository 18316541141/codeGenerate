package com.code.gen;
import java.util.List;
public class BeanInfo{
	private String packageName;
	private String ctrlPackageName;
	private String servicePackageName;
	private String mapperPackageName;
	private String mapperXmlPackageName;
	private String beanName;
	private List<BeanPropInfo> beanPropInfoList;
	private String sqlPrefix;
	private String sqlSuffix;
	private String requestSuffix;
	public String getBeanName() {
		return beanName;
	}
	public void setBeanName(String beanName) {
		this.beanName = beanName;
	}
	public List<BeanPropInfo> getBeanPropInfoList() {
		return beanPropInfoList;
	}
	public void setBeanPropInfoList(List<BeanPropInfo> beanPropInfoList) {
		this.beanPropInfoList = beanPropInfoList;
	}
	public String getPackageName() {
		return packageName;
	}
	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}
	public String getSqlPrefix() {
		return sqlPrefix;
	}
	public void setSqlPrefix(String sqlPrefix) {
		this.sqlPrefix = sqlPrefix;
	}
	public String getSqlSuffix() {
		return sqlSuffix;
	}
	public void setSqlSuffix(String sqlSuffix) {
		this.sqlSuffix = sqlSuffix;
	}
	public String getCtrlPackageName() {
		return ctrlPackageName;
	}
	public void setCtrlPackageName(String ctrlPackageName) {
		this.ctrlPackageName = ctrlPackageName;
	}
	public String getServicePackageName() {
		return servicePackageName;
	}
	public void setServicePackageName(String servicePackageName) {
		this.servicePackageName = servicePackageName;
	}
	public String getMapperPackageName() {
		return mapperPackageName;
	}
	public void setMapperPackageName(String mapperPackageName) {
		this.mapperPackageName = mapperPackageName;
	}
	public String getMapperXmlPackageName() {
		return mapperXmlPackageName;
	}
	public void setMapperXmlPackageName(String mapperXmlPackageName) {
		this.mapperXmlPackageName = mapperXmlPackageName;
	}
	public String getRequestSuffix() {
		return requestSuffix;
	}
	public void setRequestSuffix(String requestSuffix) {
		this.requestSuffix = requestSuffix;
	}
}