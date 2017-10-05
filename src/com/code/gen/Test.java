package com.code.gen;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import com.ctrl.Ctrl;
import net.lingala.zip4j.exception.ZipException;
public class Test {
	public static void main(String[] args) throws ZipException, IOException {
		BeanInfo beanInfo=new BeanInfo();
		beanInfo.setBeanName("DeptManager");
		beanInfo.setPackageName("com.xxx");
		beanInfo.setCtrlPackageName("com.ctrl");
		beanInfo.setServicePackageName("com.service");
		beanInfo.setMapperPackageName("com.mapper");
		beanInfo.setMapperXmlPackageName("com.mapper.xml");
		beanInfo.setRequestSuffix("html");
		
		BeanPropInfo dmId=new BeanPropInfo();
		dmId.setPropName("dmId");
		dmId.setPropType("String");
		dmId.setIsUUID(true);
		dmId.setColName("部门ID");
		dmId.setColDesc("全局唯一的部门id");
		dmId.setIsPrimaryKey(true);
		dmId.setMinLen(32);
		dmId.setMaxLen(32);
		dmId.setNotEmpty(true);
		dmId.setRegex("[a-z\\d]{32}");
		
		BeanPropInfo dmDeptName=new BeanPropInfo();
		dmDeptName.setPropName("dmDeptName");
		dmDeptName.setPropType("String");
		dmDeptName.setColName("部门名");
		dmDeptName.setColDesc("部门名称");
		dmDeptName.setIsErrMsgId(true);
		dmDeptName.setMinLen(2);
		dmDeptName.setMaxLen(20);
		dmDeptName.setNotEmpty(true);
		dmDeptName.setRegex("[\\w\\u4E00-\\u9FA5]{2,20}");
		
		BeanPropInfo dmParentId=new BeanPropInfo();
		dmParentId.setPropName("dmParentId");
		dmParentId.setPropType("String");
		dmParentId.setColName("上级部门");
		dmParentId.setColDesc("上级部门的ID");
		dmParentId.setMinLen(32);
		dmParentId.setMaxLen(32);
		dmParentId.setRegex("[a-z\\d]{32}");
		
		BeanPropInfo dmIsEnable=new BeanPropInfo();
		dmIsEnable.setPropName("dmIsEnable");
		dmIsEnable.setPropType("Integer");
		dmIsEnable.setColName("状态");
		dmIsEnable.setColDesc("部门的状态:0停用，1启用");
		dmIsEnable.setMin(0L);
		dmIsEnable.setMax(1L);
		dmIsEnable.setNotEmpty(true);
		
		BeanPropInfo dmCreateTime=new BeanPropInfo();
		dmCreateTime.setPropName("dmCreateTime");
		dmCreateTime.setPropType("Date");
		dmCreateTime.setColName("创建日期");
		dmCreateTime.setColDesc("部门的创建日期，格式yyyy-MM-dd HH:mm:ss");
		dmCreateTime.setNotEmpty(true);
		
		BeanPropInfo dmSortIndex=new BeanPropInfo();
		dmSortIndex.setPropName("dmSortIndex");
		dmSortIndex.setPropType("Integer");
		dmSortIndex.setColName("序号");
		dmSortIndex.setColDesc("部门在列表中排序依据");
		dmSortIndex.setNotEmpty(true);
		dmSortIndex.setMin(-9999L);
		dmSortIndex.setMax(9999L);
		
		List<BeanPropInfo> beanPropInfoList=new ArrayList<BeanPropInfo>();
		beanPropInfoList.add(dmId);
		beanPropInfoList.add(dmDeptName);
		beanPropInfoList.add(dmParentId);
		beanPropInfoList.add(dmIsEnable);
		beanPropInfoList.add(dmCreateTime);
		beanPropInfoList.add(dmSortIndex);
		beanInfo.setBeanPropInfoList(beanPropInfoList);
		
		ResultInfo resultInfo=new ResultInfo();
		resultInfo.setClassName("Result");
		resultInfo.setResultPackageName("com.xxx");
		resultInfo.setResultCodePropName("code");
		resultInfo.setResultDataPropName("data");
		resultInfo.setResultMsgPropName("msg");
		new Ctrl().codeGen(beanInfo, resultInfo);
	}
}