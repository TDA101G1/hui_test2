package com.member.controller;

import java.awt.Graphics2D;
import java.awt.geom.Ellipse2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.member.model.MemberService;
import com.member.model.MemberVO;

@WebServlet("/member/ShowImage")
public class showMemberImageForBack extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
//		HttpSession session = request.getSession();
//		EmployeeVO bean = (EmployeeVO) session.getAttribute("member");	//from session
//		List<EmployeeVO> beans = (List<EmployeeVO>) request.getAttribute("members");
		String member_ID = request.getParameter("member_ID");
		response.setContentType("image/png");
		OutputStream os = response.getOutputStream();
		if(member_ID != null && member_ID.length() != 0) {
			List<MemberVO> beans = new MemberService().getAll();
			for (MemberVO bean : beans) {
				if (member_ID.equals(bean.getMember_ID())) {
//					System.out.println(employee_ID);
					if (bean.getMember_Img() != null) {									//確認資料庫中有無圖片
						byte[] image = bean.getMember_Img();
						InputStream is = new ByteArrayInputStream(image);
						imageOut(is,os);
//						System.out.println("DB:" + imageOut(is, os));
					} else {
						String imageDic = "/backstage/img/" + bean.getMember_Sex() + ".jpg";		//	判斷是男生或女生
						String realPath = getServletContext().getRealPath(imageDic);
						InputStream is = new FileInputStream(realPath);
//						System.out.println("realPath="+realPath);
						imageOut(is, os);
//						System.out.println("FILE:" + );
					}

				}

			}

		}

	}

//		byte[]member_Img = bean.getM_Img();
//		os.write(member_Img, 0, member_Img.length);
//		os.flush();
//		os.close();


	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

//================裁切圓形圖片===============================
	public boolean imageOut(InputStream is, OutputStream os) {
		boolean result = false;
		try {
			if (is.available() != 0) {
				BufferedImage bufferImage = ImageIO.read(is);
				int width = bufferImage.getWidth();
				BufferedImage circleBuffer = new BufferedImage(width, width, BufferedImage.TYPE_INT_ARGB);		//產生一個空的圖
				Graphics2D g2 = circleBuffer.createGraphics();													//利用這個圖的規格產生畫布
				g2.setClip(new Ellipse2D.Float(0, 0, width, width));
				g2.drawImage(bufferImage, 0, 0, width, width, null);
				result = ImageIO.write(circleBuffer, "png", os);
				return (result);
			} else {
				return result;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		return result;

	}

}
