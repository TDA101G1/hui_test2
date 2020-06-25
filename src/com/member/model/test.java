package com.member.model;

import java.sql.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class test {

	public static void main(String[] args) throws ParseException {
		String dateStr = "2010/05/04";
		java.util.Date utilDate = new java.util.Date();
		DateFormat formate = new SimpleDateFormat("yyyy/MM/dd");
		utilDate = formate.parse(dateStr);
		java.sql.Date sqlDate = new Date(utilDate.getTime());
		System.out.println(sqlDate);
		
	}

}
