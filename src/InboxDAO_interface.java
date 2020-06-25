import java.util.List;

import com.inbox.model.InboxVO;

public interface InboxDAO_interface {
	public InboxVO select(Integer inbox_Mail_ID);
	public List<InboxVO>selectAll();
	public void insert(InboxVO inboxVO);
	public void update(InboxVO inboxVO);
	public void delete(Integer inbox_Mail_ID);
	
}
