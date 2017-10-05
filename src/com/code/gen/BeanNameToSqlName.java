package com.code.gen;
import java.io.IOException;
import java.util.Map;
import freemarker.core.Environment;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;
import freemarker.template.TemplateScalarModel;
public class BeanNameToSqlName implements TemplateDirectiveModel{
	@Override
	public void execute(Environment arg0, Map arg1, TemplateModel[] arg2, TemplateDirectiveBody body)
			throws TemplateException, IOException {
		String transName=((TemplateScalarModel)arg1.get("transName")).getAsString();
		char[] charArray=transName.toCharArray();
		StringBuilder sqlName=new StringBuilder();
		String tempPrefix="";
		for(int i=1,startIndex=0,len=charArray.length;i<len;i++){
			if(Character.isUpperCase(charArray[i]) ){
				sqlName.append(tempPrefix).append(transName.substring(startIndex, i));
				tempPrefix="_";
				startIndex=i;
			}
			if(i==len-1)
				sqlName.append(tempPrefix).append(transName.substring(startIndex));
		}
		arg0.getOut().write(sqlName.toString().toUpperCase());
	}
}