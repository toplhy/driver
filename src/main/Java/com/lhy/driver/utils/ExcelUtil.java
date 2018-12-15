package com.lhy.driver.utils;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by lhy on 2017/4/15.
 */
public class ExcelUtil {

    private final static String excel2003L =".xls";
    private final static String excel2007U =".xlsx";

    public static List<List<Object>> getListByExcel(InputStream in, String fileName) throws Exception{
        List<List<Object>> list = null;
        //创建Excel工作薄
        Workbook work = getWorkbook(in,fileName);
        if(work != null){
            Row row = null;
            list = new ArrayList<List<Object>>();
            //遍历Excel中所有的sheet
            Sheet sheet = work.getSheetAt(0);
            if(sheet != null){
                //遍历当前sheet中的所有行
                for (int i = sheet.getFirstRowNum(); i <= sheet.getLastRowNum(); i++) {
                    row = sheet.getRow(i);
                    if(row == null || i==0 || i==1 ){
                        continue;
                    }
                    //遍历所有的列
                    List<Object> li = new ArrayList<Object>();
                    for (int j = row.getFirstCellNum(); j < row.getLastCellNum(); j++) {
                        li.add(getCellValue(row.getCell(j)));
                    }
                    list.add(li);
                }
            }
            work.close();
        }
        return list;
    }

    public static Workbook getWorkbook(InputStream in, String fileName) throws Exception{
        Workbook wb = null;
        String fileType = fileName.substring(fileName.lastIndexOf("."));
        if(excel2003L.equals(fileType)){
            wb = new HSSFWorkbook(in);
        }else if(excel2007U.equals(fileType)){
            wb = new XSSFWorkbook(in);
        }else{
            throw new Exception("Excel文件格式有误！");
        }
        return wb;
    }

    private static Object getCellValue(Cell cell) {
        if(null != cell){
            Object value = null;
            switch (cell.getCellType()) {
                case Cell.CELL_TYPE_STRING:
                    value = cell.getRichStringCellValue().getString();
                    break;
                case Cell.CELL_TYPE_NUMERIC:
                    if(org.apache.poi.ss.usermodel.DateUtil.isCellDateFormatted(cell))
                        value = new SimpleDateFormat("yyyy-MM-dd").format(cell.getDateCellValue());
                    else{
                        value = cell.getNumericCellValue();
                    }
                    break;
                case Cell.CELL_TYPE_BOOLEAN:
                    value = cell.getBooleanCellValue();
                    break;
                case Cell.CELL_TYPE_BLANK:
                    value = "";
                    break;
                default:
                    value = null;
                    break;
            }
            return value;
        }else{
            return "";
        }
    }
}
