package com.util;

import java.awt.Graphics2D;
import java.awt.geom.Ellipse2D;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.model.MemberService;
import com.member.model.MemberVO;
import com.productcmt.model.ProductCmtService;
import com.productcmt.model.ProductCmtVO;

@WebServlet("/util/ShowCommentImage")
public class ShowCommentImage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
//		HttpSession session = request.getSession();
//		MemberVO bean = (MemberVO) session.getAttribute("member");	//from session
//		List<MemberVO> beans = (List<MemberVO>) request.getAttribute("members");
		String Product_Cmt_ID = request.getParameter("id");
		String cmt_Img = request.getParameter("number");
		response.setContentType("image/png");
		ServletOutputStream os = response.getOutputStream();
		BufferedOutputStream bos = new BufferedOutputStream(os);
		if(Product_Cmt_ID != null && Product_Cmt_ID.length() != 0) {
			ProductCmtVO bean_tmp = new ProductCmtVO();
			bean_tmp.setProduct_Cmt_ID(Product_Cmt_ID);
			ProductCmtVO bean = new ProductCmtService().select(bean_tmp);
			if("1".equals(cmt_Img)) {
				if (bean.getProduct_Cmt_Img1() != null) {									//確認資料庫中有無圖片
					byte[] image = bean.getProduct_Cmt_Img1();
					InputStream is = new ByteArrayInputStream(image);
					BufferedInputStream bis = new BufferedInputStream(is);
//					imageOut(bis, bos);
					bos.write(image);
					bis.close();
					is.close();
					bos.close();
					os.close();
				} else {
					String imageDic = "/img/david_img/6094@2x.jpg";		//	沒有圖片的會使用預設
					String realPath = getServletContext().getRealPath(imageDic);
//						System.out.println("realPath="+realPath);  
					
					InputStream is = new FileInputStream(realPath);
					BufferedInputStream bis = new BufferedInputStream(is);

//					imageOut(bis, bos);
					byte[]image = new byte[is.available()];
					is.read(image);
					bos.write(image);
					bis.close();
					is.close();
					bos.close();
					os.close();
				}
				
			}else {
				if (bean.getProduct_Cmt_Img2() != null) {									//確認資料庫中有無圖片
					byte[] image = bean.getProduct_Cmt_Img2();
					InputStream is = new ByteArrayInputStream(image);
					BufferedInputStream bis = new BufferedInputStream(is);

//					imageOut(bis, bos);
					bos.write(image);
					bis.close();
					is.close();
					bos.close();
					os.close();
					
				} else {
					String imageDic = "/img/david_img/backup1.jpg";		//	沒有圖片的會使用預設
					String realPath = getServletContext().getRealPath(imageDic);
					System.out.println(realPath);
					InputStream is = new FileInputStream(realPath);
					BufferedInputStream bis = new BufferedInputStream(is);

//					imageOut(bis, bos);
					byte[]image = new byte[is.available()];
					is.read(image);
					bos.write(image);
					bis.close();
					is.close();
					bos.close();
					os.close();
				}
				
			}
		}
		
	}

//		byte[]member_Img = bean.getMember_Img();
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
				int width = (bufferImage.getWidth() / 4);
				BufferedImage circleBuffer = new BufferedImage(width, width, BufferedImage.TYPE_INT_ARGB);		//產生一個空的圖
				Graphics2D g2 = circleBuffer.createGraphics();													//利用這個圖的規格產生畫布
//這行讓他變成圓形的
//				g2.setClip(new Ellipse2D.Float(0, 0, width, width)); 
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
