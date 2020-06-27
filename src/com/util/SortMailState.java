package com.util;

import java.util.Comparator;
import java.util.Set;
import java.util.TreeSet;

import com.inbox.model.InboxVO;

public class SortMailState {
	public Set<InboxVO> sortMail(String mail_State, Set<InboxVO>mailByMemberID){
		if(mail_State != null & mail_State.length() != 0) {
			mailByMemberID.removeIf(inboxVO -> (!inboxVO.getInbox_Mail_State().equals(mail_State)));
			
			TreeSet<InboxVO> mailTree = new TreeSet<InboxVO>(new Comparator<InboxVO>() {

				@Override
				public int compare(InboxVO o1, InboxVO o2) {
					return -o1.getInbox_Mail_TimeStamp().compareTo(o2.getInbox_Mail_TimeStamp());
				}
			});
			
			mailTree.addAll(mailByMemberID);
			return mailTree;

		}
		
		return null;
		
	}
}