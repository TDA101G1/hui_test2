package com.credit_card.model;

import java.util.List;
import java.util.Set;

public class Credit_CardService {
	private Credit_CardDAO_interface dao;
	
	public Credit_CardService() {
		dao = new Credit_CardDAO_JDBC();
	}
	
	public Credit_CardVO getOne(String credit_Card_Number) {
		if(credit_Card_Number != null) {
			
			return dao.select(credit_Card_Number);
		}
		return null;
	}
	
	public List<Credit_CardVO> getAll(){
		return dao.selectAll();
	}
	
	public Credit_CardVO addCredit_Card(String credit_Card_Number, String member_ID, String credit_Card_Owner_Name, 
			String credit_Card_Expire_M, String credit_Card_Expire_Y, String credit_Card_Address, 
			String credit_Card_Postal_Code, Integer credit_Card_State) {
		
		if(credit_Card_Address != null && credit_Card_Expire_M != null && credit_Card_Expire_Y != null && credit_Card_Number != null && credit_Card_Owner_Name != null && 
				credit_Card_Postal_Code != null && credit_Card_State != null && member_ID != null) {
			
			Credit_CardVO card = new Credit_CardVO();
			card.setCredit_Card_Number(credit_Card_Number);
			card.setCredit_Card_Expire_Y(credit_Card_Expire_Y);
			card.setCredit_Card_Address(credit_Card_Address);
			card.setCredit_Card_Expire_M(credit_Card_Expire_M);
			card.setCredit_Card_Owner_Name(credit_Card_Owner_Name);
			card.setCredit_Card_Postal_Code(credit_Card_Postal_Code);
			card.setCredit_Card_State(credit_Card_State);
			card.setMember_ID(member_ID);
			
			dao.insert(card);
			
			return card;
		}
		return null;
		
		
	}
	
	public Integer deleteCredit_Card(String credit_Card_Number) {
		if(credit_Card_Number != null) {
			
			return dao.delete(credit_Card_Number);
		}
		return null;
	}
	
	public Set<Credit_CardVO>getCredit_CardByMember_ID(String member_ID){
		if(member_ID != null) {
			return dao.getCredit_CardByMember_ID(member_ID);
		}
		return null;
		
	}
	
	
	public static void main(String[] args) {
		Credit_CardService dao = new Credit_CardService();
		System.out.println(dao.getAll());
		System.out.println(dao.getOne("1234567890123456"));
//		System.out.println(dao.addCredit_Card("1111111111111111", "MID000001", "David", "05", "23", "new Taipei City", "221", 1));
//		System.out.println(dao.deleteCredit_Card("1111111111111111"));
		System.out.println(dao.getCredit_CardByMember_ID("MID000001"));
	}
	
}
