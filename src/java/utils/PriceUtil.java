/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

/**
 *
 * @author Admin
 */
public class PriceUtil {
    public static String handlePrice(int n){
	String s = "" + n, res = "";
	int cnt = 0;
	for(int i = s.length() - 1; i >= 0; i--){
	    if(cnt % 3 == 0 && cnt > 0){
		res = "." + res;
	    }
	    res = s.charAt(i) + res;
	    cnt++;
	}
	return res;
    }
}
