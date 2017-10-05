package com.ctrl;
import java.io.File;
import java.io.IOException;
import java.util.UUID;
import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.code.gen.BeanFactory;
import com.code.gen.BeanInfo;
import com.code.gen.ResultInfo;
import com.code.gen.SpringMvcMybatisFramework;
import net.lingala.zip4j.core.ZipFile;
import net.lingala.zip4j.exception.ZipException;
import net.lingala.zip4j.model.ZipParameters;
import net.lingala.zip4j.util.Zip4jConstants;
@Controller
@RequestMapping("/ctrl")
public class Ctrl {
	@ResponseBody
	@RequestMapping("/codeGen")
	public ResponseEntity<byte[]> codeGen(BeanInfo beanInfo,ResultInfo resultInfo) throws ZipException, IOException{
		SpringMvcMybatisFramework framework=new SpringMvcMybatisFramework();
		framework.setBeanInfo(beanInfo);
		framework.setResultInfo(resultInfo);
		File source=new File(BeanFactory.generatorCode(framework));
		File target=new File("temp"+File.separator+UUID.randomUUID().toString()+".zip");
		ZipFile zipFile = new ZipFile(target);
		ZipParameters parameters = new ZipParameters();        
		parameters.setCompressionMethod(Zip4jConstants.COMP_DEFLATE);        
		parameters.setCompressionLevel(Zip4jConstants.DEFLATE_LEVEL_NORMAL);
		zipFile.addFolder(source, parameters);
		FileUtils.deleteDirectory(source);
		HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);    
		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(target.getAbsoluteFile()), headers, HttpStatus.CREATED);
	}
}