package com.code.gen;
import java.util.Map;
public class BeanPropInfo {
	private String propName;
	//属性类型Integer,Date,String
	private String propType;
	private Boolean autoIncrement;
	private Boolean isUUID;
	private Boolean insertReturn;
	private Boolean isPrimaryKey;
	private String regex;
	private Integer minLen,maxLen;
	//isErrMsgId=true当发生错误时会根据该属性来生成错误消息
	private Boolean isErrMsgId;
	private Long min,max;
	private Boolean notEmpty;
	//字段中文名
	private String colName;
	//字段的详细描述
	private String colDesc;
	private Map<String,String> enumMap;
	public String getPropName() {
		return propName;
	}
	public void setPropName(String propName) {
		this.propName = propName;
	}
	public String getPropType() {
		return propType;
	}
	public void setPropType(String propType) {
		this.propType = propType;
	}
	public Boolean getAutoIncrement() {
		return autoIncrement;
	}
	public void setAutoIncrement(Boolean autoIncrement) {
		this.autoIncrement = autoIncrement;
	}
	public Boolean getInsertReturn() {
		return insertReturn;
	}
	public void setInsertReturn(Boolean insertReturn) {
		this.insertReturn = insertReturn;
	}
	public String getRegex() {
		return regex;
	}
	public void setRegex(String regex) {
		this.regex = regex;
	}
	public Integer getMinLen() {
		return minLen;
	}
	public void setMinLen(Integer minLen) {
		this.minLen = minLen;
	}
	public Integer getMaxLen() {
		return maxLen;
	}
	public void setMaxLen(Integer maxLen) {
		this.maxLen = maxLen;
	}
	public Long getMin() {
		return min;
	}
	public void setMin(Long min) {
		this.min = min;
	}
	public Long getMax() {
		return max;
	}
	public Boolean getIsUUID() {
		return isUUID;
	}
	public void setIsUUID(Boolean isUUID) {
		this.isUUID = isUUID;
	}
	public void setMax(Long max) {
		this.max = max;
	}
	public String getColName() {
		return colName;
	}
	public void setColName(String colName) {
		this.colName = colName;
	}
	public String getColDesc() {
		return colDesc;
	}
	public void setColDesc(String colDesc) {
		this.colDesc = colDesc;
	}
	public Boolean getNotEmpty() {
		return notEmpty;
	}
	public void setNotEmpty(Boolean notEmpty) {
		this.notEmpty = notEmpty;
	}
	public Boolean getIsPrimaryKey() {
		return isPrimaryKey;
	}
	public void setIsPrimaryKey(Boolean isPrimaryKey) {
		this.isPrimaryKey = isPrimaryKey;
	}
	public Boolean getIsErrMsgId() {
		return isErrMsgId;
	}
	public void setIsErrMsgId(Boolean isErrMsgId) {
		this.isErrMsgId = isErrMsgId;
	}
	public Map<String, String> getEnumMap() {
		return enumMap;
	}
	public void setEnumMap(Map<String, String> enumMap) {
		this.enumMap = enumMap;
	}
}