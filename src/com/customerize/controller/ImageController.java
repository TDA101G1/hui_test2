package com.customerize.controller;

import java.awt.Graphics2D;
import java.awt.geom.Ellipse2D;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.member.model.MemberService;
import com.member.model.MemberVO;
import com.product.model.ProductService;
import com.product.model.ProductVO;
import com.productcmt.model.ProductCmtService;
import com.productcmt.model.ProductCmtVO;

@WebServlet("/ImageController")
public class ImageController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setContentType("image/gif");
		ServletOutputStream outs = res.getOutputStream();
		String action = req.getParameter("action");
		
		if ("printImage_product_id".equals(action)) {
			String product_id = req.getParameter("product_id");
			ProductVO bean = new ProductVO();
			bean.setProduct_ID(product_id);
			ProductService dao = new ProductService();
			ProductVO result = dao.select(bean);
			byte[] image = null;
			if(result != null) {
				image = result.getProduct_Img1();
				if (image != null && image.length != 0) {
					outs.write(image);
					outs.flush();
					outs.close();
				}else {
					FileInputStream fin = new FileInputStream(req.getServletContext().getRealPath("/img/hui/oops.png"));
					BufferedInputStream bin = new BufferedInputStream(fin);
					int length = 0;
					byte[] b = new byte[4096];
					while ((length = bin.read(b)) != -1) {
						// b: 代表要輸出的byte陣列 (資料都放在裡面了)
						// 0: 代表從這個陣列的第一個元素開始輸出 (索引值)
						// length: 代表要輸出的資料量
						outs.write(b, 0, length);
					}
					bin.close();
					fin.close();
					outs.flush();
					outs.close();
				}
			} else {
				FileInputStream fin = new FileInputStream(req.getServletContext().getRealPath("/img/hui/oops.png"));
				BufferedInputStream bin = new BufferedInputStream(fin);
				int length = 0;
				byte[] b = new byte[4096];
				while ((length = bin.read(b)) != -1) {
					// b: 代表要輸出的byte陣列 (資料都放在裡面了)
					// 0: 代表從這個陣列的第一個元素開始輸出 (索引值)
					// length: 代表要輸出的資料量
					outs.write(b, 0, length);
				}
				bin.close();
				fin.close();
				outs.flush();
				outs.close();
			}
		}
		
		if ("printImage_cmt_id".equals(action)) {
			String product_cmt_id = req.getParameter("product_cmt_id");
			String img = req.getParameter("img");
			ProductCmtService dao = new ProductCmtService();
			ProductCmtVO bean = new ProductCmtVO();
			bean.setProduct_Cmt_ID(product_cmt_id);
			byte[] image = null;
			if (img.equals("img1")) {
				bean = dao.select(bean);
				image = bean.getProduct_Cmt_Img1();
				if (image != null && image.length != 0) {
					outs.write(image);
					outs.flush();
					outs.close();
				}else {
					FileInputStream fin = new FileInputStream(req.getServletContext().getRealPath("/NoData/null4.jpg"));
					BufferedInputStream bin = new BufferedInputStream(fin);
					int length = 0;
					byte[] b = new byte[4096];
					while ((length = bin.read(b)) != -1) {
						// b: 代表要輸出的byte陣列 (資料都放在裡面了)
						// 0: 代表從這個陣列的第一個元素開始輸出 (索引值)
						// length: 代表要輸出的資料量
						outs.write(b, 0, length);
					}
					bin.close();
					fin.close();
					outs.flush();
					outs.close();
				}
				
			}
			if (img.equals("img2")) {
				bean = dao.select(bean);
				image = bean.getProduct_Cmt_Img2();
				if (image != null && image.length != 0) {
					outs.write(image);
					outs.flush();
					outs.close();
				}else {
					FileInputStream fin = new FileInputStream(req.getServletContext().getRealPath("/NoData/null4.jpg"));
					BufferedInputStream bin = new BufferedInputStream(fin);
					int length = 0;
					byte[] b = new byte[4096];
					while ((length = bin.read(b)) != -1) {
						// b: 代表要輸出的byte陣列 (資料都放在裡面了)
						// 0: 代表從這個陣列的第一個元素開始輸出 (索引值)
						// length: 代表要輸出的資料量
						outs.write(b, 0, length);
					}
					bin.close();
					fin.close();
					outs.flush();
					outs.close();
				}
			}
		}
		
		
		if ("printImage_member_id".equals(action)) {
			String member_id = req.getParameter("member_id");
			MemberService dao = new MemberService();
			MemberVO result = dao.getOne(member_id);
			byte[] image = null;
			if(result != null) {
				image = result.getMember_Img();
				if (image != null && image.length != 0) {
					InputStream is = new ByteArrayInputStream(image);
					System.out.println("DB:" + imageOut(is, outs));
//					outs.write(image);
					is.close();
					outs.flush();
					outs.close();
				}else {
					InputStream fin = new FileInputStream(req.getServletContext().getRealPath("/img/hui/oops.png"));
					System.out.println("DB:" + imageOut(fin, outs));
//					FileInputStream fin = new FileInputStream(req.getServletContext().getRealPath("/project/img/oops.png"));
//					BufferedInputStream bin = new BufferedInputStream(fin);
//					int length = 0;
//					byte[] b = new byte[4096];
//					while ((length = bin.read(b)) != -1) {
//						// b: 代表要輸出的byte陣列 (資料都放在裡面了)
//						// 0: 代表從這個陣列的第一個元素開始輸出 (索引值)
//						// length: 代表要輸出的資料量
//						outs.write(b, 0, length);
//					}
//					bin.close();
					fin.close();
					outs.flush();
					outs.close();
				}
			} else {
				InputStream fin = new FileInputStream(req.getServletContext().getRealPath("/img/hui/oops.png"));
				System.out.println("DB:" + imageOut(fin, outs));
				fin.close();
				outs.flush();
				outs.close();
			}
		}

	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
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
