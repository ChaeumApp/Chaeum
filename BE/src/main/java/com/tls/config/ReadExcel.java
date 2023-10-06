package com.tls.config;

import java.io.FileInputStream;
import java.io.IOException;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ReadExcel {

    public List<String[]> readExcel(String filename) {
        List<String[]> result = new ArrayList<>();
        try {
            FileInputStream file = new FileInputStream("src/main/resources/"+filename);
            XSSFWorkbook workbook = new XSSFWorkbook(file);
            NumberFormat f = NumberFormat.getInstance();
            f.setGroupingUsed(false);    //지수로 안나오게 설정
            //시트 갯수
            int sheetNum = workbook.getNumberOfSheets();

            for (int s = 0; s < sheetNum; s++) {
                XSSFSheet sheet = workbook.getSheetAt(s);
                //행 갯수
                int rows = sheet.getPhysicalNumberOfRows();
                for (int r = 0; r < rows; r++) {
                    XSSFRow row = sheet.getRow(r);

                    int cells = row.getPhysicalNumberOfCells();
                    String[] oneRecipe = new String[cells];
//                    System.out.print("|	" + r + "	|");
                    for (int c = 0; c < cells; c++) {
                        XSSFCell cell = row.getCell(c);

                        String value = "";
                        if (cell != null) {
                            //타입 체크
                            switch (cell.getCellType()) {
                                case STRING:
                                    value = cell.getStringCellValue();
                                    break;
                                case NUMERIC:
                                    value = f.format(cell.getNumericCellValue()) + "";
                                    break;
                                case BLANK:
                                    value = cell.getBooleanCellValue() + "";
                                    break;
                                case ERROR:
                                    value = cell.getErrorCellValue() + "";
                                    break;
                            }
                        }
                        oneRecipe[c] = value;
//                        System.out.print("		" + value + "		|");
                    }
                    result.add(oneRecipe);
//                    System.out.println();
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return result;
    }
}
