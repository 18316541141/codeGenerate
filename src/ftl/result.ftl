package ${resultInfo.resultPackageName};
public class ${resultInfo.className}{
	private Object ${resultInfo.resultDataPropName};
	private String ${resultInfo.resultMsgPropName};
	private Integer ${resultInfo.resultCodePropName};
	public void set${resultInfo.resultDataPropName?cap_first}(Object ${resultInfo.resultDataPropName}){
		this.${resultInfo.resultDataPropName}=${resultInfo.resultDataPropName};
	}
	public Object get${resultInfo.resultDataPropName?cap_first}(){
		return ${resultInfo.resultDataPropName};
	}
	public void set${resultInfo.resultMsgPropName?cap_first}(String ${resultInfo.resultMsgPropName}){
		this.${resultInfo.resultMsgPropName}=${resultInfo.resultMsgPropName};
	}
	public String get${resultInfo.resultMsgPropName?cap_first}(){
		return ${resultInfo.resultMsgPropName};
	}
	public void set${resultInfo.resultCodePropName?cap_first}(Integer ${resultInfo.resultCodePropName}){
		this.${resultInfo.resultCodePropName}=${resultInfo.resultCodePropName};
	}
	public Integer get${resultInfo.resultCodePropName?cap_first}(){
		return ${resultInfo.resultCodePropName};
	}
	public ${resultInfo.className} _${resultInfo.resultMsgPropName}_${resultInfo.resultCodePropName}
	(String ${resultInfo.resultMsgPropName},Integer ${resultInfo.resultCodePropName}){
		this.${resultInfo.resultMsgPropName}=${resultInfo.resultMsgPropName};
		this.${resultInfo.resultCodePropName}=${resultInfo.resultCodePropName};
		return this;
	}
}