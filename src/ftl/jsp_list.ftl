[#ftl]
[#assign sqlName="com.code.gen.BeanNameToSqlName"?new()]
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
		<dl>
			<dt>这是通过jsp生成的"[@sqlName transName=beanInfo.beanName/]"表的分页数据</dt>
			<dd>
				<form id="${beanInfo.beanName?uncap_first}Form" method="post" action="<%=basePath%>${beanInfo.beanName?uncap_first}/list[#if beanInfo.requestSuffix??].${beanInfo.requestSuffix}[/#if]">
					[#list beanInfo.beanPropInfoList as beanPropInfo]
						[#if beanPropInfo.propType=='String']
							${beanPropInfo.colName}:<input name="${beanPropInfo.propName}Like" value="${"$"}{${beanInfo.beanName?uncap_first}.${beanPropInfo.propName}Like}"><br/>
						[#else]
							最小${beanPropInfo.colName}:<input name="min${beanPropInfo.propName?cap_first}" value="${"$"}{${beanInfo.beanName?uncap_first}.min${beanPropInfo.propName?cap_first}}"><br/>
							最大${beanPropInfo.colName}:<input name="max${beanPropInfo.propName?cap_first}" value="${"$"}{${beanInfo.beanName?uncap_first}.max${beanPropInfo.propName?cap_first}}"><br/>
						[/#if]
					[/#list]
					<button type="button" onclick="toPage(1);">查询</button>
					<a href="<%=basePath%>${beanInfo.beanName?uncap_first}/toAdd[#if beanInfo.requestSuffix??].${beanInfo.requestSuffix}[/#if]">添加</a>
					<table>
						<thead>
							<tr>
								[#list beanInfo.beanPropInfoList as beanPropInfo]
									<th>${beanPropInfo.colName}</th>
								[/#list]
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${"$"}{${beanInfo.beanName?uncap_first}List}" var="${beanInfo.beanName?uncap_first}" varStatus="index">
								<tr>
									[#list beanInfo.beanPropInfoList as beanPropInfo]
										<td>
										[#if beanPropInfo.propType=='Date']
											<fmt:formatDate value="${"$"}{${beanInfo.beanName?uncap_first}.${beanPropInfo.propName}}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/>
										[#else]
											${"$"}{${beanInfo.beanName?uncap_first}.${beanPropInfo.propName}}
										[/#if]
										</td>
									[/#list]
									<td>
										<a href="javascript:del(
										[#assign q=""]
										[#list beanInfo.beanPropInfoList as beanPropInfo]
											[#if beanPropInfo.isPrimaryKey?? && beanPropInfo.isPrimaryKey]
												${q}'${"$"}{${beanInfo.beanName?uncap_first}.${beanPropInfo.propName}}'
												[#assign q=","]
											[/#if]
										[/#list]
										);">删除</a>
										<a href="javascript:toEdit(
										[#assign q=""]
										[#list beanInfo.beanPropInfoList as beanPropInfo]
											[#if beanPropInfo.isPrimaryKey?? && beanPropInfo.isPrimaryKey]
												${q}'${"$"}{${beanInfo.beanName?uncap_first}.${beanPropInfo.propName}}'
												[#assign q=","]
											[/#if]
										[/#list]
										);">编辑</a>
									</td>
								</tr>
							</c:forEach>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="${beanInfo.beanPropInfoList?size}">
									共 ${"$"}{totalCount}条数据<br/>
									这是第${"$"}{(pageNum-1)*pageSize+1}条，到第${"$"}{pageNum*pageSize}条<br/>
									每页显示<input name="pageSize" value="${"$"}{pageSize}">条数据<br/>
									第<input name="pageNum" value="${"$"}{pageNum}">页<br/>
									<button type="button" onclick="toPage(1);">首页</button>
									<button type="button" onclick="toPage(parseInt(${"$"}{(totalCount%pageSize==0)?(totalCount/pageSize):(totalCount/pageSize+1)}));">末页</button>
									<button type="button" onclick="toPage(${"$"}{pageNum-1});">上一页</button>
									<button type="button" onclick="toPage(${"$"}{pageNum+1});">下一页</button>
								</td>
							</tr>
						</tfoot>
					</table>
				</form>
			<dd>
			<dt>这是通过ajax生成的"[@sqlName transName=beanInfo.beanName/]"表的分页数据</dt>
			<dd>
				<form id="${beanInfo.beanName?uncap_first}AjaxForm">
					[#list beanInfo.beanPropInfoList as beanPropInfo]
						[#if beanPropInfo.propType=='String']
							${beanPropInfo.colName}:<input name="${beanPropInfo.propName}Like"><br/>
						[#else]
							最小${beanPropInfo.colName}:<input name="min${beanPropInfo.propName?cap_first}"><br/>
							最大${beanPropInfo.colName}:<input name="max${beanPropInfo.propName?cap_first}"><br/>
						[/#if]
					[/#list]
					<button type="button" onclick="firstPage();">查询</button>
					<table id="ajaxTable">
						<thead>
							<tr>
								[#list beanInfo.beanPropInfoList as beanPropInfo]
									<th>${beanPropInfo.colName}</th>
								[/#list]
								<th>操作</th>
							</tr>
						</thead>
						<tbody></tbody>
						<tfoot>
							<tr>
								<td colspan="${beanInfo.beanPropInfoList?size}">
									<input type="hidden" name="totalCount">
									共 <span id="totalCount"></span>条数据<br/>
									这是第<span id="startIndex"></span>条，到第<span id="endIndex"></span>条<br/>
									每页显示<input name="pageSize" value="10">条数据<br/>
									第<input name="pageNum" value="1">页<br/>
									<button type="button" onclick="firstPage();">首页</button>
									<button type="button" onclick="lastPage();">末页</button>
									<button type="button" onclick="prevPage();">上一页</button>
									<button type="button" onclick="nextPage();">下一页</button>
								</td>
							</tr>
						</tfoot>
					</table>
				</form>
			</dd>
		</dl>
		<script type="text/javascript" src="js/jquery-1.11.3.js"></script>
		<script type="text/javascript">
			(function(){
				firstPage();
			}());
			function pageAjax(getData){
				$.post('<%=basePath%>${beanInfo.beanName?uncap_first}/listAjax[#if beanInfo.requestSuffix??].${beanInfo.requestSuffix}[/#if]',getData,function(result){
					var ${resultInfo.resultDataPropName}=result.${resultInfo.resultDataPropName};
					$('#totalCount').val(${resultInfo.resultDataPropName}.totalCount);
					$('#${beanInfo.beanName?uncap_first}AjaxForm input[name="totalCount"]').val(${resultInfo.resultDataPropName}.totalCount);
					$('#${beanInfo.beanName?uncap_first}AjaxForm #totalCount').text(${resultInfo.resultDataPropName}.totalCount);
					$('#${beanInfo.beanName?uncap_first}AjaxForm input[name="pageSize"]').val(${resultInfo.resultDataPropName}.pageSize);
					$('#${beanInfo.beanName?uncap_first}AjaxForm input[name="pageNum"]').val(${resultInfo.resultDataPropName}.pageNum);
					var ${beanInfo.beanName?uncap_first}List=${resultInfo.resultDataPropName}.${beanInfo.beanName?uncap_first}List;
					$('#${beanInfo.beanName?uncap_first}AjaxForm #ajaxTable>tbody').empty();
					for(var i=0,len=${beanInfo.beanName?uncap_first}List.length;i<len;i++)
						$('#${beanInfo.beanName?uncap_first}AjaxForm #ajaxTable>tbody').append('<tr>'+
							[#list beanInfo.beanPropInfoList as beanPropInfo]
								'<td>'+(${beanInfo.beanName?uncap_first}List[i].${beanPropInfo.propName}==null?
								'':${beanInfo.beanName?uncap_first}List[i].${beanPropInfo.propName})+'</td>'+
							[/#list]
							'<td><a href="javascript:delAjax(\''+
							[#assign q=""]
							[#list beanInfo.beanPropInfoList as beanPropInfo]
								[#if beanPropInfo.isPrimaryKey?? && beanPropInfo.isPrimaryKey]
									${q}${beanInfo.beanName?uncap_first}List[i].${beanPropInfo.propName}+
									[#assign q=","]
								[/#if]
							[/#list]
							'\');">删除</a> <a href="javascript:toEditAjax(\''+
							[#assign q=""]
							[#list beanInfo.beanPropInfoList as beanPropInfo]
								[#if beanPropInfo.isPrimaryKey?? && beanPropInfo.isPrimaryKey]
									${q}${beanInfo.beanName?uncap_first}List[i].${beanPropInfo.propName}+
									[#assign q=","]
								[/#if]
							[/#list]
							'\');">编辑</a></td>'+
						'</tr>');
				},'json');
			}
			function delAjax(
			[#assign q=""]
			[#list beanInfo.beanPropInfoList as beanPropInfo]
				[#if beanPropInfo.isPrimaryKey?? && beanPropInfo.isPrimaryKey]
					${q}${beanPropInfo.propName}
					[#assign q=","]
				[/#if]
			[/#list]
			){
				$.post('<%=basePath%>${beanInfo.beanName?uncap_first}/delAjax[#if beanInfo.requestSuffix??].${beanInfo.requestSuffix}[/#if]',{
					[#assign q=""]
					[#list beanInfo.beanPropInfoList as beanPropInfo]
						[#if beanPropInfo.isPrimaryKey?? && beanPropInfo.isPrimaryKey]
							${q}'${beanInfo.beanName?uncap_first}List[0].${beanPropInfo.propName}':${beanPropInfo.propName}
							[#assign q=","]
						[/#if]
					[/#list]
				},function(result){
					if(result.${resultInfo.resultCodePropName}===-1)
						alert(result.${resultInfo.resultMsgPropName});
					else
						firstPage();
				},'json');
			}
			function toEditAjax(
			[#assign q=""]
			[#list beanInfo.beanPropInfoList as beanPropInfo]
				[#if beanPropInfo.isPrimaryKey?? && beanPropInfo.isPrimaryKey]
					${q}${beanPropInfo.propName}
					[#assign q=","]
				[/#if]
			[/#list]
			){
				$.post('<%=basePath%>${beanInfo.beanName?uncap_first}/toEditAjax[#if beanInfo.requestSuffix??].${beanInfo.requestSuffix}[/#if]',{
					[#assign q=""]
					[#list beanInfo.beanPropInfoList as beanPropInfo]
						[#if beanPropInfo.isPrimaryKey?? && beanPropInfo.isPrimaryKey]
							${q}'${beanPropInfo.propName}':${beanPropInfo.propName}
							[#assign q=","]
						[/#if]
					[/#list]
				},function(result){
					var data=result.${resultInfo.resultDataPropName};
					var dataStr='';
					for(var key in data)
						dataStr+=key+':'+data[key]+',\r\n'
					alert(dataStr);
				},'json');
			}
			function toEdit(
			[#assign q=""]
			[#list beanInfo.beanPropInfoList as beanPropInfo]
				[#if beanPropInfo.isPrimaryKey?? && beanPropInfo.isPrimaryKey]
					${q}${beanPropInfo.propName}
					[#assign q=","]
				[/#if]
			[/#list]
			){
				location.href='<%=basePath%>${beanInfo.beanName?uncap_first}/toEdit[#if beanInfo.requestSuffix??].${beanInfo.requestSuffix}[/#if]?'+
				[#assign a=""]
				[#assign n=""]
				[#list beanInfo.beanPropInfoList as beanPropInfo]
					[#if beanPropInfo.isPrimaryKey?? && beanPropInfo.isPrimaryKey]
						${a}'${n}${beanPropInfo.propName}='+${beanPropInfo.propName}
						[#assign a="+"]
						[#assign n="&"]
					[/#if]
				[/#list];
			}
			function del(
			[#assign q=""]
			[#list beanInfo.beanPropInfoList as beanPropInfo]
				[#if beanPropInfo.isPrimaryKey?? && beanPropInfo.isPrimaryKey]
					${q}${beanPropInfo.propName}
					[#assign q=","]
				[/#if]
			[/#list]
			){
				if(confirm('确认删除？'))
					location.href='<%=basePath%>${beanInfo.beanName?uncap_first}/del[#if beanInfo.requestSuffix??].${beanInfo.requestSuffix}[/#if]?'+
					[#assign a=""]
					[#assign n=""]
					[#list beanInfo.beanPropInfoList as beanPropInfo]
						[#if beanPropInfo.isPrimaryKey?? && beanPropInfo.isPrimaryKey]
							${a}'${n}${beanInfo.beanName?uncap_first}List[0].${beanPropInfo.propName}='+${beanPropInfo.propName}
							[#assign a="+"]
							[#assign n="&"]
						[/#if]
					[/#list];
			}
			function getOtherParams(){
				var _d={pageSize:$('#${beanInfo.beanName?uncap_first}AjaxForm input[name="pageSize"]').val()
				[#list beanInfo.beanPropInfoList as beanPropInfo]
					[#if beanPropInfo.propType=='String']
						,'${beanPropInfo.propName}Like':$('#${beanInfo.beanName?uncap_first}AjaxForm input[name="${beanPropInfo.propName}Like"]').val()
					[#else]
						,'min${beanPropInfo.propName?cap_first}':$('#${beanInfo.beanName?uncap_first}AjaxForm input[name="min${beanPropInfo.propName?cap_first}"]').val()
						,'max${beanPropInfo.propName?cap_first}':$('#${beanInfo.beanName?uncap_first}AjaxForm input[name="max${beanPropInfo.propName?cap_first}"]').val()
					[/#if]
				[/#list]};
				for(var key in _d){
					if(_d[key].length===0)
						_d[key]=null;
				}
				return _d;
			}
			function firstPage(){
				var getData=getOtherParams();
				getData['pageNum']=1;
				pageAjax(getData);
			}
			function lastPage(){
				var getData=getOtherParams();
				var totalCount=parseInt($('#${beanInfo.beanName?uncap_first}AjaxForm input[name="totalCount"]').val());
				var pageSize=getData['pageSize'];
				getData['pageNum']=totalCount%pageSize==0?(totalCount/pageSize):(totalCount/pageSize+1);
				pageAjax(getData);
			}
			function prevPage(){
				var getData=getOtherParams();
				getData['pageNum']=parseInt($('${beanInfo.beanName?uncap_first}Form input[name="pageNum"]').val())-1;
				pageAjax(getData);
			}
			function nextPage(){
				var getData=getOtherParams();
				getData['pageNum']=parseInt($('${beanInfo.beanName?uncap_first}Form input[name="pageNum"]').val())+1;
				pageAjax(getData);
			}
			function toPage(pageNum){
				$('#${beanInfo.beanName?uncap_first}Form input[name="pageNum"]').val(pageNum);
				$('#${beanInfo.beanName?uncap_first}Form').submit();
			}
		</script>
	</body>
</html>