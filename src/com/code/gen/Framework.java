package com.code.gen;
import java.util.Map;
public interface Framework {
	String getRootPath();
	Map<String,Object> getData();
	Map<String,String> getPathAndTemplate();
}