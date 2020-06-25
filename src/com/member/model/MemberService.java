package com.member.model;

import java.sql.Date;
import java.util.List;

import redis.clients.jedis.Jedis;

public class MemberService {
	private MemberDAO_interface dao;

	public MemberService() {
		dao = new MemberDAO_JDBC(); // 要套成別的如JNDI版本重這邊改
	}

	public List<MemberVO> getAll() {
		return dao.selectAll();
	}

	public MemberVO getOne(String member_ID) {
		if(member_ID != null) {
			
			return dao.select(member_ID);
		}
		return null;
	}

	public MemberVO insert(String member_Account, String member_Pwd, String member_Name, String member_Phone,
			String member_Sex, java.sql.Date member_Birth, String member_Mail, String member_Address, byte[] member_Img,
			java.sql.Date member_Est_Time, Integer member_State) {
		if (member_Account != null && member_Pwd != null && member_Name != null && member_Sex != null
				&& member_Mail != null && member_Address != null && member_Est_Time != null && member_State != null) {
			MemberVO memberVO = new MemberVO();

			memberVO.setMember_Account(member_Account);
			memberVO.setMember_Pwd(member_Pwd);
			memberVO.setMember_Name(member_Name);
			memberVO.setMember_Phone(member_Phone);
			memberVO.setMember_Sex(member_Sex);
			memberVO.setMember_Birth(member_Birth);
			memberVO.setMember_Mail(member_Mail);
			memberVO.setMember_Address(member_Address);
			memberVO.setMember_Img(member_Img);
			memberVO.setMember_Est_Time(member_Est_Time);
			memberVO.setMember_State(member_State);

			return dao.insert(memberVO);
//			return memberVO;

		}
		return null;
	}

	public MemberVO login(String member_Account, String member_Pwd) {
		System.out.println("呼叫login");
		MemberVO bean = dao.selectByAccount(member_Account);
		if (bean != null) {
			if (member_Pwd != null && member_Pwd.length() != 0) {
				String temp_Pwd = bean.getMember_Pwd();
				if (temp_Pwd.equals(member_Pwd)) {
					return bean;
				}
			}
		}
		return null;

	}

	public MemberVO update(String member_ID, String member_Account, String member_Pwd, String member_Name,
			String member_Phone, String member_Sex, java.sql.Date member_Birth, String member_Mail,
			String member_Address, byte[] member_Img, java.sql.Date member_Est_Time, Integer member_State) {
		if (member_ID != null && member_Account != null && member_Pwd != null && member_Name != null && member_Sex != null
				&& member_Mail != null && member_Address != null && member_Est_Time != null && member_State != null) {
			MemberVO memberVO = new MemberVO();

			memberVO.setMember_ID(member_ID);
			memberVO.setMember_Account(member_Account);
			memberVO.setMember_Pwd(member_Pwd);
			memberVO.setMember_Name(member_Name);
			memberVO.setMember_Phone(member_Phone);
			memberVO.setMember_Sex(member_Sex);
			memberVO.setMember_Birth(member_Birth);
			memberVO.setMember_Mail(member_Mail);
			memberVO.setMember_Address(member_Address);
			memberVO.setMember_Img(member_Img);
			memberVO.setMember_Est_Time(member_Est_Time);
			memberVO.setMember_State(member_State);

			return dao.update(memberVO);
//			return memberVO;
		}
		return null;
	}
	

	public static void main(String[] args) {
		MemberService dao = new MemberService();
		System.out.println(dao.getAll());
//		System.out.println(dao.getOne("MID000002"));

		MemberVO member = new MemberVO();
//		member.setMember_ID("MID000004");
		member.setMember_Account("GGININ");
		member.setMember_Address("高雄大雅");
		member.setMember_Birth(java.sql.Date.valueOf("1999-04-02"));
		java.sql.Date today = new Date(new java.util.Date().getTime());
//		java.sql.Date today = null;
		member.setMember_Est_Time(today);
		member.setMember_Mail("abc@gmail.com");
		member.setMember_Name("王大陸");
		member.setMember_Phone("0912345678");
		member.setMember_Pwd("123");
		member.setMember_Sex("M");
		member.setMember_State(1);

		System.out.println(dao.insert(member.getMember_Account(), member.getMember_Pwd(), member.getMember_Name(),
				member.getMember_Phone(), member.getMember_Sex(), member.getMember_Birth(), member.getMember_Mail(),
				member.getMember_Address(), member.getMember_Img(), member.getMember_Est_Time(),
				member.getMember_State()));
		
//		System.out.println(dao.update(member.getMember_ID(),member.getMember_Account(), member.getMember_Pwd(), member.getMember_Name(),
//				member.getMember_Phone(), member.getMember_Sex(), member.getMember_Birth(), member.getMember_Mail(),
//				member.getMember_Address(), member.getMember_Img(), member.getMember_Est_Time(),
//				member.getMember_State()));
		
//		System.out.println(dao.login("david7838", "123"));

	}

}
