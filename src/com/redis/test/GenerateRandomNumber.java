package com.redis.test;

import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

public class GenerateRandomNumber {
//	A~Z 的 ASCII範圍是 65~90
//	a~z 的 ASCII範圍是 97~122
//  數字 的 ASCII範圍是 48～57
	Set<Character> set = new HashSet();
	public String genAuthCode() {
		int random;
		while(set.size() < 8) {
			random = (int)(Math.random()*3 + 1);
			if (random ==1) {
				set.add((char)(Math.random()*26 + 65));
			}
			if(random == 2) {
				set.add((char)(Math.random() * 26 +97));
			}
			if (random == 3) {
				set.add((char)(Math.random()*10 + 48));
			}	
		}
		StringBuilder sb = new StringBuilder();
		for(Character ch : set) {
			sb.append(ch.toString());
		}
		
		return sb.toString();
		
	}
	public static void main(String[] args) {
		GenerateRandomNumber a = new GenerateRandomNumber();
	
		System.out.println(a.genAuthCode());
	}

}
