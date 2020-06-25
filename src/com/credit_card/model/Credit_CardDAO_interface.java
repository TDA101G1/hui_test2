package com.credit_card.model;

import java.util.List;
import java.util.Set;

public interface Credit_CardDAO_interface {
	public List<Credit_CardVO> selectAll();
	public Credit_CardVO insert(Credit_CardVO credit_CardVO);
	public Integer delete(String credit_Card_Number);
	public Credit_CardVO select(String credit_Card_Number);
	public Set<Credit_CardVO>getCredit_CardByMember_ID(String member_ID);
}
