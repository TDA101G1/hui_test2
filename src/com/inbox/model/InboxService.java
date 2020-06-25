package com.inbox.model;

import java.util.Comparator;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import com.util.SortMailState;

public class InboxService {
	private InboxDAO_interface dao;
	
	public InboxService() {
		dao = new InboxDAO_JDBC();
	}
	
	public List<InboxVO> getAll(){
		return dao.selectAll();
	}
	
	public InboxVO getOne(String inbox_Mail_ID) {
		return dao.select(inbox_Mail_ID);
	}

	
//搜尋 會員的“收件夾”  state = "4"
//搜尋 會員的“寄件夾”  state = "1"
	public Set<InboxVO>getInboxByMemberID(String state, String member_ID){
		Set<InboxVO>mails = dao.selectByMember(member_ID);
		SortMailState mail = new SortMailState();

		return mail.sortMail(state, mails);
	}
//	public Set<InboxVO>getOutboxByMemberID(String state, String member_ID){
//		Set<InboxVO>mails = dao.selectByMember(member_ID);
////		mails.removeIf(inboxVO -> (!inboxVO.getInbox_Mail_State().equals("1")));
////		Iterator<InboxVO>iter = mails.iterator();
////		while(iter.hasNext()) {
////			if(!iter.next().getInbox_Mail_State().equals("2")) {
////				iter.remove();
////			}
////		}
////		System.out.println("iter:"+ iter);
////		System.out.println("iter:"+ mails);
//		
////		TreeSet<InboxVO> mailTree = new TreeSet<InboxVO>(new Comparator<InboxVO>() {
////
////			@Override
////			public int compare(InboxVO o1, InboxVO o2) {
////				return -o1.getInbox_Mail_TimeStamp().compareTo(o2.getInbox_Mail_TimeStamp());
////			}
////		});
////		mailTree.addAll(mails);
////		System.out.println("mailTree:" + mailTree);
//		SortMailState mail = new SortMailState();
//		return mail.sortMail(state, mails);
//	}
	
	public InboxVO writeMail(String member_ID, String emp_ID, String inbox_Mail_Info, String inbox_Mail_Title, String inbox_Mail_State) {
		if(member_ID != null && inbox_Mail_Info != null && inbox_Mail_Title != null) {
			InboxVO inbox = new InboxVO();
			
			inbox.setEmp_ID(emp_ID);
			inbox.setInbox_Mail_Info(inbox_Mail_Info);
			inbox.setMember_ID(member_ID);
			inbox.setInbox_Mail_Title(inbox_Mail_Title);
			inbox.setInbox_Mail_State(inbox_Mail_State);
			
			InboxVO inbox_insert = dao.insert(inbox);
			InboxVO inbox_duplicate = new InboxVO();
			Integer tmp = Integer.parseInt(inbox_Mail_State) + 1;
			inbox_duplicate.setEmp_ID(emp_ID);
			inbox_duplicate.setInbox_Mail_Info(inbox_Mail_Info);
			inbox_duplicate.setInbox_Mail_State(tmp.toString());
			inbox_duplicate.setInbox_Mail_Title(inbox_Mail_Title);
			inbox_duplicate.setMember_ID(member_ID);
			
			InboxVO inbox_duplicate_tmp = dao.insert(inbox_duplicate);
			return inbox_insert;
			
			
//			return inbox;
			
		}
		return null;
	}
	
	public Integer deleteMail(String inbox_Mail_ID) {
		if(inbox_Mail_ID != null) {
			
			return dao.delete(inbox_Mail_ID);
		}
		return null;
	}
	
	public Set<InboxVO>getInboxByMemberID(String state, String member_ID, Map<String, String[]>map){
		Set<InboxVO>mails = dao.selectByMember(member_ID, map);
		SortMailState mail = new SortMailState();
		return mail.sortMail(state, mails);

	}
	
	public static void main(String[] args) {
		InboxService dao = new InboxService();
//		System.out.println(dao.getOne("IMID000000"));
//		System.out.println(dao.getAll());
		
//		InboxVO inbox = new InboxVO();
//		inbox.setEmp_ID("EID000001");
//		inbox.setInbox_Mail_Info("這是測試這是測試這是測試這是測試這是測試這是測試這是測試這是測試這是測試這是測試這是測試這是測試這是測試這是測試這是測試這是測試這是測試");
//		inbox.setMember_ID("MID000000");
//		inbox.setInbox_Mail_Title("test");
//		inbox.setInbox_Mail_State("1");
//		System.out.println(dao.writeMail(inbox.getMember_ID(), inbox.getEmp_ID(), inbox.getInbox_Mail_Info(), inbox.getInbox_Mail_Title(), inbox.getInbox_Mail_State()));
		
		
//		inbox.setInbox_Mail_ID("5");
//	    inbox.setEmp_ID("1000");
//		inbox.setMember_ID("5");
//		inbox.setInbox_Mail_Info("update test");
//		dao.update(inbox);
		
//		System.out.println(dao.deleteMail("IMID000010"));
		
//		System.out.println(dao.getInboxByMemberID("MID000000"));
//		System.out.println(dao.getOutboxByMemberID("1", "MID000000"));
		
	}
	
}
