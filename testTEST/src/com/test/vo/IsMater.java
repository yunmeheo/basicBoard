package com.test.vo;

public class IsMater {
	
	String no;//                VARCHAR2(4) NOT NULL,
    String kor_name;//   KOR_NAME           VARCHAR2(20) NULL,한글이름
    String eng_name;//   ENG_NAME    ;//        VARCHAR2(20) NULL,영문이름
    String chn_name;//   CHN_NAME    ;//         VARCHAR2(20) NULL,영문이름
    String jumin_no;//   JUMIN_NO    ;//         VARCHAR2(14) NULL,주민번호
    String image_name;//   IMAGE_NAME   ;//        VARCHAR2(50) NULL,사진파일명
    String bir;//   BIR   ;//               VARCHAR2(15) NULL,     ***생년월일
    String sex;//   SEX ;//                 VARCHAR2(1) NULL,성별
    String marital_status;//    MARITAL_STATUS  ;//     VARCHAR2(1) NULL, 결혼여부
    String work_date;//    WORK_DATE   ;//         VARCHAR2(4) NULL,년차
    String pay_type;//    PAY_TYPE   ;//          VARCHAR2(4) NULL,급여지금유형
    String work_flag;//   WORK_FLAG  ;//          VARCHAR2(2) NULL,희망직무
    String join_type;//     JOIN_TYPE   ;//         VARCHAR2(2) NULL,입사유형
    String address;//    ADDRESS  ;//            VARCHAR2(20) NULL,주소
    String phone;//    PHONE ;//               VARCHAR2(15) NULL,연락처
	String email;//    EMAIL;//                VARCHAR2(50) NULL 이메일
	String tech_lev;//    TECH_LEV ;//            VARCHAR2(10) NULL,기술등급
	String drink_Capacity;//             VARCHAR2(10) NULL,주량
	/*String no;// iS_MATER;//	NO	Varchar2	4	-	-	1	-	-	-
	String korName; //KOR_NAME;//	Varchar2	20	-	-	-	널 가능	-	-
	String juminNo;//JUMIN_NO;//	Varchar2	14	-	-	-	널 가능	-	-
	String engName;//ENG_NAME;//	Varchar2	20	-	-	-	널 가능	-	-
	String sex;//SEX;//	Varchar2	1	-	-	-	널 가능	-	-
	String lastSchool;//LAST_SCHOOL;//	Varchar2	15	-	-	-	널 가능	-	-
	String major;//MAJOR;//	Varchar2	15	-	-	-	널 가능	-	-
	String graduDate;//GRADU_DATE;//	Varchar2	10	-	-	-	널 가능	-	-
	String comLag;//COM_LAG;//	Varchar2	4	-	-	-	널 가능	-	-
	String licence1;//LICENCE1;//	Varchar2	20	-	-	-	널 가능	-	-
	String licence2;//	Varchar2	20	-	-	-	널 가능	-	-
	String licence3;//	Varchar2	20	-	-	-	널 가능	-	-
	String techLev;//TECH_LEV;//	Varchar2	10	-	-	-	널 가능	-	-
	String address;//ADDRESS;//	Varchar2	20	-	-	-	널 가능	-	-
	String workDate;//WORK_DATE;//	Varchar2	10	-	-	-	널 가능	-	-
	String state;//STATE;//	Varchar2	1	-	-	-	널 가능	-	-
	String image;//IMAGE;//	Varchar2	50	-	-	-	널 가능	-	-
	String workFlag;//WORK_FLAG;//	Varchar2	1	-	-	-	널 가능	-	-
	String phone;//PHONE;//	Varchar2	15	-	-	-	널 가능	-	-
	String email;//EMAIL;//	Varchar2	50	-
*/
	
	//수정시
	public IsMater(String no,String image_name,
			String bir, String sex, String marital_status, String work_date, String pay_type, String work_flag,
			String join_type, String address, String phone, String email, String tech_lev, String drink_Capacity) {
		super();
		this.no = no;
		this.image_name = image_name;
		this.bir = bir;
		this.sex = sex;
		this.marital_status = marital_status;
		this.work_date = work_date;
		this.pay_type = pay_type;
		this.work_flag = work_flag;
		this.join_type = join_type;
		this.address = address;
		this.phone = phone;
		this.email = email;
		this.tech_lev = tech_lev;
		this.drink_Capacity = drink_Capacity;
	}
	
	
	
	//등록시
	public IsMater(String kor_name, String eng_name, String chn_name, String jumin_no, String image_name,
			String bir, String sex, String marital_status, String work_date, String pay_type, String work_flag,
			String join_type, String address, String phone, String email, String tech_lev, String drink_Capacity) {
		super();
		this.kor_name = kor_name;
		this.eng_name = eng_name;
		this.chn_name = chn_name;
		this.jumin_no = jumin_no;
		this.image_name = image_name;
		this.bir = bir;
		this.sex = sex;
		this.marital_status = marital_status;
		this.work_date = work_date;
		this.pay_type = pay_type;
		this.work_flag = work_flag;
		this.join_type = join_type;
		this.address = address;
		this.phone = phone;
		this.email = email;
		this.tech_lev = tech_lev;
		this.drink_Capacity = drink_Capacity;
	}
	
	public IsMater() {
		super();
	}


	public String getNo() {
		return no;
	}
	
	public void setNo(String no) {
		this.no = no;
	}
	public String getKor_name() {
		return kor_name;
	}
	public void setKor_name(String kor_name) {
		this.kor_name = kor_name;
	}
	public String getEng_name() {
		return eng_name;
	}
	public void setEng_name(String eng_name) {
		this.eng_name = eng_name;
	}
	public String getChn_name() {
		return chn_name;
	}
	public void setChn_name(String chn_name) {
		this.chn_name = chn_name;
	}
	public String getJumin_no() {
		return jumin_no;
	}
	public void setJumin_no(String jumin_no) {
		this.jumin_no = jumin_no;
	}
	public String getImage_name() {
		return image_name;
	}
	public void setImage_name(String image_name) {
		this.image_name = image_name;
	}
	public String getBir() {
		return bir;
	}
	public void setBir(String bir) {
		this.bir = bir;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getMarital_status() {
		return marital_status;
	}
	public void setMarital_status(String marital_status) {
		this.marital_status = marital_status;
	}
	public String getWork_date() {
		return work_date;
	}
	public void setWork_date(String work_date) {
		this.work_date = work_date;
	}
	public String getPay_type() {
		return pay_type;
	}
	public void setPay_type(String pay_type) {
		this.pay_type = pay_type;
	}
	public String getWork_flag() {
		return work_flag;
	}
	public void setWork_flag(String work_flag) {
		this.work_flag = work_flag;
	}
	public String getJoin_type() {
		return join_type;
	}
	public void setJoin_type(String join_type) {
		this.join_type = join_type;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTech_lev() {
		return tech_lev;
	}
	public void setTech_lev(String tech_lev) {
		this.tech_lev = tech_lev;
	}
	public String getdrink_Capacity() {
		return drink_Capacity;
	}
	public void setdrink_Capacity(String drink_Capacity) {
		this.drink_Capacity = drink_Capacity;
	}
	@Override
	public String toString() {
		return "IsMater [no=" + no + ", kor_name=" + kor_name + ", eng_name=" + eng_name + ", chn_name=" + chn_name
				+ ", jumin_no=" + jumin_no + ", image_name=" + image_name + ", bir=" + bir + ", sex=" + sex
				+ ", marital_status=" + marital_status + ", work_date=" + work_date + ", pay_type=" + pay_type
				+ ", work_flag=" + work_flag + ", join_type=" + join_type + ", address=" + address + ", phone=" + phone
				+ ", email=" + email + ", tech_lev=" + tech_lev + ", drink_Capacity=" + drink_Capacity + "]";
	}	

	
	
	
	
	

}
