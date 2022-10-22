package com.portfolio.jinsu.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.portfolio.jinsu.DTO.HomeDTO;
import com.portfolio.jinsu.service.HomeService;

@Controller
public class HomeController {

	@Autowired
	HomeService hs;

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		List<String> tables = hs.getTables();
		List<String> columns = hs.getColumns();
		List<Map<String, String>> portfolioData = hs.getPortfolioData();
		
		for(int i=0; i<portfolioData.size(); i++) {
			Map<String,String> map = portfolioData.get(i);
			if(map!=null) {
				if(map.get("filePath1")!=null) {
					map.put("filePath1", map.get("filePath1").replace("\\", "/"));					
				}
			}
		}

		model.addAttribute("tables", tables);
		model.addAttribute("columns", columns);
		model.addAttribute("portfolioData", portfolioData);

		return "index";
	}
	
	@RequestMapping(value="/login", method = RequestMethod.POST)
	public void login(@RequestParam("id") String id, @RequestParam("pwd") String pwd, 
			HttpSession session, HttpServletResponse response) throws IOException {
		Map<String,String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("pwd", pwd);
		Map<String,String> result = hs.loginCheck(map);
		
		response.setContentType("text/html; charset=UTF-8");
	    PrintWriter out = response.getWriter();
		if(result!=null) {
			session.setAttribute("signIn", result);	
			out.println("<script>alert('로그인에 성공하였습니다.'); location.href='/';</script>");			
		} else {
			out.println("<script>alert('로그인에 실패하였습니다.'); location.href='/';</script>");
		}
		out.flush();
		response.flushBuffer();
		out.close();
	}
	
	@RequestMapping(value="/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

	@RequestMapping(value = "/getSeqList", method = RequestMethod.POST)
	@ResponseBody
	public List<String> getSeqList(@RequestBody Map<String, String> JSON) {
		List<String> seqList = hs.getSeqList(JSON);

		return seqList;
	}

	@RequestMapping(value = "/getSeqData", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> getSeqData(@RequestBody Map<String, String> JSON) {
		Map<String, String> seqData = hs.getSeqData(JSON);
		
		if(seqData!=null) {
			if(seqData.get("filePath1")!=null) {
				seqData.put("filePath1", seqData.get("filePath1").replace("\\", "/"));			
			} if(seqData.get("filePath2")!=null) {
				seqData.put("filePath2", seqData.get("filePath2").replace("\\", "/"));			
			} if(seqData.get("filePath3")!=null) {
				seqData.put("filePath3", seqData.get("filePath3").replace("\\", "/"));			
			}
		}		

		return seqData;
	}	
	
	@RequestMapping(value="/getRecentSeq", method = RequestMethod.POST)
	@ResponseBody
	public String getRecentSeq(@RequestBody Map<String, String> JSON) {
		String seq = hs.getRecentSeq(JSON);
		
		return seq;
	}
	
	@RequestMapping(value="/delData", method = RequestMethod.POST)
	@ResponseBody
	public void delData(@RequestBody Map<String, String> JSON) {
		hs.delData(JSON);
	}

	@RequestMapping(value = "/ImgDown", method = RequestMethod.GET)
	public void imgDown(@RequestParam("path") String path, HttpServletResponse response) {
		try {
			String[] firstName = path.split("\\/");
			String secondName = firstName[firstName.length - 1];
			String thirdName = secondName.substring(secondName.indexOf("_") + 1, secondName.length());
			String originalFileName = thirdName;

			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition", "attachment; filename=\"" + originalFileName + "\"");

			File file = new File(path);

			byte bytestream[] = new byte[100000000];

			if (file.isFile() && file.length() > 0) {
				FileInputStream fis = new FileInputStream(file);
				BufferedInputStream bis = new BufferedInputStream(fis);
				BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());

				int read = 0;

				while ((read = bis.read(bytestream)) != -1) {
					bos.write(bytestream, 0, read);
				}
				bos.close();
				bis.close();
			}
		} catch (Exception e) {

		}
	}	

	@RequestMapping(value = "/submitEditData", method = RequestMethod.POST)
	public String editData(HttpServletRequest request, MultipartHttpServletRequest mRequest)
			throws UnsupportedEncodingException {

		request.setCharacterEncoding("UTF-8");

		HomeDTO homeDTO = new HomeDTO();
		homeDTO.setSeq(request.getParameter("seq"));
		homeDTO.setTable(request.getParameter("table"));
		homeDTO.setTitle(request.getParameter("title"));
		homeDTO.setIntroduce(request.getParameter("introduce"));
		homeDTO.setLink(request.getParameter("link"));

		for (int i = 1; i <= 3; i++) {
			MultipartFile multipartfile[] = new MultipartFile[100];
			multipartfile[i] = mRequest.getFile("filePath" + i);

			if (multipartfile[i].isEmpty() == false) {
				String path = request.getSession().getServletContext().getRealPath("resources/savefile/");

				String ORIGINALFILENAME[] = new String[100];
				ORIGINALFILENAME[i] = multipartfile[i].getOriginalFilename();

				String SAVEFILENAME[] = new String[100];
				SAVEFILENAME[i] = path + System.currentTimeMillis() + ORIGINALFILENAME[i];

				if (i == 1) {
					homeDTO.setFilePath1(SAVEFILENAME[i]);
				} else if (i == 2) {
					homeDTO.setFilePath2(SAVEFILENAME[i]);
				} else if (i == 3) {
					homeDTO.setFilePath3(SAVEFILENAME[i]);
				}

				try {
					multipartfile[i].transferTo(new File(SAVEFILENAME[i]));
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}

		if (homeDTO.getSeq() == null) {
			hs.insertData(homeDTO);
		} else {
			hs.updateData(homeDTO);
		}

		return "redirect:/";
	}
}
