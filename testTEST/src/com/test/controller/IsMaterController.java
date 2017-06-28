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

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.imgscalr.Scalr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
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

import com.test.dao.IsMaterDAOOracle;
import com.test.vo.IsMater;


@Controller
public class IsMaterController {
	
	
	@Autowired
	IsMaterDAOOracle dao;

	@Resource(name="uploadPath")
    String uploadPath;
	
	 @RequestMapping(value = "/ajaxUpload.do")
	    public String ajaxUpload() {
	        return "insert.jsp";
	    }
	     
	    @RequestMapping(value = "/fileUpload.do")
	    public String fileUp(MultipartHttpServletRequest multi) {
	         
	    	System.out.println("file up 들어옴");
	        String root = multi.getSession().getServletContext().getRealPath("/");
	        String path = root+"upload";
	        System.out.println("실제 저장경로 : " +path);
	        String newFileName = ""; // 업로드 되는 파일명
	        File dir = new File(path);
	        System.out.println("dir  ??  : " +dir);
	        if(!dir.isDirectory()){
	        	dir.mkdir();
	        }
	        
	        
	        
	        
	        //파일이름 가져오기
	        Iterator<String> files = multi.getFileNames();
	        while(files.hasNext()){
	        	
	            String uploadFile = files.next();
	            MultipartFile mFile = multi.getFile(uploadFile);
	            String fileName = mFile.getOriginalFilename();
	            System.out.println("실제 파일 이름 : " +fileName);
	            
	            newFileName = System.currentTimeMillis()+"."+fileName.substring(fileName.lastIndexOf(".")+1);
	            //System.out.println("저장되는 파일 이름 : " +newFileName);
	            try {
	                mFile.transferTo(new File(path+newFileName));
	                System.out.println("try 들어옴");
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	        }
	         
	        return "ajaxUpload.do";
	    }
	    
	    

	    @RequestMapping(value="uploadAjax.do", method=RequestMethod.GET)
	    public void uploadAjax(){
	        // uploadAjax.jsp로 포워딩
	    }

	    // produces="text/plain;charset=utf-8" : 파일 한글처리
	    @ResponseBody
	    @RequestMapping(value="uploadAjax.do", method=RequestMethod.POST, produces="text/plain;charset=utf-8")
	    public ResponseEntity<String> uploadAjax(MultipartFile file) throws Exception {
	        return new ResponseEntity<String>(uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes()), HttpStatus.OK);
	    }
	    

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
			   String drink_capacity){
	    	
	    	String jumin_no= jumin_no1+"-"+jumin_no2;
	    	String bir = year+"/"+month+"/"+day+"("+bir_type+")";
	    	String address = address1 +address2;
	    	String phone = phone1+"-"+phone2+"-"+phone3;
	    	String msg="-1";
	    	
	    	
	    	//결혼여부 db값으로 교체
	    	if("married".equals(marital_status)){
	    		marital_status = "y";
	    	}else{
	    		marital_status = "n";
	    	}
	    	
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
	    
	    
	    int listSize;
	    @RequestMapping("selectAll.do")
	    public String selectAll(Model model, 
	    						int pageno,
	    						@RequestParam(required=false, defaultValue="") String searchItem,
		    					@RequestParam(required=false, defaultValue="") String searchValue
		    					
	    						){
	    	
	    	//리스트 10개씩 불러오기
	    	List <IsMater> list = new ArrayList<>();
	    	int startPage = pageno*10-9;
	    	int endPage = pageno*10;
	    	
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
	    	
	    	if("".equals(searchValue)){
	    		list = dao.selectAll(startPage,endPage,"",searchValue);
	    	}else{
	    		list = dao.selectAll(startPage,endPage,searchItem,searchValue);	
	    	}
	        
	    	
	    	System.out.println("listSize : "+listSize);
	    	model.addAttribute("list",list);
	    	model.addAttribute("listSize",listSize);
	    	return "/list.jsp";
	    	
	    	/*if("".equals(searchItem)){
	    		list = dao.selectAll(startPage,endPage);
				
			}else if("name".equals(searchItem) && !"".equals(searchValue)){
				list = dao.selectByName(searchValue);
				
			}else if("sex".equals(searchItem) && !"".equals(searchValue)){
				im = dao.selectBySex(searchValue);
				if(im != null){
					list.add(im);
				} 
			}else if("teclev".equals(searchItem) && !"".equals(searchValue)){
				im = dao.selectByTeclev(searchValue);
				if(im != null){
					list.add(im);
				} 
			}*/
	    	
	    	
	    }
	    
	   /* @RequestMapping("/search.do")
	    public String search(@RequestParam(required=false, defaultValue="") String searchItem,
	    					 @RequestParam(required=false, defaultValue="") String searchValue, 
	    					Model model){
	    	
	    	System.out.println(searchItem);
	    	List <IsMater> list = new ArrayList<>();
	    	
			IsMater im = new IsMater();
			System.out.println("searchItem : "+searchItem);
			System.out.println("searchValue : "+searchValue);
			if("".equals(searchItem)){
				list = dao.selectAll();
				
			}else if("name".equals(searchItem) && !"".equals(searchValue)){
				list = dao.selectByName(searchValue);
				
			}else if("no".equals(searchItem) && !"".equals(searchValue)){
				p = dao.selectByNo(searchValue);
				if(p != null){
				list.add(p);
				} 
			}
			model.addAttribute("list", list);
	    	model.addAttribute("searchItem",searchItem);
	    	return null;
	    }*/
	    
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

	    
	    @RequestMapping("selectByNo.do")
	    public String selectByNo(String checkedId,Model model,HttpSession session){
	    	
	    	IsMater im = new IsMater();
	    	im = dao.selectByNo(checkedId);
	    	
	    	System.out.println(im);
	    	
	    	model.addAttribute("im",im);
	    	session.setAttribute("im",im);
	    	return "modify.jsp";
	    }
	    
	    
	    
	    @RequestMapping("/modify.do")
		   public String modify(Model model,
				   String no,
				   String image_name,
				   String year,
				   String month,
				   String day,
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
				   String drink_capacity){
		    	
	    	System.out.println("no :"+no);
	    	
	    	String bir = year+"/"+month+"/"+day;
	    	String address = address1 +address2;
	    	String phone = phone1+"-"+phone2+"-"+phone3;
	    	String msg="-1";
	    	System.out.println("pay_type :"+pay_type);
	    	
	    	IsMater im = new IsMater(no,image_name,
	    			bir, "w", "y", work_date, pay_type, work_flag,
	    			join_type, address, phone, email, tech_lev, drink_capacity);
	    	
	    	System.out.println(im);
	    	
	    	if(im !=null){
	    		dao.modify(im);
	    		msg="1";
	    	}
	    	model.addAttribute("msg",msg);
	    	return "result.jsp";
	    }
	    
	    
	    
	   /* // 4. Ajax업로드 페이지 매핑
	    @RequestMapping(value="/upload/uploadAjax", method=RequestMethod.GET)
	    public void uploadAjax(){
	        // uploadAjax.jsp로 포워딩
	    }

	    // 5. Ajax업로드 처리 매핑
	    // 파일의 한글처리 : produces="text/plain;charset=utf-8"
	    @ResponseBody // view가 아닌 data리턴
	    @RequestMapping(value="/upload/uploadAjax", method=RequestMethod.POST, produces="text/plain;charset=utf-8")
	    public ResponseEntity<String> uploadAjax(MultipartFile file) throws Exception {
	        return new ResponseEntity<String>(UploadFileUtils.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes()), HttpStatus.OK);
	    }*/

	    
	    
	    // 6. 이미지 표시 매핑
	    @ResponseBody // view가 아닌 data리턴
	    @RequestMapping("displayFile.do")
	    public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {
	        // 서버의 파일을 다운로드하기 위한 스트림
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
	    
	    public static String uploadFile(String uploadPath, String originalName, byte[] fileData) throws Exception {
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
	        // 나머지는 아이콘
	        } else {
	            // 아이콘 생성
	            uploadedFileName = makeIcon(uploadPath, savedPath, savedName);
	        }
	        return uploadedFileName;
	    }

	    // 날짜별 디렉토리 추출
	    private static String calcPath(String uploadPath) {
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

	    // 디렉토리 생성
	    private static void makeDir(String uploadPath, String... paths) {
	        // 디렉토리가 존재하면
	        if (new File(paths[paths.length - 1]).exists()){
	            return;
	        }
	        // 디렉토리가 존재하지 않으면
	        for (String path : paths) {
	            // 
	            File dirPath = new File(uploadPath + path);
	            // 디렉토리가 존재하지 않으면
	            if (!dirPath.exists()) {
	                dirPath.mkdir(); //디렉토리 생성
	            }
	        }
	    }    

	    // 썸네일 생성
	    private static String makeThumbnail(String uploadPath, String path, String fileName) throws Exception {
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
	        // 아이콘의 이름
	        String iconName = uploadPath + path + File.separator + fileName;
	        // 아이콘 이름을 리턴
	        // File.separatorChar : 디렉토리 구분자
	        // 윈도우 \ , 유닉스(리눅스) /         
	        return iconName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	    }
	    
	    

   
}
