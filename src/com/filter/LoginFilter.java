package com.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.model.MemberVO;


@WebFilter(filterName = "LoginFilter", urlPatterns = {"/frontstage_member/member_Inbox/*",
													  "/frontstage_member/member_Order/*",
													  "/frontstage_member/member_Calendar/*",
													  "/frontstage_member/member_Collection/*",
													  "/frontstage_member/member_Comment/*",
													  "/frontstage_member/member_Credit_Card/*",
													  "/frontstage_member/member_Schedule/*",
													  "/frontstage_member/MemberUpdate.jsp",
													  "/hui_project/*",
													  "/CustomerizeController",
													  "/product/shoppingCar.jsp",
													  "/product/checkout.jsp"
													})
public class LoginFilter implements Filter {

	public void destroy() {
	} 


	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
//		System.out.println("filter");
		HttpSession session = req.getSession();
		MemberVO member = (MemberVO) session.getAttribute("member");
		if(member == null) {
			String action =req.getParameter("action");
			String schedule_id = req.getParameter("schedule_id");
//			System.out.println("====================================");
//			System.out.println(action + schedule_id);
			if(action != null) {
				if(schedule_id != null) {
					StringBuilder path = new StringBuilder();
					path.append(req.getRequestURI()).append("?action=").append(action).append("&schedule_id=").append(schedule_id);
					System.out.println("================================");
					System.out.println("我要去這邊" + path);
					session.setAttribute("location", path.toString());
					res.sendRedirect(req.getContextPath() + "/frontstage_member/login2.jsp");
				}
			}else {
				session.setAttribute("location", req.getRequestURI());
				res.sendRedirect(req.getContextPath() + "/frontstage_member/login2.jsp");
			}
		}else {
			
			chain.doFilter(request, response);
		}
	}

	
	public void init(FilterConfig fConfig) throws ServletException {
	}

}
