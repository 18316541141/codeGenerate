[#ftl]
[#assign sqlName="com.code.gen.BeanNameToSqlName"?new()]
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
	"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${beanInfo.mapperPackageName}.${beanInfo.beanName}Mapper">
	<resultMap type="${beanInfo.beanName}" id="${beanInfo.beanName}ResultMap">
[#list beanInfo.beanPropInfoList as beanPropInfo]
	[#if beanPropInfo.isPrimaryKey?? && beanPropInfo.isPrimaryKey]
		<id property="${beanPropInfo.propName}" column="[@sqlName transName=beanPropInfo.propName/]"/>
	[#else]
		<result property="${beanPropInfo.propName}" column="[@sqlName transName=beanPropInfo.propName/]"/>
	[/#if]
[/#list>
	</resultMap>
	<sql id="field">
	[#assign q=""]
	[#list beanInfo.beanPropInfoList as beanPropInfo]
		${q}[@sqlName transName=beanPropInfo.propName/>
		[#assign q=","]
	[/#list]
	</sql>
	<select id="select" parameterType="${beanInfo.beanName}" resultMap="${beanInfo.beanName}ResultMap">
		select rownum,<include refid="field"/> from
		(select rownum,<include refid="field"/> from [@sqlName transName=beanInfo.beanName/]
		<where>
		[#list beanInfo.beanPropInfoList as beanPropInfo]
			<if test="${beanPropInfo.propName}!=null[#if beanPropInfo.propType=='String'] and ${beanPropInfo.propName}!=''[/#if]">
				and [@sqlName transName=beanPropInfo.propName/] = ${'#'}{${beanPropInfo.propName}}
			</if>
		[#if beanPropInfo.propType=='String']
			<if test="${beanPropInfo.propName}Like!=null and ${beanPropInfo.propName}Like!=''">
				and [@sqlName transName=beanPropInfo.propName/] like ${'#'}{${beanPropInfo.propName}Like}
			</if>
		[#else]
			<if test="min${beanPropInfo.propName?cap_first}!=null">
				and [@sqlName transName=beanPropInfo.propName/] &gt;= ${'#'}{min${beanPropInfo.propName?cap_first}}
			</if>
			<if test="max${beanPropInfo.propName?cap_first}!=null">
				and [@sqlName transName=beanPropInfo.propName/] &lt;= ${'#'}{max${beanPropInfo.propName?cap_first}}
			</if>
		[/#if]
		[/#list]
		</where>)
		<if test="pageNum!=null and pageSize!=null">
			where rownum between ${"#"}{pageSize}*(${"#"}{pageNum}-1)+1 and ${"#"}{pageSize}*${"#"}{pageNum}
		</if>
	</select>
	<delete id="delete" parameterType="${beanInfo.beanName}">
		delete from [@sqlName transName=beanInfo.beanName/>
		<where>
		[#list beanInfo.beanPropInfoList as beanPropInfo]
			<if test="${beanPropInfo.propName}!=null[#if beanPropInfo.propType=='String'] and ${beanPropInfo.propName}!=''[/#if]">
				and [@sqlName transName=beanPropInfo.propName/] = ${'#'}{${beanPropInfo.propName}}
			</if>
		[/#list]
		</where>
	</delete>
	<insert id="insert" parameterType="${beanInfo.beanName}" 
		[#list beanInfo.beanPropInfoList as beanPropInfo]
			[#if beanPropInfo.insertReturn?? && beanPropInfo.insertReturn]
				keyProperty="${beanPropInfo.propName}"
			[/#if]
		[/#list]>
		insert into [@sqlName transName=beanInfo.beanName/>(<include refid="field"/>)
		values(
	[#assign q=""/]
	[#list beanInfo.beanPropInfoList as beanPropInfo]
		[#if beanPropInfo.autoIncrement?? && beanPropInfo.autoIncrement]
			${q}[#if beanPropInfo.insertReturn?? && beanPropInfo.insertReturn]
				<selectKey resultType="${beanPropInfo.propType}" keyProperty="${beanPropInfo.propName}">
			[/#if]
			select [@sqlName transName=beanInfo.beanName/]_[@sqlName transName=beanPropInfo.propName/]_SEQ.nextval from dual
			[#if beanPropInfo.insertReturn?? && beanPropInfo.insertReturn]
				</selectKey>
			[/#if]
		[#else]
			${q}${'#'}{${beanPropInfo.propName}}
		[/#if]
		[#assign q=","/]
	[/#list]
		)
	</insert>
	<select id="selectCount" parameterType="${beanInfo.beanName}" resultType="long">
		select count(*) from [@sqlName transName=beanInfo.beanName/]
		<where>
		[#list beanInfo.beanPropInfoList as beanPropInfo]
			<if test="${beanPropInfo.propName}!=null[#if beanPropInfo.propType=='String'] and ${beanPropInfo.propName}!=''[/#if]">
				and [@sqlName transName=beanPropInfo.propName/] = ${'#'}{${beanPropInfo.propName}}
			</if>
		[#if beanPropInfo.propType=='String']
			<if test="${beanPropInfo.propName}Like!=null and ${beanPropInfo.propName}Like!=''">
				and [@sqlName transName=beanPropInfo.propName/] like ${'#'}{${beanPropInfo.propName}Like}
			</if>
		[#else]
			<if test="min${beanPropInfo.propName?cap_first}!=null">
				and [@sqlName transName=beanPropInfo.propName/] &gt;= ${'#'}{min${beanPropInfo.propName?cap_first}}
			</if>
			<if test="max${beanPropInfo.propName?cap_first}!=null">
				and [@sqlName transName=beanPropInfo.propName/] &lt;= ${'#'}{max${beanPropInfo.propName?cap_first}}
			</if>
		[/#if]
		[/#list]
		</where>
	</select>
	<select id="selectByKey" resultMap="${beanInfo.beanName}ResultMap">
		select <include refid="field"/> from [@sqlName transName=beanInfo.beanName/]
		<where>
	[#list beanInfo.beanPropInfoList as beanPropInfo]
		[#if beanPropInfo.isPrimaryKey?? && beanPropInfo.isPrimaryKey]
			<if test="${beanPropInfo.propName}!=null[#if beanPropInfo.propType=='String'] and ${beanPropInfo.propName}!=''[/#if]">
				and [@sqlName transName=beanPropInfo.propName/> = ${'#'}{${beanPropInfo.propName}}
			</if>
		[/#if]
	[/#list]
		</where>
	</select>
	<update id="updateByKey" parameterType="${beanInfo.beanName}">
		update [@sqlName transName=beanInfo.beanName/]
		<set>
	[#list beanInfo.beanPropInfoList as beanPropInfo]
		[#if beanPropInfo.isPrimaryKey?? && beanPropInfo.isPrimaryKey]
		[#else]
			<if test="${beanPropInfo.propName}!=null[#if beanPropInfo.propType=='String'] and ${beanPropInfo.propName}!=''[/#if]">
				[@sqlName transName=beanPropInfo.propName/>=${'#'}{${beanPropInfo.propName}},
			</if>
		[/#if]
	[/#list]
		</set>
		<where>
	[#list beanInfo.beanPropInfoList as beanPropInfo]
		[#if beanPropInfo.isPrimaryKey?? && beanPropInfo.isPrimaryKey]
			<if test="${beanPropInfo.propName}!=null[#if beanPropInfo.propType=='String'] and ${beanPropInfo.propName}!=''[/#if]">
				and [@sqlName transName=beanPropInfo.propName/> = ${'#'}{${beanPropInfo.propName}}
			</if>
		[/#if]
	[/#list]
		</where>
	</update>
	<delete id="deleteByKey">
		delete from [@sqlName transName=beanInfo.beanName/]
		<where>
	[#list beanInfo.beanPropInfoList as beanPropInfo]
		[#if beanPropInfo.isPrimaryKey?? && beanPropInfo.isPrimaryKey]
			<if test="${beanPropInfo.propName}!=null[#if beanPropInfo.propType=='String'] and ${beanPropInfo.propName}!=''[/#if]">
				and [@sqlName transName=beanPropInfo.propName/] = ${'#'}{${beanPropInfo.propName}}
			</if>
		[/#if]
	[/#list]
		</where>
	</delete>
</mapper>