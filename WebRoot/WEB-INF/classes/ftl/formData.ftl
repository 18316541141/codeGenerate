[#ftl]
package ${beanInfo.ctrlPackageName};
[#if beanInfo.ctrlPackageName!=beanInfo.packageName]
import ${beanInfo.packageName}.${beanInfo.beanName};
[/#if]
import javax.validation.Valid;
import java.util.List;
public class ${beanInfo.beanName}FormData{
	@Valid
	private List<${beanInfo.beanName}> ${beanInfo.beanName?uncap_first}List;
	public void set${beanInfo.beanName?cap_first}List(List<${beanInfo.beanName}> ${beanInfo.beanName?uncap_first}List){
		this.${beanInfo.beanName?uncap_first}List=${beanInfo.beanName?uncap_first}List;
	}
	public List<${beanInfo.beanName}> get${beanInfo.beanName?cap_first}List(){
		return ${beanInfo.beanName?uncap_first}List;
	}
}