[#ftl]
package ${beanInfo.ctrlPackageName};
[#if beanInfo.ctrlPackageName!=beanInfo.packageName]
import ${beanInfo.packageName}.${beanInfo.beanName};
[/#if]
[#if beanInfo.ctrlPackageName!=beanInfo.mapperPackageName]
import ${beanInfo.mapperPackageName}.${beanInfo.beanName}Mapper;
[/#if]
[#if beanInfo.ctrlPackageName!=beanInfo.servicePackageName]
import ${beanInfo.servicePackageName}.${beanInfo.beanName}Service;
[/#if]
import org.springframework.validation.annotation.Validated;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.HashSet;
import org.apache.commons.lang3.StringUtils;
import javax.annotation.Resource;
import java.util.UUID;
import org.springframework.validation.FieldError;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.validation.BindingResult;
import org.springframework.ui.Model;
import ${resultInfo.resultPackageName}.${resultInfo.className};
@Controller
@RequestMapping("/${beanInfo.beanName?uncap_first}")
public class ${beanInfo.beanName}Controller{
	@Resource(name="${beanInfo.beanName?uncap_first}Mapper")
	private ${beanInfo.beanName}Mapper ${beanInfo.beanName?uncap_first}Mapper;
	@Resource(name="${beanInfo.beanName?uncap_first}Service")
	private ${beanInfo.beanName}Service ${beanInfo.beanName?uncap_first}Service;
	@ResponseBody
	@RequestMapping("/listAjax")
	public ${resultInfo.className} listAjax(${resultInfo.className} ${resultInfo.className?uncap_first},${beanInfo.beanName} ${beanInfo.beanName?uncap_first},Integer pageNum,Integer pageSize,BindingResult bindingResult){
		if(hasErr(bindingResult))
			${resultInfo.className?uncap_first}._${resultInfo.resultMsgPropName}_${resultInfo.resultCodePropName}(errorMsg(bindingResult),-1);
		else{
			try{
				List<${beanInfo.beanName}> ${beanInfo.beanName?uncap_first}List;
				Map<String,Object> dataMap=new HashMap<String,Object>();
				dataMap.put("pageNum",pageNum=(pageNum==null?1:pageNum));
				dataMap.put("pageSize",pageSize=(pageSize==null?10:pageSize));
				dataMap.put("totalCount",${beanInfo.beanName?uncap_first}Service.page(${beanInfo.beanName?uncap_first}List=new ArrayList<${beanInfo.beanName}>(),${beanInfo.beanName?uncap_first},pageNum,pageSize));
				dataMap.put("${beanInfo.beanName?uncap_first}List",${beanInfo.beanName?uncap_first}List);
				${resultInfo.className?uncap_first}._${resultInfo.resultMsgPropName}_${resultInfo.resultCodePropName}("success",0).
				set${resultInfo.resultDataPropName?cap_first}(dataMap);
			}catch(Exception e){
				${resultInfo.className?uncap_first}._${resultInfo.resultMsgPropName}_${resultInfo.resultCodePropName}(e.getMessage(),-1);
			}
		}
		return ${resultInfo.className?uncap_first};
	}
	@RequestMapping("/list")
	public String list(${beanInfo.beanName} ${beanInfo.beanName?uncap_first},Model model,Integer pageNum,Integer pageSize,BindingResult bindingResult){
		if(hasErr(bindingResult))
			throw new RuntimeException(errorMsg(bindingResult));
		List<${beanInfo.beanName}> ${beanInfo.beanName?uncap_first}List;
		model.addAttribute("pageNum",pageNum=(pageNum==null?1:pageNum));
		model.addAttribute("pageSize",pageSize=(pageSize==null?10:pageSize));
		model.addAttribute("totalCount",${beanInfo.beanName?uncap_first}Service.page(${beanInfo.beanName?uncap_first}List=new ArrayList<${beanInfo.beanName}>(),${beanInfo.beanName?uncap_first},pageNum,pageSize));
		model.addAttribute("${beanInfo.beanName?uncap_first}List",${beanInfo.beanName?uncap_first}List);
		model.addAttribute("${beanInfo.beanName?uncap_first}",${beanInfo.beanName?uncap_first});
		return "${beanInfo.beanName?uncap_first}/${beanInfo.beanName?uncap_first}_list";
	}
	@ResponseBody
	@RequestMapping("/toEditAjax")
	public ${resultInfo.className} toEditAjax(${resultInfo.className} ${resultInfo.className?uncap_first},
	@Validated(ToEditGroup.class) ${beanInfo.beanName} ${beanInfo.beanName?uncap_first},BindingResult bindingResult){
		if(hasErr(bindingResult))
			${resultInfo.className?uncap_first}._${resultInfo.resultMsgPropName}_${resultInfo.resultCodePropName}(errorMsg(bindingResult),-1);
		else{
			try{
				${resultInfo.className?uncap_first}._${resultInfo.resultMsgPropName}_${resultInfo.resultCodePropName}("success",0)
				.set${resultInfo.resultDataPropName?cap_first}(${beanInfo.beanName?uncap_first}Mapper.selectByKey(
				[#assign q=""]
				[#list beanInfo.beanPropInfoList as beanPropInfo]
					[#if beanPropInfo.isPrimaryKey?? && beanPropInfo.isPrimaryKey]
						${q}${beanInfo.beanName?uncap_first}.get${beanPropInfo.propName?cap_first}()
						[#assign q=","]
					[/#if]
				[/#list]));
			}catch(Exception e){
				${resultInfo.className?uncap_first}._${resultInfo.resultMsgPropName}_${resultInfo.resultCodePropName}(e.getMessage(),-1);
			}
		}
		return ${resultInfo.className?uncap_first};
	}
	@RequestMapping("/toEdit")
	public String toEdit(Model model,@Validated(ToEditGroup.class) ${beanInfo.beanName} ${beanInfo.beanName?uncap_first},BindingResult bindingResult){
		if(hasErr(bindingResult))
			throw new RuntimeException(errorMsg(bindingResult));
		model.addAttribute("${beanInfo.beanName?uncap_first}",${beanInfo.beanName?uncap_first}Mapper.selectByKey(
		[#assign q=""]
		[#list beanInfo.beanPropInfoList as beanPropInfo]
			[#if beanPropInfo.isPrimaryKey?? && beanPropInfo.isPrimaryKey]
				${q}${beanInfo.beanName?uncap_first}.get${beanPropInfo.propName?cap_first}()
				[#assign q=","]
			[/#if]
		[/#list]));
		return "${beanInfo.beanName?uncap_first}/${beanInfo.beanName?uncap_first}_edit";
	}
	@ResponseBody
	@RequestMapping("/editAjax")
	public ${resultInfo.className} editAjax(${resultInfo.className} ${resultInfo.className?uncap_first},@Validated(EditGroup.class) ${beanInfo.beanName} ${beanInfo.beanName?uncap_first},BindingResult bindingResult){
		if(hasErr(bindingResult))
			${resultInfo.className?uncap_first}._${resultInfo.resultMsgPropName}_${resultInfo.resultCodePropName}(errorMsg(bindingResult),-1);
		else{
			try{
				${beanInfo.beanName?uncap_first}Mapper.updateByKey(${beanInfo.beanName?uncap_first});
				${resultInfo.className?uncap_first}._${resultInfo.resultMsgPropName}_${resultInfo.resultCodePropName}("success",0);
			}catch(Exception e){
				${resultInfo.className?uncap_first}._${resultInfo.resultMsgPropName}_${resultInfo.resultCodePropName}(e.getMessage(),-1);
			}
		}
		return ${resultInfo.className?uncap_first};
	}
	@RequestMapping("/edit")
	public String edit(@Validated(EditGroup.class) ${beanInfo.beanName} ${beanInfo.beanName?uncap_first},BindingResult bindingResult){
		if(hasErr(bindingResult))
			throw new RuntimeException(errorMsg(bindingResult));
		${beanInfo.beanName?uncap_first}Mapper.updateByKey(${beanInfo.beanName?uncap_first});
		return "redirect:/${beanInfo.beanName?uncap_first}/list[#if beanInfo.requestSuffix??].${beanInfo.requestSuffix}[/#if]";
	}
	@RequestMapping("/toAdd")
	public String toAdd(){
		return "${beanInfo.beanName?uncap_first}/${beanInfo.beanName?uncap_first}_edit";
	}
	@ResponseBody
	@RequestMapping("/addAjax")
	public ${resultInfo.className} addAjax(${resultInfo.className} ${resultInfo.className?uncap_first},@Validated(AddGroup.class) ${beanInfo.beanName} ${beanInfo.beanName?uncap_first},BindingResult bindingResult){
		if(hasErr(bindingResult))
			${resultInfo.className?uncap_first}._${resultInfo.resultMsgPropName}_${resultInfo.resultCodePropName}(errorMsg(bindingResult),-1);
		else{
			try{
				${beanInfo.beanName?uncap_first}Mapper.insert(${beanInfo.beanName?uncap_first});
				${resultInfo.className?uncap_first}._${resultInfo.resultMsgPropName}_${resultInfo.resultCodePropName}("success",0);
			}catch(Exception e){
				${resultInfo.className?uncap_first}._${resultInfo.resultMsgPropName}_${resultInfo.resultCodePropName}(e.getMessage(),-1);
			}
		}
		return ${resultInfo.className?uncap_first};
	}
	@RequestMapping("/add")
	public String add(@Validated(AddGroup.class) ${beanInfo.beanName} ${beanInfo.beanName?uncap_first},BindingResult bindingResult){
		if(hasErr(bindingResult))
			throw new RuntimeException(errorMsg(bindingResult));
		[#list beanInfo.beanPropInfoList as beanPropInfo]
			[#if beanPropInfo.isUUID?? && beanPropInfo.isUUID]
				${beanInfo.beanName?uncap_first}.set${beanPropInfo.propName?cap_first}(get32UUID());
			[/#if]
		[/#list]
		${beanInfo.beanName?uncap_first}Mapper.insert(${beanInfo.beanName?uncap_first});
		return "redirect:/${beanInfo.beanName?uncap_first}/list[#if beanInfo.requestSuffix??].${beanInfo.requestSuffix}[/#if]";
	}
	@RequestMapping("/del")
	public String del(@Validated(DelGroup.class) ${beanInfo.beanName}FormData formData,BindingResult bindingResult){
		if(hasErr(bindingResult))
			throw new RuntimeException(errorMsg(bindingResult));
		if(formData.get${beanInfo.beanName?cap_first}List()!=null){
			StringBuilder msg=new StringBuilder();
			for(${beanInfo.beanName} ${beanInfo.beanName?uncap_first}:formData.get${beanInfo.beanName?cap_first}List()){
				try{
					[#assign q=""]
					${beanInfo.beanName?uncap_first}Mapper.deleteByKey(
					[#list beanInfo.beanPropInfoList as beanPropInfo]
						[#if beanPropInfo.isPrimaryKey?? && beanPropInfo.isPrimaryKey]
							${q}${beanInfo.beanName?uncap_first}.get${beanPropInfo.propName?cap_first}()
							[#assign q=","]
						[/#if]
					[/#list]);
				}catch(Exception e){
					[#list beanInfo.beanPropInfoList as beanPropInfo]
						[#if beanPropInfo.isErrMsgId?? && beanPropInfo.isErrMsgId]
							msg.append("\"${beanPropInfo.colName}\"删除时出错，错误原因：").append(e.getMessage());
						[/#if]
					[/#list]
				}
			}
			if(msg.length()>0)
				throw new RuntimeException(msg.toString());
		}
		return "redirect:/${beanInfo.beanName?uncap_first}/list[#if beanInfo.requestSuffix??].${beanInfo.requestSuffix}[/#if]";
	}
	@ResponseBody
	@RequestMapping("/delAjax")
	public ${resultInfo.className} delAjax(@Validated(DelGroup.class) ${resultInfo.className} ${resultInfo.className?uncap_first},${beanInfo.beanName}FormData formData,BindingResult bindingResult){
		if(hasErr(bindingResult))
			${resultInfo.className?uncap_first}._${resultInfo.resultMsgPropName}_${resultInfo.resultCodePropName}(errorMsg(bindingResult),-1);
		else{
			StringBuilder msg=new StringBuilder();
			if(formData.get${beanInfo.beanName?cap_first}List()!=null){
				for(${beanInfo.beanName} ${beanInfo.beanName?uncap_first}:formData.get${beanInfo.beanName?cap_first}List()){
					try{
						[#assign q=""]
						${beanInfo.beanName?uncap_first}Mapper.deleteByKey(
						[#list beanInfo.beanPropInfoList as beanPropInfo]
							[#if beanPropInfo.isPrimaryKey?? && beanPropInfo.isPrimaryKey]
								${q}${beanInfo.beanName?uncap_first}.get${beanPropInfo.propName?cap_first}()
								[#assign q=","]
							[/#if]
						[/#list]);
					}catch(Exception e){
						[#list beanInfo.beanPropInfoList as beanPropInfo]
							[#if beanPropInfo.isErrMsgId?? && beanPropInfo.isErrMsgId]
								msg.append("\"${beanPropInfo.colName}\"删除时出错，错误原因：").append(e.getMessage());
							[/#if]
						[/#list]
					}
				}
			}
			if(msg.length()==0)
				${resultInfo.className?uncap_first}._${resultInfo.resultMsgPropName}_${resultInfo.resultCodePropName}("success",0);
			else
				${resultInfo.className?uncap_first}._${resultInfo.resultMsgPropName}_${resultInfo.resultCodePropName}(msg.toString(),-1);
		}
		return ${resultInfo.className?uncap_first};
	}
	/**
	 * @param 表单校验的结果
	 * @return 输出表单校验的错误消息
	 */
	@RequestMapping("/toExcel")
	public String toExcel(Model model,@Validated ${beanInfo.beanName} ${beanInfo.beanName?uncap_first}){
		List<List<Object>> datas=new ArrayList<List<Object>>();
		List<Object> row; 
		for(${beanInfo.beanName} ret:${beanInfo.beanName?uncap_first}Mapper.select(${beanInfo.beanName?uncap_first})){
			row=new ArrayList<Object>();
		[#list beanInfo.beanPropInfoList as beanPropInfo]
			row.add(ret.get${beanPropInfo.propName?cap_first}());
		[/#list]
			datas.add(row);
		}
		model.addAttribute("datas",datas);
		List<String> titles=new ArrayList<String>();
	[#list beanInfo.beanPropInfoList as beanPropInfo]
		titles.add("${beanPropInfo.colName}");
	[/#list]
		model.addAttribute("titles",titles);
		return "exportExcelView";
	}
	private boolean hasErr(BindingResult bindingResult){
		Set<String> codes=new HashSet<String>();
		codes.add("NotEmpty");
		codes.add("NotBlank");
		codes.add("NotNull");
		int ignore=0;
		for(FieldError fieldError:bindingResult.getFieldErrors()){
			if(!codes.contains(fieldError.getCode()) && (fieldError.getRejectedValue()==null || StringUtils.isEmpty(fieldError.getRejectedValue().toString())))
				ignore++;	
		}
		return bindingResult.getFieldErrors().size()-ignore>0;
	}
	/**
	 * @param 表单校验的结果
	 * @return 输出表单校验的错误消息
	 */
	private String errorMsg(BindingResult bindingResult){
		Set<String> codes=new HashSet<String>();
		codes.add("NotEmpty");
		codes.add("NotBlank");
		codes.add("NotNull");
		StringBuilder errorMsg=new StringBuilder("发生错误：");
		for(FieldError fieldError:bindingResult.getFieldErrors()){
			if(!(!codes.contains(fieldError.getCode()) && (fieldError.getRejectedValue()==null || StringUtils.isEmpty(fieldError.getRejectedValue().toString())))){
				errorMsg.append(" 出错参数：").append(fieldError.getField()).append
				("，出错原因：").append(fieldError.getDefaultMessage()).append("");
			}
		}
		return errorMsg.toString();
	}
	private String get32UUID(){
		return UUID.randomUUID().toString().trim().replaceAll("-", "");
	}
}