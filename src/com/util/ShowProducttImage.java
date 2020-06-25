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

import com.product.model.ProductService;
import com.product.model.ProductVO;
import com.productcmt.model.ProductCmtService;
import com.productcmt.model.ProductCmtVO;

@WebServlet("/util/ShowProductImage")
public class ShowProducttImage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
//		HttpSession session = request.getSession();
//		MemberVO bean = (MemberVO) session.getAttribute("member");	//from session
//		List<MemberVO> beans = (List<MemberVO>) request.getAttribute("members");
		String Product_ID = request.getParameter("id");
		response.setContentType("image/png");
		ServletOutputStream os = response.getOutputStream();
		BufferedOutputStream bos = new BufferedOutputStream(os);
		if (Product_ID != null && Product_ID.length() != 0) {
			ProductVO bean_tmp = new ProductVO();
			bean_tmp.setProduct_ID(Product_ID);
			ProductVO bean = new ProductService().select(bean_tmp);
			if (bean.getProduct_Img1() != null) { // 確認資料庫中有無圖片
				byte[] image = bean.getProduct_Img1();
				InputStream is = new ByteArrayInputStream(image);
				BufferedInputStream bis = new BufferedInputStream(is);
//				imageOut(bis, bos);
				bos.write(image);
				bos.flush();
				bos.close();
				os.close();
				bis.close();
				is.close();
			} else {
				String imageDic = "/img/david_img/6094@2x.jpg"; // 沒有圖片的會使用預設
				String realPath = getServletContext().getRealPath(imageDic);
//						System.out.println("realPath="+realPath);  

				InputStream is = new FileInputStream(realPath);
				imageOut(is, os);
				is.close();
				os.close();
			}

		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

//================產生圖片===============================		
	public boolean imageOut(InputStream is, OutputStream os) {
		boolean result = false;
		try {
			if (is.available() != 0) {
				BufferedImage bufferImage = ImageIO.read(is);
				int factor = 4;
				int width = (bufferImage.getWidth() / factor);
				int height = (bufferImage.getHeight() / factor);
				BufferedImage circleBuffer = new BufferedImage((width), (width), BufferedImage.TYPE_INT_ARGB); // 產生一個空的圖
				Graphics2D g2 = circleBuffer.createGraphics(); // 利用這個圖的規格產生畫布
//這行讓他變成圓形的
				g2.drawImage(bufferImage, 0, 0, width, width, null);
//				g2.setClip(100, 0, (width/2), width);
				g2.dispose();
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
