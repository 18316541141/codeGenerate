package com.code.gen;
import java.io.File;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import org.apache.commons.lang3.StringUtils;
public class SpringMvcMybatisFramework implements Framework{
	private BeanInfo beanInfo;
	private ResultInfo resultInfo;
	private String root;
	@Override
	public synchronized String getRootPath() {
		if(root==null)
			root="temp"+File.separator+UUID.randomUUID().toString();
		return root;
	}
	@Override
	public Map<String, String> getPathAndTemplate() {
		Map<String,String> pathAndTemplateMap=new HashMap<String,String>();
		pathAndTemplateMap.put(getRootPath()+File.separator+StringUtils.join(beanInfo.getPackageName().split("\\."), File.separator)+File.separator+beanInfo.getBeanName()+".java", "bean.ftl");
		pathAndTemplateMap.put(getRootPath()+File.separator+StringUtils.uncapitalize(beanInfo.getBeanName())+File.separator+StringUtils.uncapitalize(beanInfo.getBeanName())+"_list.jsp", "jsp_list.ftl");
		pathAndTemplateMap.put(getRootPath()+File.separator+StringUtils.uncapitalize(beanInfo.getBeanName())+File.separator+StringUtils.uncapitalize(beanInfo.getBeanName())+"_edit.jsp", "jsp_add_edit.ftl");
		pathAndTemplateMap.put(getRootPath()+File.separator+StringUtils.join(beanInfo.getCtrlPackageName().split("\\."), File.separator)+File.separator+beanInfo.getBeanName()+"Controller.java", "ctrl.ftl");
		
		pathAndTemplateMap.put(getRootPath()+File.separator+StringUtils.join(beanInfo.getCtrlPackageName().split("\\."), File.separator)+File.separator+"DelGroup.java", "delGroup.ftl");
		pathAndTemplateMap.put(getRootPath()+File.separator+StringUtils.join(beanInfo.getCtrlPackageName().split("\\."), File.separator)+File.separator+"AddGroup.java", "addGroup.ftl");
		pathAndTemplateMap.put(getRootPath()+File.separator+StringUtils.join(beanInfo.getCtrlPackageName().split("\\."), File.separator)+File.separator+"EditGroup.java", "editGroup.ftl");
		pathAndTemplateMap.put(getRootPath()+File.separator+StringUtils.join(beanInfo.getCtrlPackageName().split("\\."), File.separator)+File.separator+"ToEditGroup.java", "toEditGroup.ftl");
		
		pathAndTemplateMap.put(getRootPath()+File.separator+StringUtils.join(beanInfo.getServicePackageName().split("\\."), File.separator)+File.separator+beanInfo.getBeanName()+"Service.java", "service.ftl");
		pathAndTemplateMap.put(getRootPath()+File.separator+StringUtils.join(beanInfo.getMapperPackageName().split("\\."), File.separator)+File.separator+beanInfo.getBeanName()+"Mapper.java", "mapper.ftl");
		pathAndTemplateMap.put(getRootPath()+File.separator+StringUtils.join(beanInfo.getMapperXmlPackageName().split("\\."), File.separator)+File.separator+beanInfo.getBeanName()+"Mapper.xml", "mapperXml.ftl");
		pathAndTemplateMap.put(getRootPath()+File.separator+StringUtils.join(resultInfo.getResultPackageName().split("\\."), File.separator)+File.separator+resultInfo.getClassName()+".java", "result.ftl");
		pathAndTemplateMap.put(getRootPath()+File.separator+"sql"+File.separator+"oracle_sql.sql", "oracle.ftl");
		pathAndTemplateMap.put(getRootPath()+File.separator+StringUtils.join(beanInfo.getCtrlPackageName().split("\\."), File.separator)+File.separator+beanInfo.getBeanName()+"FormData.java", "formData.ftl");
		return pathAndTemplateMap;
	}
	@Override
	public Map<String, Object> getData() {
		Map<String, Object> retMap=new HashMap<String, Object>();
		retMap.put("beanInfo", beanInfo);
		retMap.put("resultInfo", resultInfo);
		return retMap;
	}
	public BeanInfo getBeanInfo() {
		return beanInfo;
	}
	public void setBeanInfo(BeanInfo beanInfo) {
		this.beanInfo = beanInfo;
	}
	public ResultInfo getResultInfo() {
		return resultInfo;
	}
	public void setResultInfo(ResultInfo resultInfo) {
		this.resultInfo = resultInfo;
	}
}