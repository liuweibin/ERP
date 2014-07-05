package com.erp.core.web;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/checkCode")
public class CheckCodeController extends HttpServlet {

	public CheckCodeController() {
		super();
	}

	public void destroy() {
		super.destroy();
	}

	public void init() throws ServletException {
		super.init();
	}

	public Color getRandColor(int s, int e) {//给定范围获得随机颜色 
		Random random = new Random();
		if (s > 255)
			s = 255;
		if (e > 255)
			e = 255;
		int r = s + random.nextInt(e - s);
		int g = s + random.nextInt(e - s);
		int b = s + random.nextInt(e - s);
		return new Color(r, g, b);
	}
	@RequestMapping("service.do")
	public void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 禁止缓存
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "No-cache");
		response.setDateHeader("Expires", 0);
		
		// 指定生成的响应是图片
		response.setContentType("image/jpeg");
		OutputStream os=response.getOutputStream();  
		int width = 60 ,height = 20;
		BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB); // 创建BufferedImage类的对象
		Graphics g = image.getGraphics(); // 创建Graphics类的对象
		Graphics2D g2d = (Graphics2D) g; // 通过Graphics类的对象创建一个Graphics2D类的对象
		Random random = new Random(); // 实例化一个Random对象
		g.setColor(getRandColor(200,250)); // 改变图形的当前颜色为随机生成的颜色
		g.fillRect(0, 0, width, height); // 绘制一个填色矩形
		//设定字体 
		g.setFont(new Font("Times New Roman",Font.PLAIN,18));
		g.setColor(getRandColor(160,200)); 
		for (int i=0;i<155;i++) 
		{ 
		int x = random.nextInt(width); 
		int y = random.nextInt(height); 
		int xl = random.nextInt(12); 
		int yl = random.nextInt(12); 
		g.drawLine(x,y,x+xl,y+yl); 
		} 
		
		// 取随机产生的认证码(4位数字) 
		String sRand=""; 
		for (int i=0;i<4;i++){ 
		String rand=String.valueOf(random.nextInt(10));
		sRand+=rand; 
		// 将认证码显示到图象中 
		g.setColor(new Color(20+random.nextInt(110),20+random.nextInt(110),20+random.nextInt(110)));//调用函数出来的颜色相同，可能是因为种子太接近，所以只能直接生成 
		g.drawString(rand,13*i+6,16); 
		} 
		
		// 生成并输出随机的验证文字
		
		// 将生成的验证码保存到Session中
		HttpSession session = request.getSession(true);
		session.removeAttribute("validateCode");
		session.setAttribute("validateCode", sRand);
		// 图象生效
		g.dispose();
		// 输出图象到页面 
		ImageIO.write(image, "JPEG", os);
		
		os.flush();  
		os.close();  
		os=null; 
	}

}
