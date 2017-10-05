<%@ page language="java" import="java.util.*" pageEncoding="utf-8"
	contentType="text/html; charset=utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML>
<html>
	<head>
		<base href="http://localhost:8088/sys1/">
		<meta charset="utf-8">
		<style type="text/css">
			*{margin:0;padding:0;}
			#propForm{
				position: fixed;
				left: 0;
				top: 0;
				width: 100%;
				height: 100%;
				display: none;
				background: rgba(0,0,0,0.3);
			}
			#propForm>table{
				margin: auto;
				background: white;
			}
			#IntegerTypeTbody{display:none;}
			.tip{
				color:red;
			}
		</style>
	</head>
	<body>
		<form id="beanForm" action="<%=basePath%>ctrl/codeGen.html" method="post">
			<dl>
				<dt>控制层框架</dt>
				<dd>
					<select>
						<option>spring-MVC</option>
						<option>struts2</option>
					</select>
				</dd>
			</dl>
			<dl>
				<dt>持久化框架</dt>
				<dd>
					<select>
						<option>mybatis</option>
						<option>ibatis</option>
						<option>hibernate</option>
					</select>
				</dd>
			</dl>
			<dl>
				<dt>bean管理器</dt>
				<dd>
					<select>
						<option>spring</option>
					</select>
				</dd>
			</dl>
			<dl>
				<dt>返回json数据时，数据结构所在的包名</dt>
				<dd>
					<input name="resultPackageName" placeholder="小写字母数字组合用.分割开"/>
					<span class="tip"></span>
				</dd>
			</dl>
			<dl>
				<dt>返回json数据时，数据结构名</dt>
				<dd>
					<input name="className" placeholder="以大写字母开头，符合驼峰命名法"/>
					<span class="tip"></span>
				</dd>
			</dl>
			<dl>
				<dt>返回json数据时，数据结构的数据属性名</dt>
				<dd>
					<input name="resultDataPropName" placeholder="以小写字母开头，符合驼峰命名法"/>
					<span class="tip"></span>
				</dd>
			</dl>
			<dl>
				<dt>返回json数据时，数据结构的返回信息名</dt>
				<dd>
					<input name="resultMsgPropName" placeholder="以小写字母开头，符合驼峰命名法"/>
					<span class="tip"></span>
				</dd>
			</dl>
			<dl>
				<dt>返回json数据时，数据结构的返回错误码名</dt>
				<dd>
					<input name="resultCodePropName" placeholder="以小写字母开头，符合驼峰命名法"/>
					<span class="tip"></span>
				</dd>
			</dl>
			<dl>
				<dt>java bean名称</dt>
				<dd>
					<input placeholder="以大写字母开头，符合驼峰命名法" name="beanName"/>
					<span class="tip"></span>
				</dd>
			</dl>
			<dl>
				<dt>java bean包名</dt>
				<dd>
					<input name="packageName" placeholder="小写字母数字组合用.分割开"/>
					<span class="tip"></span>
				</dd>
			</dl>
			<table id="beanTable">
				<caption>java bean属性表</caption>
				<thead>
					<tr>
						<th>属性名</th>
						<th>属性类型</th>
						<th>中文名</th>
						<th>注释/描述</th>
						<th>是否为主键</th>
						<th>是否为自增列</th>
						<th>是否为UUID</th>
						<th>是否插入时返回</th>
						<th>是否作为错误提示的凭据</th>
						<th>是否必填</th>
						<th>正则格式</th>
						<th>最小长度</th>
						<th>最大长度</th>
						<th>最小值</th>
						<th>最大值</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody></tbody>
				<tfoot>
					<tr>
						<td colspan="1">
							<button type="button" id="addProperties">增加属性</button>
							<button type="submit">生成代码</button>
						</td>
					</tr>
				</tfoot>
			</table>
		</form>
		<form id="propForm">
			<input type="hidden" name="index">
			<table>
				<caption>编辑框</caption>
				<tbody>
					<tr><td>属性名</td><td><input name="propName" placeholder="以小写字母开头，符合驼峰命名法"><span class="tip"></span></td></tr>
					<tr><td>属性中文名</td><td><input name="colName"><span class="tip"></span></td></tr>
					<tr><td>属性注释</td><td><textarea name="colDesc"></textarea><span class="tip"></span></td></tr>
					<tr>
						<td>是否为主键</td>
						<td>
							<select name="isPrimaryKey">
								<option value="false">否</option>
								<option value="true">是</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>是否必填</td>
						<td>
							<select name="notEmpty">
								<option value="false">否</option>
								<option value="true">是</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>属性类型</td>
						<td>
							<select name="propType">
								<option value="String">字符串</option>
								<option value="Integer">整数</option>
								<option value="Date">日期</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>是否加入错误提示中</td>
						<td>
							<select name="isErrMsgId">
								<option value="false">否</option>
								<option value="true">是</option>
							</select>
						</td>
					</tr>
				</tbody>
				<tbody id="StringTypeTbody">
					<tr>
						<td>字符串格式：</td>
						<td>
							<input name="regex" placeholder="正则表达式">
							<span class="tip"></span>
						</td>
					</tr>
					<tr>
						<td>字符串最小长度：</td>
						<td>
							<input name="minLen">
							<span class="tip"></span>
						</td>
					</tr>
					<tr>
						<td>字符串最大长度：</td>
						<td>
							<input name="maxLen">
							<span class="tip"></span>
						</td>
					</tr>
					<tr>
						<td>是否为UUID：</td>
						<td>
							<select name="isUUID">
								<option value="false">否</option>
								<option value="true">是</option>
							</select>
						</td>
					</tr>
				</tbody>
				<tbody id="IntegerTypeTbody">
					<tr>
						<td>整数最小值：</td>
						<td>
							<input name="min">
							<span class="tip"></span>
						</td>
					</tr>
					<tr>
						<td>整数最大值：</td>
						<td>
							<input name="max">
							<span class="tip"></span>
						</td>
					</tr>
					<tr>
						<td>是否为自增序列：</td>
						<td>
							<select name="autoIncrement">
								<option value="false">否</option>
								<option value="true">是</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>是否插入时返回</td>
						<td>
							<select name="insertReturn">
								<option value="false">否</option>
								<option value="true">是</option>
							</select>
						</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="2">
							<button type="submit">保存</button>
							<button type="button" id="cancel">取消</button>
						</td>
					</tr>
				</tfoot>
			</table>
		</form>
		<script type="text/javascript" src="<%=basePath%>js/jquery-1.11.3.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/jquery.validate.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/additional-methods.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/messages_cn.js"></script>
		<script type="text/javascript">
			$('#cancel').click(function(){
				$('#propForm').css('display','none');
			});
			$('#addProperties').click(function(){
				$('#propForm').css('display','block').data('type','add').get(0).reset();
				$('#propForm select[name="propType"]').trigger('change');
			});
			$('#beanForm').validate({
				rules:{
					beanName:{required:true,regexp:/^[A-Z]\w*$/},
					packageName:{required:true,regexp:/^([a-z0-9]+\.)*[a-z0-9]+$/},
					resultPackageName:{required:true,regexp:/^([a-z0-9]+\.)*[a-z0-9]+$/},
					className:{required:true,regexp:/^[A-Z]\w*$/},
					resultDataPropName:{required:true,rangelength:[1,30],regexp:/^[a-z]\w*$/},
					resultMsgPropName:{required:true,rangelength:[1,30],regexp:/^[a-z]\w*$/},
					resultCodePropName:{required:true,rangelength:[1,30],regexp:/^[a-z]\w*$/}
				},
				messages:{
					beanName:{required:'bean名称必填',regexp:'bean名称格式错误，必须是以大写开头，符合驼峰命名法'},
					packageName:{required:'包名必填',regexp:'包名格式错误，必须是小写字母或字母数字组合，并用.隔开表示层级关系'},
					resultPackageName:{required:'返回json数据时，数据结构所在的包名必填',regexp:'返回json数据时，数据结构所在的包名格式错误'},
					className:{required:'返回json数据时，数据结构名必填',regexp:'返回json数据时，数据结构名格式错误'},
					resultDataPropName:{required:'json数据时，数据结构的数据属性名必填',rangelength:'json数据时，数据结构的数据属性名长度必须是{0}到{1}之间',regexp:'json数据时，数据结构的数据属性名格式错误'},
					resultMsgPropName:{required:'返回json数据时，数据结构的返回信息名必填',rangelength:'返回json数据时，数据结构的返回信息名长度必须是{0}到{1}之间',regexp:'返回json数据时，数据结构的返回信息名格式错误'},
					resultCodePropName:{required:'返回json数据时，数据结构的返回错误码名必填',rangelength:'返回json数据时，数据结构的返回错误码名长度必须是{0}到{1}之间',regexp:'返回json数据时，数据结构的返回错误码名格式错误'}
				},
				errorPlacement:function(error,element){
					error.appendTo(element.next());
				},
				submitHandler:function(form){
					form.submit();
				}
			});
			$('#propForm select[name="propType"]').change(function(){
				$('#StringTypeTbody,#IntegerTypeTbody').css('display','none');
				if(this.value==='String')
					$('#StringTypeTbody').css('display','table-row-group');
				else if(this.value==='Integer')
					$('#IntegerTypeTbody').css('display','table-row-group');
			});
			$('#propForm').validate({
				rules:{
					propName:{required:true,rangelength:[1,30],regexp:/^[a-z]\w*$/},
					regex:{required:true,rangelength:[1,60]},
					minLen:{required:true,range:[1,2e4],regexp:/^\-?\d+$/},
					maxLen:{required:true,range:[1,2e4],regexp:/^\-?\d+$/},
					min:{required:true,range:[-2e8,2e8],regexp:/^\-?\d+$/},
					max:{required:true,range:[-2e8,2e8],regexp:/^\-?\d+$/},
					colName:{required:true,rangelength:[1,10]},
					colDesc:{required:true,rangelength:[1,60]}
				},
				messages:{
					propName:{required:'属性名必填',rangelength:'属性名长度必须是{0}到{1}之间',regexp:'属性名格式错误'},
					regex:{required:'字符串格式必填',rangelength:'字符串格式长度必须是{0}到{1}之间'},
					minLen:{required:'字符串最小长度必填',range:'字符串最小长度必须是{0}到{1}之间',regexp:'字符串最小长度必须是数字'},
					maxLen:{required:'字符串最大长度必填',range:'字符串最大长度必须是{0}到{1}之间',regexp:'字符串最大长度必须是数字'},
					min:{required:'整数最小值必填',range:'整数最小值范围必须在{0}到{1}之间',regexp:'整数最小值必须是数字'},
					max:{required:'整数最大值必填',range:'整数最大值范围必须在{0}到{1}之间',regexp:'整数最大值必须是数字'},
					colName:{required:'属性中文名必填',rangelength:'属性中文名长度必须是{0}到{1}之间'},
					colDesc:{required:'属性注释必填',rangelength:'属性注释长度必须是{0}到{1}之间'}
				},
				errorPlacement:function(error,element){
					error.appendTo(element.next());
				},
				submitHandler:function(form){
					if($(form).data('type')==='add'){
						function _(name){return form[name].value;}
						var index=$('#beanTable>tbody>tr').length;
						$('#beanTable>tbody').append('<tr>'+
						'<td>'+_('propName')+'<input type="hidden" name="beanPropInfoList['+index+'].propName" value="'+_('propName')+'"></td>'+
						'<td>'+_('propType')+'<input type="hidden" name="beanPropInfoList['+index+'].propType" value="'+_('propType')+'"></td>'+
						'<td>'+_('colName')+'<input type="hidden" name="beanPropInfoList['+index+'].colName" value="'+_('colName')+'"></td>'+
						'<td>'+_('colDesc')+'<input type="hidden" name="beanPropInfoList['+index+'].colDesc" value="'+_('colDesc')+'"></td>'+
						'<td>'+_('isPrimaryKey')+'<input type="hidden" name="beanPropInfoList['+index+'].isPrimaryKey" value="'+_('isPrimaryKey')+'"></td>'+
						'<td>'+_('autoIncrement')+'<input type="hidden" name="beanPropInfoList['+index+'].autoIncrement" value="'+_('autoIncrement')+'"></td>'+
						'<td>'+_('isUUID')+'<input type="hidden" name="beanPropInfoList['+index+'].isUUID" value="'+_('isUUID')+'"></td>'+
						'<td>'+_('insertReturn')+'<input type="hidden" name="beanPropInfoList['+index+'].insertReturn" value="'+_('insertReturn')+'"></td>'+
						'<td>'+_('isErrMsgId')+'<input type="hidden" name="beanPropInfoList['+index+'].isErrMsgId" value="'+_('isErrMsgId')+'"></td>'+
						'<td>'+_('notEmpty')+'<input type="hidden" name="beanPropInfoList['+index+'].notEmpty" value="'+_('notEmpty')+'"></td>'+
						'<td>'+_('regex')+'<input type="hidden" name="beanPropInfoList['+index+'].regex" value="'+_('regex')+'"></td>'+
						'<td>'+_('minLen')+'<input type="hidden" name="beanPropInfoList['+index+'].minLen" value="'+_('minLen')+'"></td>'+
						'<td>'+_('maxLen')+'<input type="hidden" name="beanPropInfoList['+index+'].maxLen" value="'+_('maxLen')+'"></td>'+
						'<td>'+_('min')+'<input type="hidden" name="beanPropInfoList['+index+'].min" value="'+_('min')+'"></td>'+
						'<td>'+_('max')+'<input type="hidden" name="beanPropInfoList['+index+'].max" value="'+_('max')+'"></td>'+
						'<td class="operCell"><a href="javascript:del('+index+');">删除</a> <a href="javascript:edit('+index+');">编辑</a></td>'+
						'</tr>');
					}else if($(form).data('type')==='edit'){
						function _(name){
							var index=$('#propForm :hidden[name="index"]').val();
							$('#beanTable>tbody>tr:eq('+index+') :hidden[name="beanPropInfoList['+index+'].'+name+'"]').parent().html(form[name].value+'<input type="hidden" name="beanPropInfoList['+index+'].'+name+'" value="'+form[name].value+'">');
						}
						_('propType');
						_('colName');
						_('colDesc');
						_('isPrimaryKey');
						_('autoIncrement');
						_('isUUID');
						_('insertReturn');
						_('isErrMsgId');
						_('notEmpty');
						_('regex');
						_('minLen');
						_('maxLen');
						_('min');
						_('max');
					}
					$('#propForm').css('display','none');
				}
			});
			function del(index){
				$('#beanTable>tbody>tr:eq('+index+')').remove();
				function _(name,index){
					$(this).find(':hidden[name$="'+name+'"]').attr('name','beanPropInfoList['+index+'].'+name);
					$(this).find('.operCell').html('<a href="javascript:del('+index+');">删除</a> <a href="javascript:edit('+index+');">编辑</a>');
				}
				$('#beanTable>tbody>tr').each(function(i){
					_('propName',i);
					_('propType',i);
					_('colName',i);
					_('colDesc',i);
					_('isPrimaryKey',i);
					_('autoIncrement',i);
					_('isUUID',i);
					_('insertReturn',i);
					_('isErrMsgId',i);
					_('notEmpty',i);
					_('regex',i);
					_('minLen',i);
					_('maxLen',i);
					_('min',i);
					_('max',i);
				});
			}
			function edit(index){
				$('#propForm').css('display','block').data('type','edit');
				function _(name){
					var $i=$('#propForm [name="'+name+'"]');
					var _i=$i.get(0);
					var value=$('#beanTable>tbody>tr:eq('+index+') :hidden[name="beanPropInfoList['+index+'].'+name+'"]').val();
					if(_i.tagName==='INPUT')
						$i.val(value);
					else if(_i.tagName==='SELECT'){
						var options=_i.options;
						for(var i=0,len=options.length;i<len;i++){
							if(options[i].value===value){
								_i.selectedIndex=i;
								break;
							}
						}
						$('#propForm select[name="propType"]').trigger('change');
					}
				}
				$('#propForm :hidden[name="index"]').val(index);
				_('propName');
				_('propType');
				_('colName');
				_('colDesc');
				_('isPrimaryKey');
				_('autoIncrement');
				_('isUUID');
				_('insertReturn');
				_('isErrMsgId');
				_('notEmpty');
				_('regex');
				_('minLen');
				_('maxLen');
				_('min');
				_('max');
			}
		</script>
	</body>
</html>