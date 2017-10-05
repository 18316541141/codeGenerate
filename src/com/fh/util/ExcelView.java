package com.fh.util;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.servlet.view.document.AbstractXlsxView;
/**
 * 导出excel的视图处理器
 * @author Administrator
 */
public class ExcelView extends AbstractXlsxView{
	@Override
	protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		List<String> titles=(List<String>) model.get("titles");
		Sheet sheet=workbook.createSheet();
		Row row=sheet.createRow(0);
		for(int i=0,len=titles.size();i<len;i++)
			row.createCell(i).setCellValue(titles.get(i));
		List<List<Object>> datas=(List<List<Object>>) model.get("datas");
		Object cellValue;
		Cell cell;
		String tempStr;
		for(int i=0,len_i=datas.size();i<len_i;i++){
			row=sheet.createRow(i);
			for(int j=0,len_j=datas.get(i).size();i<len_j;j++){
				cellValue=datas.get(i).get(j);
				cell=row.createCell(j);
				if(cellValue instanceof Double)
					cell.setCellValue((Double) cellValue);
				else if(cellValue instanceof Date)
					cell.setCellValue((Date) cellValue);
				else if(cellValue instanceof String){
					tempStr=(String) cellValue;
					cell.setCellValue(StringUtils.isEmpty(tempStr)?"":tempStr);
				}else
					cell.setCellValue(String.valueOf(cellValue));
			}
		}
	}
}