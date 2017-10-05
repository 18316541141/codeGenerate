[#ftl]
package ${beanInfo.mapperPackageName};
[#if beanInfo.mapperPackageName!=beanInfo.packageName]
import ${beanInfo.packageName}.${beanInfo.beanName};
[/#if]
import java.util.Date;
import java.util.List;
import org.apache.ibatis.annotations.Param;
public interface ${beanInfo.beanName}Mapper{
	List<${beanInfo.beanName}> select(${beanInfo.beanName} ${beanInfo.beanName?uncap_first});
	Long delete(${beanInfo.beanName} ${beanInfo.beanName?uncap_first});
	[#assign r="void"]
	[#list beanInfo.beanPropInfoList as beanPropInfo]
		[#if beanPropInfo.insertReturn?? && beanPropInfo.insertReturn]
			[#assign r=beanPropInfo.propType]
		[/#if]
	[/#list]
	${r} insert(${beanInfo.beanName} ${beanInfo.beanName?uncap_first});
	[#assign q=""]
	Long updateByKey(${beanInfo.beanName} ${beanInfo.beanName?uncap_first});
	[#assign q=""]
	${beanInfo.beanName} selectByKey(
		[#list beanInfo.beanPropInfoList as beanPropInfo]
			[#if beanPropInfo.isPrimaryKey?? && beanPropInfo.isPrimaryKey]
				@Param("${beanPropInfo.propName}") ${q}${beanPropInfo.propType} ${beanPropInfo.propName}
				[#assign q=","]
			[/#if]
		[/#list]
	);
	[#assign q=""]
	Long deleteByKey(
		[#list beanInfo.beanPropInfoList as beanPropInfo]
			[#if beanPropInfo.isPrimaryKey?? && beanPropInfo.isPrimaryKey]
				@Param("${beanPropInfo.propName}") ${q}${beanPropInfo.propType} ${beanPropInfo.propName}
				[#assign q=","]
			[/#if]
		[/#list]
	);
	Long selectCount(${beanInfo.beanName} ${beanInfo.beanName?uncap_first});
}