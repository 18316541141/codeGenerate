[#ftl]
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<base href="<%=basePath%>">
		<meta charset="utf-8" />
		<title></title>
	</head>
	<body>
		<c:set var="operType" value="${"$"}{${beanInfo.beanName?uncap_first}==null?'add':'edit'}"/>
		<form id="${beanInfo.beanName?uncap_first}Form" action="<%=basePath%>${beanInfo.beanName?uncap_first}/${"$"}{operType}[#if beanInfo.requestSuffix??].${beanInfo.requestSuffix}[/#if]" method="post">
			[#list beanInfo.beanPropInfoList as beanPropInfo]
				[#if (beanPropInfo.isUUID?? && beanPropInfo.isUUID) || (beanPropInfo.autoIncrement?? && beanPropInfo.autoIncrement)]
					<input type="hidden" name="${beanPropInfo.propName}" value="${"$"}{${beanInfo.beanName?uncap_first}.${beanPropInfo.propName}}">
				[#else]
					<dl>
						<dt>${beanPropInfo.colName}:</dt>
						<dd>
							[#if beanPropInfo.propType=='Date']
								<input type="text" name="${beanPropInfo.propName}" value="<fmt:formatDate value="${"$"}{${beanInfo.beanName?uncap_first}.${beanPropInfo.propName}}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/>">
							[#elseif beanPropInfo.propType=='Enum']
								<select name="${beanPropInfo.propName}">
									<option value="">-未选择-</option>
								[#list beanPropInfo.enumMap?keys as key]
									<option value="${key}" ${"$"}{${beanInfo.beanName?uncap_first}.${beanPropInfo.propName}=='${key}'?'selected':''}>${beanPropInfo.enumMap[key]}</option>
								[/#list]
								</select>
							[#else]
								<input type="text" name="${beanPropInfo.propName}" value="${"$"}{${beanInfo.beanName?uncap_first}.${beanPropInfo.propName}}">
							[/#if]
						</dd>
					</dl>
				[/#if]
			[/#list]
			<dl>
				<dt></dt>
				<dd><button type="submit">提交</button></dd>
			</dl>
		</form>
		<form id="${beanInfo.beanName?uncap_first}AjaxForm" method="post">
			[#list beanInfo.beanPropInfoList as beanPropInfo]
				[#if (beanPropInfo.isUUID?? && beanPropInfo.isUUID) || (beanPropInfo.autoIncrement?? && beanPropInfo.autoIncrement)]
					<input type="hidden" name="${beanPropInfo.propName}">
				[/#if]
			[/#list]
			<table>
				<tbody>
					[#list beanInfo.beanPropInfoList as beanPropInfo]
						[#if (beanPropInfo.isUUID?? && beanPropInfo.isUUID) || (beanPropInfo.autoIncrement?? && beanPropInfo.autoIncrement)][#else]
							<tr>
								<td>${beanPropInfo.colName}:</td>
								<td>
									[#if beanPropInfo.propType=='Date']
										<input type="text" name="${beanPropInfo.propName}">
									[#elseif beanPropInfo.propType=='Enum']
										<select name="${beanPropInfo.propName}">
											<option value="">-未选择-</option>
										[#list beanPropInfo.enumMap?keys as key]
											<option value="${key}">${beanPropInfo.enumMap[key]}</option>
										[/#list]
										</select>
									[#else]
										<input type="text" name="${beanPropInfo.propName}">
									[/#if]
								</td>
							</tr>
						[/#if]
					[/#list]
				</tbody>
				<tfoot>
					<tr>
						<td></td>
						<td><button type="submit">提交</button></td>
					</tr>
				</tfoot>
			</table>
		</form>
		<script type="text/javascript" src="js/jquery-1.11.3.js"></script>
		<script type="text/javascript" src="js/jquery.validate.js"></script>
		<script type="text/javascript" src="js/messages_cn.js"></script>
		<script type="text/javascript" src="js/additional-methods.js"></script>
		<script type="text/javascript">
			(function(){
				$('#${beanInfo.beanName?uncap_first}AjaxForm').validate({
					onfocusout:false,
					onkeyup:false,
					onclick:false,
					rules:{
						[#assign q2=""]
						[#list beanInfo.beanPropInfoList as beanPropInfo]
							[#assign q=""]
							${q2}'${beanPropInfo.propName}':{
								[#if beanPropInfo.notEmpty?? && beanPropInfo.notEmpty]
									${q}required:true
									[#assign q=","]
								[/#if]
								[#if beanPropInfo.minLen??]
									${q}minlength:${beanPropInfo.minLen?c}
									[#assign q=","]
								[/#if]
								[#if beanPropInfo.maxLen??]
									${q}maxlength:${beanPropInfo.maxLen?c}
									[#assign q=","]
								[/#if]
								[#if beanPropInfo.min??]
									${q}min:${beanPropInfo.min?c}
									[#assign q=","]
								[/#if]
								[#if beanPropInfo.max??]
									${q}max:${beanPropInfo.max?c}
									[#assign q=","]
								[/#if]
								[#if beanPropInfo.regex??]
									${q}regexp:/${beanPropInfo.regex}/g
									[#assign q=","]
								[/#if]
							}
							[#assign q2=","]
						[/#list]
					},
					messages:{
						[#assign q2=""]
						[#list beanInfo.beanPropInfoList as beanPropInfo]
							[#assign q=""]
							${q2}'${beanPropInfo.propName}':{
								[#if beanPropInfo.notEmpty?? && beanPropInfo.notEmpty]
									${q}required:'${beanPropInfo.colName}不能为空'
									[#assign q=","]
								[/#if]
								[#if beanPropInfo.minLen??]
									${q}minlength:'${beanPropInfo.colName}长度不能小于${beanPropInfo.minLen?c}'
									[#assign q=","]
								[/#if]
								[#if beanPropInfo.maxLen??]
									${q}maxlength:'${beanPropInfo.colName}长度不能大于${beanPropInfo.maxLen?c}'
									[#assign q=","]
								[/#if]
								[#if beanPropInfo.min??]
									${q}min:'${beanPropInfo.colName}不能小于${beanPropInfo.min?c}'
									[#assign q=","]
								[/#if]
								[#if beanPropInfo.max??]
									${q}max:'${beanPropInfo.colName}不能大于${beanPropInfo.max?c}'
									[#assign q=","]
								[/#if]
								[#if beanPropInfo.regex??]
									${q}regexp:'${beanPropInfo.colName}格式错误'
									[#assign q=","]
								[/#if]
							}
							[#assign q2=","]
						[/#list]
					},
					errorPlacement:function(error,element){
						error.appendTo($(element).next());
					},
					submitHandler:function(form){
						$.post('<%=basePath%>${beanInfo.beanName?uncap_first}/${"$"}{${beanInfo.beanName?uncap_first}==null?'addAjax':'editAjax'}[#if beanInfo.requestSuffix??].${beanInfo.requestSuffix}[/#if]',
						{[#assign q=""]
						[#list beanInfo.beanPropInfoList as beanPropInfo]
							${q}'${beanPropInfo.propName}':form['${beanPropInfo.propName}'].value
							[#assign q=","]
						[/#list]
						},function(result){
							if(result.code===0)
								location.href='<%=basePath%>${beanInfo.beanName?uncap_first}/list[#if beanInfo.requestSuffix??].${beanInfo.requestSuffix}[/#if]';
							else
								alert(result.${resultInfo.resultMsgPropName});
						},'json');
					}
				});
			}());
			$.post('<%=basePath%>${beanInfo.beanName?uncap_first}/toEditAjax[#if beanInfo.requestSuffix??].${beanInfo.requestSuffix}[/#if]',{
				[#assign q=""]
				[#list beanInfo.beanPropInfoList as beanPropInfo]
					[#if beanPropInfo.isPrimaryKey?? && beanPropInfo.isPrimaryKey]
						${q}'${beanPropInfo.propName}':'${"$"}{${beanInfo.beanName?uncap_first}.${beanPropInfo.propName}}'
						[#assign q=","]
					[/#if]
				[/#list]
			},function(result){
				var data=result.${resultInfo.resultDataPropName};
				var form=$('#${beanInfo.beanName?uncap_first}AjaxForm').get(0);
				form.reset();
				[#list beanInfo.beanPropInfoList as beanPropInfo]
					[#if beanPropInfo.propType=='Enum']
						for(int i=0,options=form['${beanPropInfo.propName}'].options,len=options.length;i<len;i++){
							if(options[i].value===data['${beanPropInfo.propName}']){
								form['${beanPropInfo.propName}'].selectedIndex=i;
								break;
							}
						}
					[#else]
						form['${beanPropInfo.propName}'].value=data['${beanPropInfo.propName}'];
					[/#if]
				[/#list]
			},'json');
		</script>
	</body>
</html>