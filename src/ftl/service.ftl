[#ftl]
[#assign sqlName="com.code.gen.BeanNameToSqlName"?new()]
package ${beanInfo.servicePackageName};
[#if beanInfo.servicePackageName!=beanInfo.packageName]
import ${beanInfo.packageName}.${beanInfo.beanName};
[/#if]
[#if beanInfo.servicePackageName!=beanInfo.mapperPackageName]
import ${beanInfo.mapperPackageName}.${beanInfo.beanName}Mapper;
[/#if]
import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
@Service("${beanInfo.beanName?uncap_first}Service")
public class ${beanInfo.beanName}Service{
	@Resource(name="${beanInfo.beanName?uncap_first}Mapper")
	private ${beanInfo.beanName}Mapper ${beanInfo.beanName?uncap_first}Mapper;
	public Long page(List<${beanInfo.beanName}> ${beanInfo.beanName?uncap_first}List,${beanInfo.beanName} ${beanInfo.beanName?uncap_first},Integer pageNum,Integer pageSize){
		${beanInfo.beanName} params=new ${beanInfo.beanName}();
		if(${beanInfo.beanName?uncap_first}!=null){
	[#list beanInfo.beanPropInfoList as beanPropInfo]
		[#if beanPropInfo.propType=='String']
			params.set${beanPropInfo.propName?cap_first}Like(StringUtils.isEmpty(${beanInfo.beanName?uncap_first}.get${beanPropInfo.propName?cap_first}Like())?null:("%"+${beanInfo.beanName?uncap_first}.get${beanPropInfo.propName?cap_first}Like()+"%"));
		[#else]
			params.setMin${beanPropInfo.propName?cap_first}(${beanInfo.beanName?uncap_first}.getMin${beanPropInfo.propName?cap_first}());
			params.setMax${beanPropInfo.propName?cap_first}(${beanInfo.beanName?uncap_first}.getMax${beanPropInfo.propName?cap_first}());
		[/#if]
	[/#list]
		}
		Long totalCount=${beanInfo.beanName?uncap_first}Mapper.selectCount(params);
		Integer maxPageNum=(int) (totalCount%pageSize==0?(totalCount/pageSize):(totalCount/pageSize+1));
		if(pageNum<1)
			pageNum=1;
		if(pageNum>maxPageNum)
			pageNum=maxPageNum;
		params.setPageNum(pageNum);
		params.setPageSize(pageSize);
		if(${beanInfo.beanName?uncap_first}List!=null)
			${beanInfo.beanName?uncap_first}List.addAll(${beanInfo.beanName?uncap_first}Mapper.select(params));
		return totalCount;
	}
}