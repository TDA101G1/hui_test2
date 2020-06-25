package com.comment.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.member.model.MemberVO;
import com.productcmt.model.ProductCmtService;
import com.productcmt.model.ProductCmtVO;


@WebServlet("/comment/Product_Comment.Controller")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class ProductCommentController extends HttpServlet {
	private static final long serialVersionUID = 1L;



	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
		
		if("writecomment".equals(action)) {
			Map<String, String> errorMsgs = new HashMap<String, String>();
			request.setAttribute("errorMsg", errorMsgs);
			
			try {
				HttpSession session = request.getSession();
				MemberVO member = (MemberVO) session.getAttribute("member");
				String member_ID = member.getMember_ID();
				String product_Cmt_Grade_tmp = request.getParameter("pgrade").trim();
				String product_Cmt_Info = request.getParameter("pcomment").trim();
				String product_ID = request.getParameter("productID");
				Double product_Cmt_Grade = null;
				Part part1 = request.getPart("pfile1");
				Part part2 = request.getPart("pfile2");
				
				InputStream in1 = part1.getInputStream();
				byte[]product_Cmt_Img1 = new byte[in1.available()];
				in1.read(product_Cmt_Img1);
				in1.close();
				
				InputStream in2 = part2.getInputStream();
				byte[]product_Cmt_Img2 = new byte[in2.available()];
				in2.read(product_Cmt_Img2);
				in2.close();
				
				if(product_Cmt_Grade_tmp == null || product_Cmt_Grade_tmp.length() == 0) {
					errorMsgs.put("grade_empty", "請給予等級");
				}
				if(product_Cmt_Info == null || product_Cmt_Info.length() == 0) {
					errorMsgs.put("comment_empty", "請留下評語");
				}else {
					product_Cmt_Grade = Double.parseDouble(product_Cmt_Grade_tmp);
				}
				
				ProductCmtVO productCmt = new ProductCmtVO();
				productCmt.setMember_ID(member_ID);
				productCmt.setProduct_Cmt_Grade(product_Cmt_Grade);
				productCmt.setProduct_Cmt_Img1(product_Cmt_Img1);
				productCmt.setProduct_Cmt_Img2(product_Cmt_Img2);
				productCmt.setProduct_Cmt_Info(product_Cmt_Info);
				productCmt.setProduct_ID(product_ID);
				
				if(!errorMsgs.isEmpty()) {
					request.setAttribute("productComment", productCmt);
					RequestDispatcher failureView = request.getRequestDispatcher("/frontstage_member/member_Order/Member_Order.jsp");
					failureView.forward(request, response);
					return;
				}
				
				ProductCmtService service = new ProductCmtService();
				ProductCmtVO cmtInsert = service.insert(productCmt);
				System.out.println(cmtInsert);
				
				response.sendRedirect(request.getContextPath() + "/frontstage_member/member_Comment/Member_Comment.jsp");
			}catch (Exception e) {
				errorMsgs.put("other", "cant get message" + e.getMessage());
				request.getRequestDispatcher("/frontstage_member/member_Order/Member_Order.jsp").forward(request, response);
				return;
			}	
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
