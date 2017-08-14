package com.test.util;

import java.util.Random;

public class GetRandom {
	//生成指定位数的随机数
	public static String game(int count){
        StringBuffer sb = new StringBuffer();
        String str = "0123456789";
        Random r = new Random();
        for(int i=0;i<count;i++){
            int num = r.nextInt(str.length());
            sb.append(str.charAt(num));
        }
        return sb.toString();
    }
}
