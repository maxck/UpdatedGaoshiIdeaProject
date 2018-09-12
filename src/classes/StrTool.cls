/**
*Dis:处理字符的的公共方法
*Author:Somnus Wang
*Time:2015年3月5日11:05:23
**/
public with sharing class StrTool {
	//截取字符串的长度
	public static String wrapLine(String oldStr, Integer chartNum,Integer counts)
    {
        if(oldStr!=null) 
        {
            Integer flag = 0;
            String retStr = '';
            List<String> lineList = oldStr.split('\n');
            for(Integer i=0;i<lineList.size(); i++)
            {
                String lineStr = lineList[i];
                if(lineStr.length() > chartNum)
                {
                         retStr += lineStr.substring(0,chartNum) + '\n';
                         lineStr = lineStr.substring(chartNum);
                }
                while(lineStr.length() > counts){
                         retStr += lineStr.substring(0,counts) + '\n';
                         lineStr = lineStr.substring(counts);
                }
                if(lineStr.length() > 0)
                {
                         retStr += lineStr + '\n';
                }
        }
        return retStr;
        }else
        {
        return '';
        }
    }
    
    //去除多余的html
	public  static String wrapLine(String input){
		String result = '';
		if (input == null || input.trim().equals('')) {
			return '';
		}else{
			String str = input.replaceAll('\\&[a-zA-Z]{1,10};', '').replaceAll('<[^>]*>', '');
			result = str.replaceAll('[(/>)<]', '');
		}
		return result;
	}
}