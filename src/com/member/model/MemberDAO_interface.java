package com.member.model;

import java.util.List;

public interface MemberDAO_interface {

	public MemberVO insert(MemberVO memberVO);
	public MemberVO update(MemberVO memberVO);
	public MemberVO select(String member_ID);
	public List<MemberVO>selectAll();
	public MemberVO selectByAccount(String member_Account);
}
