[#ftl]
package ${beanInfo.packageName};
import java.io.Serializable;
import java.util.Date;
import org.hibernate.validator.constraints.Length;
import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.URL;
import javax.validation.constraints.Min;
import javax.validation.constraints.Max;
import javax.validation.constraints.Pattern;
import ${beanInfo.ctrlPackageName}.DelGroup;
import ${beanInfo.ctrlPackageName}.AddGroup;
import javax.validation.constraints.Size;
import ${beanInfo.ctrlPackageName}.EditGroup;
import ${beanInfo.ctrlPackageName}.ToEditGroup;
import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;
public class ${beanInfo.beanName} implements Serializable{
[#list beanInfo.beanPropInfoList as beanPropInfo]
[#if beanPropInfo.propType=='Date']
	@DateTimeFormat(pattern="yyyy-HH-dd HH:mm:ss")
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
[/#if]
[#if beanPropInfo.notEmpty?? && beanPropInfo.notEmpty]
	[#if beanPropInfo.propType=='String']@NotBlank[#else]@NotNull[/#if]
	(message="${beanPropInfo.colName}不能为空",groups={
		[#if beanPropInfo.isPrimaryKey?? && beanPropInfo.isPrimaryKey]
			ToEditGroup.class,DelGroup.class,EditGroup.class,
			[#if (beanPropInfo.isUUID?? && beanPropInfo.isUUID) || (beanPropInfo.autoIncrement?? && beanPropInfo.autoIncrement)][#else]
				AddGroup.class,
			[/#if]
		[#else]AddGroup.class,[/#if]
	})
[/#if]
[#if beanPropInfo.regex?? && beanPropInfo.regex!='']
	@Pattern(message="${beanPropInfo.colName}格式错误",regexp="${beanPropInfo.regex?replace("\\","\\\\")}",
	groups={ToEditGroup.class,EditGroup.class,DelGroup.class,AddGroup.class,})
[/#if]
[#if beanPropInfo.minLen?? && beanPropInfo.maxLen??]
	@Size(message="${beanPropInfo.colName}的长度必须在${beanPropInfo.minLen}到${beanPropInfo.maxLen}之间",max=${beanPropInfo.maxLen?c},min=${beanPropInfo.minLen?c},
	groups={ToEditGroup.class,EditGroup.class,DelGroup.class,AddGroup.class,})
[/#if]
[#if beanPropInfo.min??]
	@Min(message="${beanPropInfo.colName}不能少于${beanPropInfo.min}",value=${beanPropInfo.min?c},
	groups={ToEditGroup.class,EditGroup.class,DelGroup.class,AddGroup.class,})
[/#if]
[#if beanPropInfo.max??]
	@Max(message="${beanPropInfo.colName}不能大于${beanPropInfo.max}",value=${beanPropInfo.max?c},
	groups={ToEditGroup.class,EditGroup.class,DelGroup.class,AddGroup.class,})
[/#if]
	private ${beanPropInfo.propType} ${beanPropInfo.propName};
	public void set${beanPropInfo.propName?cap_first}(${beanPropInfo.propType} ${beanPropInfo.propName}){
		this.${beanPropInfo.propName}=${beanPropInfo.propName};
	}
	public ${beanPropInfo.propType} get${beanPropInfo.propName?cap_first}(){
		return this.${beanPropInfo.propName};
	}
[#if beanPropInfo.propType=='String']
	private ${beanPropInfo.propType} ${beanPropInfo.propName}Like;
	public void set${beanPropInfo.propName?cap_first}Like(${beanPropInfo.propType} ${beanPropInfo.propName}Like){
		this.${beanPropInfo.propName}Like=${beanPropInfo.propName}Like;
	}
	public ${beanPropInfo.propType} get${beanPropInfo.propName?cap_first}Like(){
		return this.${beanPropInfo.propName}Like;
	}
[#elseif beanPropInfo.propType=='Enum']
	public static enum ${beanPropInfo.propName?cap_first}{
	[#list beanPropInfo.enumMap?keys as key]${key},[/#list]
	}
	private ${beanPropInfo.propName?cap_first} ${beanPropInfo.propName};
	public void set${beanPropInfo.propName?cap_first}(${beanPropInfo.propName?cap_first} ${beanPropInfo.propName}){
		this.${beanPropInfo.propName}=${beanPropInfo.propName};
	}
	public ${beanPropInfo.propName?cap_first} get${beanPropInfo.propName?cap_first}(){
		return this.${beanPropInfo.propName};
	}
[#else]
	[#if beanPropInfo.propType=='Date']@DateTimeFormat(pattern="yyyy-HH-dd HH:mm:ss")[/#if]
	private ${beanPropInfo.propType} min${beanPropInfo.propName?cap_first};
	[#if beanPropInfo.propType=='Date']@DateTimeFormat(pattern="yyyy-HH-dd HH:mm:ss")[/#if]
	private ${beanPropInfo.propType} max${beanPropInfo.propName?cap_first};
	public void setMin${beanPropInfo.propName?cap_first}(${beanPropInfo.propType} min${beanPropInfo.propName?cap_first}){
		this.min${beanPropInfo.propName?cap_first}=min${beanPropInfo.propName?cap_first};
	}
	public ${beanPropInfo.propType} getMin${beanPropInfo.propName?cap_first}(){
		return this.min${beanPropInfo.propName?cap_first};
	}
	public void setMax${beanPropInfo.propName?cap_first}(${beanPropInfo.propType} max${beanPropInfo.propName?cap_first}){
		this.max${beanPropInfo.propName?cap_first}=max${beanPropInfo.propName?cap_first};
	}
	public ${beanPropInfo.propType} getMax${beanPropInfo.propName?cap_first}(){
		return this.max${beanPropInfo.propName?cap_first};
	}
[/#if]
[/#list]
	private Integer pageNum;
	public void setPageNum(Integer pageNum){
		this.pageNum=pageNum;
	}
	public Integer getPageNum(){
		return pageNum;
	}
	private Integer pageSize;
	public void setPageSize(Integer pageSize){
		this.pageSize=pageSize;
	}
	public Integer getPageSize(){
		return pageSize;
	}
}