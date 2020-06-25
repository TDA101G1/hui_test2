package com.inbox.model;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.inbox.model.InboxVO;

public interface InboxDAO_interface {
	public InboxVO select(String inbox_Mail_ID);
	public List<InboxVO>selectAll();
	public InboxVO insert(InboxVO inboxVO);
	public InboxVO update(InboxVO inboxVO);
	public Integer delete(String inbox_Mail_ID);
	public Set<InboxVO>selectByMember(String member_ID);
	public Set<InboxVO>selectByMember(String member_ID, Map<String, String[]>map);
}
