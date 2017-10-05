package com.code.gen;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.Map.Entry;

import org.springframework.core.io.ClassPathResource;
import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
public class BeanFactory{
	private static final Configuration CFG;
	static{
		CFG=new Configuration(Configuration.DEFAULT_INCOMPATIBLE_IMPROVEMENTS);
		try {
			CFG.setDirectoryForTemplateLoading(new ClassPathResource("ftl").getFile());
		} catch (IOException e) {
			e.printStackTrace();
		}
		CFG.setObjectWrapper(new DefaultObjectWrapper(Configuration.DEFAULT_INCOMPATIBLE_IMPROVEMENTS));
	}
	public static String generatorCode(Framework framework){
		OutputStreamWriter outputStreamWriter=null;
		for(Entry<String, String> entry:framework.getPathAndTemplate().entrySet()){
			try{
					CFG.getTemplate(entry.getValue()).process(framework.getData(), outputStreamWriter=new OutputStreamWriter(new FileOutputStream(createPathAndReturnFileName(entry.getKey())),"UTF-8"));
			} catch (Exception e) {
				e.printStackTrace();
			}finally{
				try {
					if(outputStreamWriter!=null)
						outputStreamWriter.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return new File(framework.getRootPath()).getAbsolutePath();
	}
	private static String createPathAndReturnFileName(String fileName){
		new File(fileName.substring(0, fileName.lastIndexOf(File.separator))).mkdirs();
		return fileName;
	}
}