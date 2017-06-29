package com.test.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.logging.Logger;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.imgscalr.Scalr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.test.dao.IsMaterDAOOracle;
import com.test.vo.IsMater;


@Controller
public class IsMaterController {


	@Autowired
	IsMaterDAOOracle dao;

	@Resource(name="uploadPath")
	String uploadPath;


	//파일 클릭시 업로드 1
	@RequestMapping(value = "/ajaxUpload.do")
	public String ajaxUpload() {
		System.out.println("IsMaterController , ajaxUpload");
		return "insert.jsp";
	}
	
	//파일 클릭시 업로드 2  
	@RequestMapping(value = "/fileUpload.do")
	public String fileUp(MultipartHttpServletRequest multi,Model model,HttpSession session) throws Exception {

		System.out.println("IsMaterController , fileUp");
		session.removeAttribute("newFileName");  //setAttribute("newFileName",newFileName);
		session.removeAttribute("realPath");  //session.setAttribute("realPath",realPath);

		System.out.println("file up 들어옴");
		// String root = multi.getSession().getServletContext().getRealPath("/");
		//String path = root+"upload";

		String path = uploadPath;

		System.out.println("실제 저장경로 : " +path);
		String newFileName = ""; // 업로드 되는 파일명
		File dir = new File(path);
		System.out.println("dir  ??  : " +dir);
		if(!dir.isDirectory()){
			dir.mkdir();
		}

		//파일이름 가져오기
		Iterator<String> files = multi.getFileNames();
		String fileName ="";
		while(files.hasNext()){

			String uploadFile = files.next();
			MultipartFile mFile = multi.getFile(uploadFile);
			fileName = mFile.getOriginalFilename();

			System.out.println("실제 파일 이름 : " +fileName);
			//newFileName = System.currentTimeMillis()+"."+fileName.substring(fileName.lastIndexOf(".")+1);
			//System.out.println("저장되는 파일 이름 : " +newFileName);

			//중복되지 않도록 이름 변경하기
			newFileName = uploadFile(fileName,fileName.getBytes());
			System.out.println("newFileName :"+newFileName);

			try {
				mFile.transferTo(new File(path+newFileName));
				System.out.println("try 들어옴");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		String realPath = path;
		System.out.println("newFileName : "+newFileName);
		System.out.println("realPath : "+realPath);

		//저장한 파일이름을 저장한다.
		session.setAttribute("newFileName",newFileName);
		//session.setAttribute("realPath",realPath);
		
		return "ajaxUpload.do";
	}


	// 파일명 랜덤생성 메서드
	private String uploadFile(String originalName, byte[] fileData) throws Exception{
		System.out.println("IsMaterController , uploadFile");
		// uuid 생성(Universal Unique IDentifier, 범용 고유 식별자)
		UUID uuid = UUID.randomUUID();
		// 랜덤생성+파일이름 저장
		String savedName = uuid.toString()+"_"+originalName;
		File target = new File(uploadPath, savedName);
		// 임시디렉토리에 저장된 업로드된 파일을 지정된 디렉토리로 복사
		// FileCopyUtils.copy(바이트배열, 파일객체)
		FileCopyUtils.copy(fileData, target);
		return savedName;
	}


	// xml에 설정된 리소스 참조
	// bean의 id가 uploadPath인 태그를 참조
	// 업로드 흐름 : 업로드 버튼클릭 => 임시디렉토리에 업로드=> 지정된 디렉토리에 저장 => 파일정보가 file에 저장
	/* @RequestMapping(value="/uploadForm.do", method=RequestMethod.GET)
	    public void uplodaForm(){
	        // upload/uploadForm.jsp(업로드 페이지)로 포워딩
	    }

	    @RequestMapping(value="/uploadForm.do", method=RequestMethod.POST)
	    public ModelAndView uplodaForm(@RequestParam("uploadfile") MultipartFile file, ModelAndView mav) throws Exception{


	        String savedName = file.getOriginalFilename();
	        File target = new File(uploadPath, savedName);
	        // 임시디렉토리에 저장된 업로드된 파일을 지정된 디렉토리로 복사
	        // FileCopyUtils.copy(바이트배열, 파일객체)
	        FileCopyUtils.copy(file.getBytes(), target);
	        mav.setViewName("insert.jsp");
	        mav.addObject("msg", savedName);

	        return mav; // uploadResult.jsp(결과화면)로 포워딩
	    }*/


	//드레그로 파일 업로드 1
	@RequestMapping(value="uploadAjax.do", method=RequestMethod.GET)
	public void uploadAjax(){
		System.out.println("IsMaterController , uploadAjax GET");
		// uploadAjax.jsp로 포워딩
	}

	//드레그로 파일 업로드 2
	@ResponseBody
	@RequestMapping(value="uploadAjax.do", method=RequestMethod.POST, produces="text/plain;charset=utf-8")
	public ResponseEntity<String> uploadAjax(MultipartFile file) throws Exception {
		System.out.println("IsMaterController , uploadAjax POST");
		
		System.out.println("MultipartFile file"+file);
		return new ResponseEntity<String>(uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes()), HttpStatus.OK);
	}


	//등록하기
	@RequestMapping("/insert.do")
	public String insert(Model model,
			String kor_name,
			String eng_name,
			String chn_name,
			String jumin_no1,
			String jumin_no2,
			String image_name,
			String year,
			String month,
			String day,
			String bir_type,
			String sex,
			String marital_status,
			String work_date,
			String pay_type,
			String work_flag,
			String join_type,
			String address1,
			String address2,
			String phone1,
			String phone2,
			String phone3,
			String email,
			String tech_lev,
			String drink_capacity,
			HttpSession session){
		
		session.removeAttribute("newFileName");  //setAttribute("newFileName",newFileName);
		session.removeAttribute("realPath");  //session.setAttribute("realPath",realPath);

		
		//결혼여부 db값으로 교체
		if("solarCalendar".equals(bir_type)){
			bir_type = "양력";
		}else{
			bir_type = "음력";
		}
		
		//양력음력 변경
		if("married".equals(marital_status)){
			marital_status = "y";
		}else{
			marital_status = "n";
		}
		
		String jumin_no= jumin_no1+"-"+jumin_no2;
		String bir = year+"/"+month+"/"+day+"/"+bir_type;
		String address = address1 +"/"+address2;
		String phone = phone1+"-"+phone2+"-"+phone3;
		String msg="-1";

		System.out.println("bir : "+bir);

		System.out.println("pay_type :"+pay_type);

		IsMater im = new IsMater(kor_name,eng_name, chn_name,jumin_no, image_name,
				bir, sex, marital_status , work_date, pay_type, work_flag,
				join_type, address, phone, email, tech_lev, drink_capacity);

		System.out.println(im);

		if(im !=null){
			dao.insert(im);
			msg="1";
		}
		model.addAttribute("msg",msg);
		return "result.jsp";
	}
 
	
	//리스트의 결과사이즈 체크할 메서드
	int listSize;
	@RequestMapping("selectAll.do")
	public String selectAll(Model model, 
			int pageno,
			@RequestParam(required=false, defaultValue="all") String searchItem,
			@RequestParam(required=false, defaultValue="") String searchValue,
			HttpSession session,
			String pageClick
			){
		
		
		//검색값
		System.out.println("searchItem : "+searchItem+", searchValue : "+searchValue);
		
		//리스트 10개씩 불러오기
		List <IsMater> list = new ArrayList<>();
		int startPage = pageno*5-4;
		int endPage = pageno*5;

		//객체생성
		IsMater im = new IsMater();

		//총사이즈 한번만 구하기
		int cnt=0;
		if(cnt == 0){
			cnt ++;
			//검색할때마다 총리스트 다시 구해줘야함 조건.
			listSize = dao.selectAll(searchItem,searchValue).size();
		}

		//검색결과 리스트
		/*if("".equals(searchValue)){
			list = dao.selectAll(startPage,endPage,"",searchValue);
		}else{
			list = dao.selectAll(startPage,endPage,searchItem,searchValue);	
		}*/
		
		//전체검색 했을 경우엔
		
		if(pageClick == null){
			
			session.removeAttribute("searchItem");//(, searchItem);
			session.removeAttribute("searchValue");//, searchValue);
			
			
		}
		
		
		
		if("".equals(searchValue)){
			System.out.println("(String)session.getAttribute(searchValue) :"+(String)session.getAttribute("searchValue") );
			if((String)session.getAttribute("searchValue") !=null){
				System.out.println("if의 세션 유");
				System.out.println("searchItem : "+(String)session.getAttribute("searchItem")+(String)session.getAttribute("searchValue"));
				list = dao.selectAll(startPage,endPage,(String)session.getAttribute("searchItem"),(String)session.getAttribute("searchValue"));	
				
			}else{
				System.out.println("if의 세션 무");
				list = dao.selectAll(startPage,endPage,"",searchValue);
			}
			
		}else if(!"".equals(searchValue)){
			
			System.out.println("if else 들어옴");
			
			session.setAttribute("searchItem", searchItem);
			session.setAttribute("searchValue", searchValue);
			
			/*searchItem = (String)session.getAttribute(searchItem);
			searchValue = (String)session.getAttribute(searchValue);*/
			
			list = dao.selectAll(startPage,endPage,searchItem,searchValue);	
			
		}
		
		
		
		
		/*//처음에 들어올때의 리스트
		if("".equals(searchValue)){
			list = dao.selectAll(startPage,endPage,"",searchValue);
		}else if(){
			
			list = dao.selectAll(startPage,endPage,searchItem,searchValue);	
		}*/
		
		
		
		System.out.println("listSize : "+listSize);
		model.addAttribute("list",list);
		model.addAttribute("listSize",listSize);
		return "/list.jsp";

	}

	//삭제하기
	@RequestMapping("delete.do")
	public String delete(Model model, String checkedId){

		System.out.println("checkedId : "+checkedId);

		String msg = "-1";
		if(checkedId !=null){
			System.out.println("삭제중입니다용");
			dao.delete(checkedId);
			msg="1";
		}

		model.addAttribute("msg",msg);
		return "result.jsp";
	}

	//번호로 ismater 객체 가져오기
	@RequestMapping("selectByNo.do")
	public String selectByNo(String checkedId,Model model,HttpSession session){

		IsMater im = new IsMater();
		im = dao.selectByNo(checkedId);

		System.out.println(im);
		
		String bir = im.getBir();
		String[] birArr = bir.split("/");
		
		String phone = im.getPhone();
		String[] phoneArr = phone.split("-");
		
		/*String address = im.getPhone();
		String[] addressArr = address.split("-");*/
		
		String jumin_no = im.getJumin_no();
		String[] jumin_noArr = jumin_no.split("-");
		
		String address = im.getAddress();
		String[] addressArr = address.split("/");
		

		model.addAttribute("im",im);
		model.addAttribute("birArr",birArr);
		model.addAttribute("phoneArr",phoneArr);
		model.addAttribute("jumin_noArr",jumin_noArr);
		model.addAttribute("addressArr",addressArr);
		
		session.setAttribute("im",im);
		
		
		
		return "modify.jsp";
	}


	//수정하기
	@RequestMapping("/modify.do")
	public String modify(Model model,
			String no,
			String jumin_no1,
			String jumin_no2,
			String image_name,
			String year,
			String month,
			String day,
			String bir_type,
			String sex,
			String marital_status,
			String work_date,
			String pay_type,
			String work_flag,
			String join_type,
			String address1,
			String address2,
			String phone1,
			String phone2,
			String phone3,
			String email,
			String tech_lev,
			String drink_capacity,
			HttpSession session){
		
		
		//결혼여부 db값으로 교체
		if("solarCalendar".equals(bir_type)){
			bir_type = "양력";
		}else{
			bir_type = "음력";
		}
		
		//양력음력 변경
		if("married".equals(marital_status)){
			marital_status = "y";
		}else{
			marital_status = "n";
		}

		System.out.println("modify   marital_status : "+marital_status+", sex : "+sex);
		session.removeAttribute("newFileName");  //setAttribute("newFileName",newFileName);
		session.removeAttribute("realPath");  //session.setAttribute("realPath",realPath);
		
		System.out.println("no :"+no);

		String jumin_no= jumin_no1+"-"+jumin_no2;
		String bir = year+"/"+month+"/"+day+"/"+bir_type;
		String address = address1 +address2;
		String phone = phone1+"-"+phone2+"-"+phone3;
		String msg="-1";
		System.out.println("pay_type :"+pay_type);

		IsMater im = new IsMater(no,jumin_no, image_name,
				bir, sex, marital_status, work_date, pay_type, work_flag,
				join_type, address, phone, email, tech_lev, drink_capacity);

		System.out.println(im);

		if(im !=null){
			dao.modify(im);
			msg="1";
		}
		model.addAttribute("msg",msg);
		return "result.jsp";
	}

	// 이미지 표시 매핑
	@ResponseBody // view가 아닌 data리턴
	@RequestMapping("/displayFile.do")
	public ResponseEntity<byte[]> displayFile(String fileName, HttpSession session) throws Exception {
		System.out.println("IsMaterController , displayFile");
		// 서버의 파일을 다운로드하기 위한 스트림
		System.out.println("fileName : "+fileName );
		InputStream in = null; //java.io
		ResponseEntity<byte[]> entity = null;
		try {
			// 확장자를 추출하여 formatName에 저장
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
			// 추출한 확장자를 MediaUtils클래스에서  이미지파일여부를 검사하고 리턴받아 mType에 저장
			MediaType mType = getMediaType(formatName);
			// 헤더 구성 객체(외부에서 데이터를 주고받을 때에는 header와 body를 구성해야하기 때문에)
			HttpHeaders headers = new HttpHeaders();
			// InputStream 생성
			in = new FileInputStream(uploadPath + fileName);
			// 이미지 파일이면
			if (mType != null) { 
				headers.setContentType(mType);
				// 이미지가 아니면
			} else { 
				fileName = fileName.substring(fileName.indexOf("_") + 1);
				// 다운로드용 컨텐트 타입
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				// 
				// 바이트배열을 스트링으로 : new String(fileName.getBytes("utf-8"),"iso-8859-1") * iso-8859-1 서유럽언어, 큰 따옴표 내부에  " \" 내용 \" "
				// 파일의 한글 깨짐 방지
				headers.add("Content-Disposition", "attachment; filename=\""+new String(fileName.getBytes("utf-8"), "iso-8859-1")+"\"");
				//headers.add("Content-Disposition", "attachment; filename='"+fileName+"'");
			}
			// 바이트배열, 헤더, HTTP상태코드
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			// HTTP상태 코드()
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			in.close(); //스트림 닫기
		}
		System.out.println("entity : "+entity);
		
		//업로드 후 세션을 지워준다.
		session.removeAttribute("newFileName");
		//session.setAttribute("newFileName", fileName);
		return entity;
	}


	private static Map<String, MediaType> mediaMap;
	// 자동로딩
	static {
		mediaMap = new HashMap<String, MediaType>();
		mediaMap.put("JPG", MediaType.IMAGE_JPEG);
		mediaMap.put("GIF", MediaType.IMAGE_GIF);
		mediaMap.put("PNG", MediaType.IMAGE_PNG);
	}
	public static MediaType getMediaType(String type) {
		return mediaMap.get(type.toUpperCase());
	}

	//파일 업로드 메서드
	public static String uploadFile(String uploadPath, String originalName, byte[] fileData) throws Exception {
		
		System.out.println("IsMaterController , uploadFile");
		// UUID 발급
		UUID uuid = UUID.randomUUID();
		// 저장할 파일명 = UUID + 원본이름
		String savedName = uuid.toString() + "_" + originalName;
		// 업로드할 디렉토리(날짜별 폴더) 생성 
		String savedPath = calcPath(uploadPath);
		// 파일 경로(기존의 업로드경로+날짜별경로), 파일명을 받아 파일 객체 생성
		File target = new File(uploadPath + savedPath, savedName);
		// 임시 디렉토리에 업로드된 파일을 지정된 디렉토리로 복사
		FileCopyUtils.copy(fileData, target);
		// 썸네일을 생성하기 위한 파일의 확장자 검사
		// 파일명이 aaa.bbb.ccc.jpg일 경우 마지막 마침표를 찾기 위해
		String formatName = originalName.substring(originalName.lastIndexOf(".")+1);
		String uploadedFileName = null;
		// 이미지 파일은 썸네일 사용
		if (getMediaType(formatName) != null) {
			// 썸네일 생성
			uploadedFileName = makeThumbnail(uploadPath, savedPath, savedName);
		} else {
			// 아이콘 생성
			uploadedFileName = makeIcon(uploadPath, savedPath, savedName);
		}
		return uploadedFileName;
	}
	
	

	// 날짜별 디렉토리 추출
	private static String calcPath(String uploadPath) {
		System.out.println("IsMaterController , calcPath");
		Calendar cal = Calendar.getInstance();
		// File.separator : 디렉토리 구분자(\\)
		// 연도, ex) \\2017 
		String yearPath = File.separator + cal.get(Calendar.YEAR);
		System.out.println(yearPath);
		// 월, ex) \\2017\\03
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
		System.out.println(monthPath);
		// 날짜, ex) \\2017\\03\\01
		String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		System.out.println(datePath);
		// 디렉토리 생성 메서드 호출
		makeDir(uploadPath, yearPath, monthPath, datePath);
		
		
		return datePath;
	}

	// 저장소 생성
	private static void makeDir(String uploadPath, String... paths) {
		System.out.println("IsMaterController , makeDir");
		// 디렉토리가 존재하면
		if (new File(paths[paths.length - 1]).exists()){
			System.out.println("저장소 있어서 안 만들게요");
			return;
		}
		// 디렉토리가 존재하지 않으면
		for (String path : paths) {
			
			File dirPath = new File(uploadPath + path);
			// 디렉토리가 존재하지 않으면
			if (!dirPath.exists()) {
				System.out.println("저장소없어서 만들었어요.");
				dirPath.mkdir(); //디렉토리 생성
			}
		}
	}    

	// 썸네일 생성
	private static String makeThumbnail(String uploadPath, String path, String fileName) throws Exception {
		System.out.println("IsMaterController , makeThumbnail");
		
		System.out.println("uploadPath:"+uploadPath+", path:"+path+", fileName:"+fileName);
		
		
		// 이미지를 읽기 위한 버퍼
		BufferedImage sourceImg = ImageIO.read(new File(uploadPath + path, fileName));
		// 100픽셀 단위의 썸네일 생성
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);
		// 썸네일의 이름을 생성(원본파일명에 's_'를 붙임)
		String thumbnailName = uploadPath + path + File.separator + "s_" + fileName;
		File newFile = new File(thumbnailName);
		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
		// 썸네일 생성
		ImageIO.write(destImg, formatName.toUpperCase(), newFile);
		// 썸네일의 이름을 리턴함
		return thumbnailName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}

	// 아이콘 생성
	private static String makeIcon(String uploadPath, String path, String fileName) throws Exception {
		System.out.println("IsMaterController , makeIcon");
		// 아이콘의 이름
		String iconName = uploadPath + path + File.separator + fileName;
		// 아이콘 이름을 리턴
		// File.separatorChar : 디렉토리 구분자
		// 윈도우 \ , 유닉스(리눅스) /         
		return iconName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}

	
	 //파일 삭제 매핑
    @ResponseBody // view가 아닌 데이터 리턴
    @RequestMapping(value = "/deleteFile.do", method = RequestMethod.POST)
    public ResponseEntity<String> deleteFile(String fileName) {
        // 파일의 확장자 추출
        String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
        // 이미지 파일 여부 검사
        MediaType mType = getMediaType(formatName);
        // 이미지의 경우(썸네일 + 원본파일 삭제), 이미지가 아니면 원본파일만 삭제
        // 이미지 파일이면
        if (mType != null) {
            // 썸네일 이미지 파일 추출
            String front = fileName.substring(0, 12);
            String end = fileName.substring(14);
            // 썸네일 이미지 삭제
            new File(uploadPath + (front + end).replace('/', File.separatorChar)).delete();
        }
        // 원본 파일 삭제
        new File(uploadPath + fileName.replace('/', File.separatorChar)).delete();

        // 데이터와 http 상태 코드 전송
        return new ResponseEntity<String>("deleted", HttpStatus.OK);
    }



}
