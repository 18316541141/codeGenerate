[#ftl]
[#assign sqlName="com.code.gen.BeanNameToSqlName"?new()]
create table [@sqlName transName=beanInfo.beanName/](
	[#list beanInfo.beanPropInfoList as beanPropInfo]
		[@sqlName transName=beanPropInfo.propName/] [#if beanPropInfo.autoIncrement?? && beanPropInfo.autoIncrement]numeric(12)
		[#elseif beanPropInfo.isUUID?? && beanPropInfo.isUUID]char(32)
		[#elseif beanPropInfo.max??]numeric(${beanPropInfo.max?length})
		[#elseif beanPropInfo.maxLen??]varchar2(${beanPropInfo.maxLen})
		[#elseif beanPropInfo.propType=="Date"]date[/#if]
		[#if beanPropInfo.notEmpty?? && beanPropInfo.notEmpty]not null[/#if],
	[/#list]
	[#assign q=""/]
	CONSTRAINT PK_[@sqlName transName=beanInfo.beanName/] PRIMARY KEY(
	[#list beanInfo.beanPropInfoList as beanPropInfo]
		[#if beanPropInfo.isPrimaryKey?? && beanPropInfo.isPrimaryKey]
			${q}[@sqlName transName=beanPropInfo.propName/]
			[#assign q=","/]
		[/#if]
	[/#list])
);
[#list beanInfo.beanPropInfoList as beanPropInfo]
	[#if beanPropInfo.autoIncrement?? && beanPropInfo.autoIncrement]
		create sequence [@sqlName transName=beanInfo.beanName/]_[@sqlName transName=beanPropInfo.propName/]_SEQ increment by 1 start with 0;
	[/#if]
[/#list]

[#list beanInfo.beanPropInfoList as beanPropInfo]
comment on column [@sqlName transName=beanInfo.beanName/].[@sqlName transName=beanPropInfo.propName/] is '${beanPropInfo.colDesc}';
[/#list]