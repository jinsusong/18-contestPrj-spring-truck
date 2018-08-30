package poly.controller;

import java.io.File;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Spliterator;

import javax.annotation.Resource;
import javax.mail.Multipart;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.crypto.dsig.spec.HMACParameterSpec;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.mysql.jdbc.Util;

import poly.dto.consumer.CONSUMER_DissInfoDTO;
import poly.dto.consumer.CONSUMER_Gps_TableDTO;
import poly.dto.consumer.CONSUMER_WeatherDTO;
import poly.dto.seller.SELLER_DissInfoDTO;
import poly.dto.seller.SELLER_FtDistrictDataDTO;
import poly.dto.seller.SELLER_FtSellerDTO;
import poly.dto.seller.SELLER_Gps_TableDTO;
import poly.dto.seller.SELLER_ImageDTO;
import poly.dto.seller.SELLER_WeatherDTO;
import poly.service.SELLER_IFtSellerService;
import poly.service.SELLER_IImageService;
import poly.util.SELLER_UtilFile;
import poly.util.SortRegCode;
import poly.util.UtilTime;
import poly.util.CmmUtil;
import poly.util.Coord;
import poly.util.OpenAPI;



@Controller
public class SELLER_FtSellerController {
	private Logger log = Logger.getLogger(this.getClass());
	//로그를 찍고 파일로 남깁니다 .
	public String getDate() {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy. MM. dd / hh:mm:ss");
		String date = sdf1.format(cal.getTime());
		return date;
	}
	
	/* String savePath= "C:\\Users\\data20\\Desktop\\TwSpring\\SpringPRJ\\WebContent\\uploadImg\\"; 
	 // 이거는 로컬 경로를 뜻하는지 알아야됨
*/	
	@Resource(name="SELLER_FtSellerService")
	private SELLER_IFtSellerService FtSellerService;
	
	@Resource(name="SELLER_ImageService")
	private SELLER_IImageService ImgService;
	
	
	//트럭 정보 등록 페이지
	@RequestMapping(value="/seller/ft/ftReg")
	public String ftReg() throws Exception{
		log.info(this.getClass() + " ftReg STart !!");
		log.info(this.getClass() + " ftReg end !!!");
		
		
		return "/seller/ft/ftReg";
	}
	
	//insert 트럭정보
	@RequestMapping(value="/seller/ft/ftRegProc")
	public String ftRegProc(HttpServletRequest request, Model model,@RequestParam("fileId")MultipartFile file, MultipartHttpServletRequest multiRequest) throws Exception{
		log.info(this.getClass()  + " ftRegProc Start !!@");
		
	//	String fileId = CmmUtil.nvl(request.getParameter("ftSeq"));
		String userSeq = CmmUtil.nvl(request.getParameter("userSeq"));
		String ftName = CmmUtil.nvl(request.getParameter("ftName"));
		String ftIntro = CmmUtil.nvl(request.getParameter("ftIntro"));
		String selName = CmmUtil.nvl(request.getParameter("selName"));
		String selNo = CmmUtil.nvl(request.getParameter("selNo"));
		String ftStatus = CmmUtil.nvl(request.getParameter("ftStatus"));
		String ftOptime = request.getParameter("ft_bday")+"/"+request.getParameter("ft_open_time")+"/"+request.getParameter("ft_close_time");
		String ftFunc=""; 
		String ftJoin="";
		
		ftJoin=UtilTime.getDateYMDhms();
		
		if(request.getParameter("delivery")!=null) {
			ftFunc += request.getParameter("delivery")+"/";
		}
		if(request.getParameter("order")!=null) {
			ftFunc += request.getParameter("order")+"/";
		}
		if(request.getParameter("catering")!=null) {
			ftFunc += request.getParameter("catering")+"/";
		}
		//githtest
	

//		log.info("ftsellerController fileId : " + fileId);
		log.info("ftsellerController ftName : " +ftName );
		log.info("ftsellerController ftIntro : " + ftIntro);
		log.info("ftsellerController selName : " + selName);
		log.info("ftsellerController ftFunc : " + ftFunc);
		log.info("ftsellerController ftOptiom : " + ftOptime);
		log.info("ftsellerController ftStatus  : " + ftStatus);
		log.info("ftsellerControoler ftJoin : " + ftJoin);
		
		SELLER_FtSellerDTO ftSDTO = new SELLER_FtSellerDTO();
		ftSDTO.setUserSeq(userSeq);
		ftSDTO.setFtName(ftName);
		ftSDTO.setFtIntro(ftIntro);
		ftSDTO.setSelName(selName);
		ftSDTO.setSelNo(selNo);
		ftSDTO.setFtStatus(ftStatus);
		ftSDTO.setFtFunc(ftFunc);
		ftSDTO.setFtOptime(ftOptime);
		ftSDTO.setFtJoin(ftJoin);
		
		
		SELLER_ImageDTO imgDTO = new SELLER_ImageDTO();
		
		if(!file.isEmpty()) {
			//	      UtilFile 객체 생성
				        SELLER_UtilFile utilFile = new SELLER_UtilFile();
				        
			//	      파일 업로드 결과값을 path로 받아온다(이미 fileUpload() 메소드에서 해당 경로에 업로드는 끝났음)
				        String uploadPath = utilFile.fileUpload(multiRequest, file, imgDTO);
				        imgDTO.setUser_seq(0);
				        imgDTO.setFile_path(uploadPath);
			//	      해당 경로만 받아 db에 저장
				        ImgService.Image_Add(imgDTO);
				        String file_id = ImgService.getFile_Seq();
				        //System.out.println("RewardController reAddProCtrl n : " + n);
				        System.out.println("RewardController reAddProCtrl uploadPath : " + uploadPath);
				        ftSDTO.setFileId(String.valueOf(Integer.parseInt(file_id)-1));
		}else { //업로드된 파일 없을때
			ftSDTO.setFileId("-1");
		}
		/*
	  	//트럭 이미지 파일 업로드 
		String fileSevname= "";//파일 이름을 재정의 하기 위한 변수 선언
		String fileOrgname= file.getOriginalFilename();
		//requestParam 요청으로 불러온 이미지의 원래 파일명 
		log.info("fileOrgname : " +fileOrgname);
		String extended = fileOrgname.substring(fileOrgname.indexOf("."),fileOrgname.length());
		//이미지의 명을 main.jpg 이 런식으로 받아오는데 substring 을 이용해 . 뒤에 문자가 다 나오도록 쓰는것 같음 
		String now = new SimpleDateFormat("yyyyMMddhmsS").format(new Date()); 
		//현재 시간 나타내는 변수 
		
		savePath =CmmUtil.nvl(savePath); 
		//저장할 위치에 변수가 널값이 들어오면 공백으로 바궈주는 것 cmmutil
		
		fileSevname=savePath+now+extended; // 새로운 파일명으로 저장할 위치경로 + 시간 + 확장자명 인거 같음
		log.info("filesevname 1 : " + fileSevname);
		File newFile =new File(fileSevname);
		file.transferTo(newFile);
		//transferTo 는 MultiFile에 내장된것 / 메소드를 사용해서 원하는 위치에 저장 
		//InputStream을 얻은 다음에 직접 처리를 해줘도 되지만 선능 좋고 편하니까 transferTo()
		//데이터를 DTO 셋팅
		
		SELLER_ImageDTO imgDTO = new SELLER_ImageDTO();
		imgDTO.setFileSevname(now+extended);
		imgDTO.setFilePath(savePath);
		imgDTO.setFileOrgname(fileOrgname);
		*/
		
		HashMap<String, Object> hMap = new HashMap<>();
		hMap.put("ftSDTO", ftSDTO);
		//hMap.put("imgDTO", imgDTO);
		
		log.info("hMap ftSDTO 확인 : " + hMap.get("ftSDTO"));
		
		hMap= FtSellerService.insertFtSInfo(hMap);
		
		int resultFtReg = (int) hMap.get("resultFtReg"); 
	//	int resultImgReg = (int) hMap.get("resultImgReg");
		
		String msg="";
		String url="";
		
		if(resultFtReg == 1) {
			msg="트럭정보가 등록되었습니다 .";
			url="/seller/inMain.do";
		}else {
			msg="트럭정보 등록에 실패하셨습니다 .";
			url="/seller/ft/ftReg.do";
		}
		model.addAttribute("url",url);
		model.addAttribute("msg",msg);
		
		url =null;
		msg =null;
		hMap= null;
		ftSDTO =null;
		
		
		return "/cmmn/alert";
		
		
		/*int result = FtSellerService.insertFtSInfo(ftSDTO);
		
		String url ="";
		String msg ="";
		if(result != 0) {
			url="/main.do";
			msg="트럭정보등록 성공";
		}else {
			url="/main.do";
			msg="트럭정보들옥 실패";
		}
		model.addAttribute("url",url);
		model.addAttribute("msg",msg);
		
		
		url =null;
		msg =null;
		ftSDTO =null;
		
		
		log.info(this.getClass() + " ftRegProc end !!");
		
		
		return "/alert";*/
	}
	
	//푸드트럭관리 트럭등록 vs 기존 정보 
	@RequestMapping(value="/seller/ft/truckConfig")
	public String truckConfig(HttpServletRequest request, Model model) throws Exception{
		log.info(this.getClass() + " truckConfig start !!");
		String userSeq = CmmUtil.nvl(request.getParameter("userSeq"));
		log.info("userSeq : " + userSeq);
		
		SELLER_FtSellerDTO ftsDTO = new SELLER_FtSellerDTO();
		ftsDTO.setUserSeq(userSeq);
		
		ftsDTO = FtSellerService.getTruckConfig(ftsDTO);
		
		String url ="";
		String msg ="";
		
		
		if(ftsDTO == null) {
			ftsDTO = new SELLER_FtSellerDTO();
			 msg="등록된 푸드트럭이 없습니다 .";
			 url="/seller/ft/ftReg.do";
			
		}else {
			msg="안녕하세요"+ ftsDTO.getFtName()+"입니다";
			url="/seller/ft/ft_info.do?ft_seq="+ftsDTO.getFtSeq()+"&userSeq="+userSeq;
		}
		log.info("ftsDTO.ftName : " + ftsDTO.getFtName());
		log.info("ftsDTO.ftSEQ : " + ftsDTO.getFtSeq());
		
		model.addAttribute("url",url);
		model.addAttribute("msg",msg);
		
			
		ftsDTO=null;
		url=null;
		
		log.info(this.getClass() + " truckConfig end !!!");
		return "/cmmn/alert";
	}
	
	//푸드트럭상권분석메인페이지
	@RequestMapping(value="/seller/ftDistrictData/ftDistrictDataMain")
	public String ftDistrictDataMain(HttpServletRequest request, Model model) throws Exception{
		log.info(this.getClass() + " ftDistrictDataMain start !!");
		
		log.info(this.getClass() + " ftDistrictDataMain end !!!");
		
		return "/seller/ftDistrictData/ftDistrictDataMain";
	}	
	
	
	//푸드트럭상권분석
	@RequestMapping(value="/seller/ftDistrictData/ftDistrictDataProc")
	public  @ResponseBody List<SELLER_FtDistrictDataDTO> ftDistrictDataProc(HttpServletRequest request, Model model) throws Exception{
		log.info(this.getClass() + " ftDistrictDataProc start !!");
		String keyWord = CmmUtil.nvl(request.getParameter("keyWord"));
		log.info("검색================" + keyWord);
		
		List<SELLER_FtDistrictDataDTO> FtDstctDataDTO = FtSellerService.getFtDstctData("keyWord");
		List<SELLER_FtDistrictDataDTO> newFtDstctDataDTO = new ArrayList<SELLER_FtDistrictDataDTO>();
		log.info("null check=============" + FtDstctDataDTO.isEmpty());
		
		for(int i = 0 ; i < FtDstctDataDTO.size(); i++) {
			if(null != (FtDstctDataDTO.get(i).getX()) && null != (FtDstctDataDTO.get(i).getY()) && null != FtDstctDataDTO.get(i).getSiteWhlAddr()) {
				if(FtDstctDataDTO.get(i).getSiteWhlAddr().startsWith(keyWord)) {
					newFtDstctDataDTO.add(FtDstctDataDTO.get(i));
					log.info((FtDstctDataDTO.get(i).getSiteWhlAddr()));
				}
			}
		}
		
		
		log.info(this.getClass() + " ftDistrictDataProc end !!!");
		return newFtDstctDataDTO;
	}
	@RequestMapping(value="/seller/sales/sales")
	public String sales(HttpServletRequest request, Model model)throws Exception{
		log.info(this.getClass() + " sales start!!!!!!!!!!!!!!!!!!!!!!");
		//select to_char(sysdate, 'yy/mm/dd/dy/hh24/mi/ss') from dual;
		//ORDER_WAIT ORD_DATE 값 INSERT
		String userSeq = CmmUtil.nvl(request.getParameter("userSeq"));
		log.info("userSeq : " + userSeq);
		
		SELLER_FtSellerDTO ftsDTO = new SELLER_FtSellerDTO();
		ftsDTO.setUserSeq(userSeq);
		
		ftsDTO = FtSellerService.getTruckConfig(ftsDTO);
		log.info("ftsDTO : " + ftsDTO.getFtSeq());
		
		List<SELLER_FtSellerDTO> sList = FtSellerService.getSalesList(ftsDTO);
		
		int M = 0;//남성
		int F = 0;//여성
		double percentM= 0;
		double percentF= 0;
		int[] arrayDay = new int[7];//요일 배열
		int max= 0; //가장 많은 요일값
		int dayI = 0; //가장 많은 요일 index
		int daySum =0; // 요일 총합
		double percentD =0; //요일 %
		int time =0; // 시간 추출
		int[] arrayTime = new int[8];//시간 배열
		int maxTime=0; //가장 많은 시간대
		int timeI = 0;//시간대 인덱스
		double percentT =0;//시간대 퍼센트
		int timeSum =0;//시간대 총합
		for(int i=0; i< sList.size(); i++) {
			if(sList.get(i).getUserGender().equals("M")) {
				M++;
				F = sList.size()-M;
			}
			log.info("sList : " + sList.get(i).getOrdDate());
			log.info("==============================");
			switch(sList.get(i).getOrdDate().split("/")[3]) {
			case "월" : arrayDay[0]++; break;
			case "화" : arrayDay[1]++; break;
			case "수" : arrayDay[2]++; break;
			case "목" : arrayDay[3]++; break;
			case "금" : arrayDay[4]++; break;
			case "토" : arrayDay[5]++; break;
			case "일" : arrayDay[6]++; break;
			}
			time =  Integer.parseInt(sList.get(i).getOrdDate().split("/")[4]);
			if(0 <= time && time < 3 ) {
				arrayTime[0]++;
			}else if(3 <= time && time <6) {
				arrayTime[1]++;
			}else if(6 <= time && time <9) {
				arrayTime[2]++;
			}else if(9 <= time && time <12) {
				arrayTime[3]++;
			}else if(12 <= time && time <15) {
				arrayTime[4]++;
			}else if(15 <= time && time <18) {
				arrayTime[5]++;
			}else if(18 <= time && time <21) {
				arrayTime[6]++;
			}else if(21 <= time && time <24) {
				arrayTime[7]++;
			}
			
		}
		for(int i=0; i < arrayTime.length; i++) {
			if(maxTime < arrayTime[i]) {
				maxTime = arrayTime[i];
				timeI = i;
			}
			timeSum += arrayTime[i];
		}
		log.info("time index *3 ~+3까지: " + timeI);
		percentT =( (double)maxTime / (double)timeSum*100.0);
		percentT =(Math.round(percentT*100))/100.0;
		log.info("psercent T : " + percentT);
		percentM =( (double)M / (double)(M+F)*100.0);
		percentM = (Math.round(percentM*100))/100.0 ;
		log.info("percent M  : " + percentM);
		percentF =( (double)F / (double)(M+F)*100.0);
		percentF = (Math.round(percentF*100))/100.0 ;
		log.info("percent F  : " + percentF);
		
		/*for(int i=0; i<arrayDay.length; i++) {
			log.info("arrayDay "+i +":" + arrayDay[i]);
		}*/
		for(int i=0; i<arrayDay.length; i++) {
			if(max < arrayDay[i]) {
				max = arrayDay[i];
				dayI = i;
			}
			daySum += arrayDay[i];
		}
		log.info("dayI 요일index입니다 0->월 : " + dayI);
		log.info("daysum : " + daySum);
		
		percentD =( (double)max /(double)daySum*100.0);
		percentD =(Math.round(percentD*100))/100.0;
		log.info("요일 % : " + percentD);
		
		model.addAttribute("dayIndex",dayI);
		model.addAttribute("percentD",percentD);
		model.addAttribute("timeIndex",timeI);
		model.addAttribute("percentT",percentT);
		model.addAttribute("percentM",percentM);
		model.addAttribute("percentF",percentF);
		model.addAttribute("arrayDay",arrayDay);
		
		 M = 0;//남성
		 F = 0;//여성
		 percentM= 0;
		 percentF= 0;
		 arrayDay = null;//요일 배열
		 max= 0; //가장 많은 요일값
		 dayI = 0; //가장 많은 요일 index
		 daySum =0; // 요일 총합
		 percentD =0; //요일 %
		 time =0; // 시간 추출
		 arrayTime = null;//시간 배열
		 maxTime=0; //가장 많은 시간대
		 timeI = 0;//시간대 인덱스
		 percentT =0;//시간대 퍼센트
		 timeSum =0;//시간대 총합
		
		
		
		
		log.info(this.getClass() + " sales end !!!!!!!!!!!!!!!!!!!!!!!");
		return "/seller/sales/sales";
	}
	
	//날씨 정보, 식중독 예방 정보 페이지
		@RequestMapping(value="/seller/weatherInfo", method=RequestMethod.GET) 
		public String weatherInfoSel(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception{
			log.info("Access weatherInfo");
			String myAddress = request.getParameter("myAddress");
			String regCode = request.getParameter("regCode");
			
			if("".equals(myAddress) || "".equals(regCode)) {
				//위치설정 안되어 있는 경우
				String url= "/seller/weather/findMyLoc.do";
				String msg ="위치 설정 후 사용해주세요.";

				model.addAttribute("msg", msg);
				model.addAttribute("url", url);
				
				return "/cmmn/alert";
			}
			String url = "http://apis.data.go.kr/B550928/dissForecastInfoSvc/getDissForecastInfo"
					//서비스 키
					+ "?serviceKey=NM1oJvYCcGILHPKU0R8dmv9P%2BvAxnAXIoSLH29uHh4TFUkRZdD9iqZF7HnKPYCQHBM1eM29GDwkz5of%2BiHtT0g%3D%3D"
					// 반환 데이터 타입
					+ "&type=json"
					// 질병 코드:3 식중독
					+ "&dissCd=3"
					// 지역코드
					+ "&znCd="+ regCode;
			SELLER_DissInfoDTO dissInfoDTO = OpenAPI.getDissInfoSel(url);
			model.addAttribute("dissInfoDTO", dissInfoDTO); //식중독 예방정보가 할당된 1개의 객체 전송
			dissInfoDTO = null; url = null;
			/*model.addAttribute("myAddress", myAddress);*/ //topBody.jsp에 세션이 있기 때문에 model 사용하지 않음
			log.info("Terminate weatherInfo");		
			return "/seller/weather/weatherInfo";
		}
	
	// 내 위치 찾기 페이지 이동
		@RequestMapping(value="/seller/weather/findMyLoc")
		public String findMyLocSel() throws Exception{
			log.info(this.getClass() + "seller weather start ~~~");
			log.info("access FindMyLoc");
			log.info(this.getClass() + "seller weather end ~~~~");
			return "/seller/weather/findMyLoc";
		}
		//위치정보 받아와서 처리 -- PROCEDURE
		@RequestMapping(value="/seller/myLocProc", method=RequestMethod.POST) 
		public String myLocProcSel(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception{
			log.info("Access myLocProc");
			
			String userSeq = request.getParameter("userSeq"); // 유저번호
			String myLat = request.getParameter("myLat"); // 위도
			String myLon = request.getParameter("myLon"); // 경도
			String myAddress = request.getParameter("myAddress"); // 지번 주소 명
			String gridX = request.getParameter("gridX"); //날씨용 좌표 X
			String gridY = request.getParameter("gridY"); //날씨용 좌표 Y
			String []myAddrArr = myAddress.split(" "); // 시도구 시군구 읍면동 정보
			String sido = myAddrArr[0];
			String sigungu = myAddrArr[1];
			String dong = myAddrArr[2];
			//미 로그인시 유저번호는 -1로 지정하여 DB에 저장
			if(userSeq.equals("")) {
				userSeq = "-1";
				System.out.println("null check complete");
			}
			
			log.info(userSeq);
			log.info(myLat);
			log.info(myLon);
			log.info(myAddress);
			log.info(sido);
			log.info(sigungu);
			log.info(dong);
			log.info("날씨용 지역 코드 X : " + gridX); //날씨용 지역코드 변환
			log.info("날씨용 지역 코드 Y : " + gridY); //날씨용 지역코드 변환
			
			//유저번호, GPS정보 DB저장
			SELLER_Gps_TableDTO gpsDTO = new SELLER_Gps_TableDTO();
			gpsDTO.setUser_seq(Integer.parseInt(userSeq));
			gpsDTO.setGps_x(myLat);
			gpsDTO.setGps_y(myLon);
			gpsDTO.setGps_sido(sido);
			gpsDTO.setGps_sigungu(sigungu);
			gpsDTO.setGps_dong(dong);
			gpsDTO.setGps_renew_date(getDate());
			
			int resultSet = FtSellerService.setGps(gpsDTO);
			log.info("gpsDTO " + resultSet);
			int resultUpdate = FtSellerService.updateGps(gpsDTO.getUser_seq());
			log.info("DB저장 결과(1: 성공)  >>>>>>>> " + resultSet + ", " + resultUpdate);
			
			
			
			//////////////동네날씨예보 API시작!!!//////////////
			Coord coord = new Coord(gridX, gridY);	//지역코드
			String skyCode =null, ptyCode = null, t3hCode = null; 
			
			//skycode 하늘상태(맑음:1, 구름조금:2, 구름많음:3, 흐림:4)
			//ptyCode 강수형태(없음:0, 비:1, 비/눈:2, 눈:3)
			//t3hCode 3시간 동안의 기온(단위 ℃)
			List<SELLER_WeatherDTO> weatherDTOs = OpenAPI.getWeatherSeller(coord);
			if(weatherDTOs != null) {
				for(SELLER_WeatherDTO weatherDTO: weatherDTOs) {
					switch(weatherDTO.getCategory()) {
						case "SKY": skyCode = weatherDTO.getFcstValue(); break; 
						case "PTY": ptyCode = weatherDTO.getFcstValue(); break; 
						case "T3H": t3hCode = weatherDTO.getFcstValue(); break;
						default: break;
					}
				}	
			}
			
			String regCode = SortRegCode.chgToRegCode(myAddress); //질병예방 API 용 지역코드
			log.info("Your regCode is : " + regCode);
			session.setAttribute("myLat", myLat);
			session.setAttribute("myLon", myLon);
			session.setAttribute("myAddress", myAddress);
			session.setAttribute("regCode", regCode);
			session.setAttribute("skyCode", skyCode);
			session.setAttribute("ptyCode", ptyCode);
			session.setAttribute("t3hCode", t3hCode);
			weatherDTOs = null;
			/////////////////////////////////////////////
			log.info("Terminate myLocProc");
			
			log.info("Access weatherInfo");

			if("".equals(myAddress) || "".equals(regCode)) {
				//위치설정 안되어 있는 경우
				String url= "/seller/weather/findMyLoc.do";
				String msg ="위치 설정 후 사용해주세요.";

				model.addAttribute("msg", msg);
				model.addAttribute("url", url);
				
				return "/cmmn/alert";
			}
			String url = "http://apis.data.go.kr/B550928/dissForecastInfoSvc/getDissForecastInfo"
					//서비스 키
					+ "?serviceKey=NM1oJvYCcGILHPKU0R8dmv9P%2BvAxnAXIoSLH29uHh4TFUkRZdD9iqZF7HnKPYCQHBM1eM29GDwkz5of%2BiHtT0g%3D%3D"
					// 반환 데이터 타입
					+ "&type=json"
					// 질병 코드:3 식중독
					+ "&dissCd=3"
					// 지역코드
					+ "&znCd="+ regCode;
			SELLER_DissInfoDTO dissInfoDTO = OpenAPI.getDissInfoSel(url);
			session.setAttribute("dissInfoDTO", dissInfoDTO);
			//model.addAttribute("dissInfoDTO", dissInfoDTO); //식중독 예방정보가 할당된 1개의 객체 전송
			log.info("dissInfoDTO.getRisk() : " +dissInfoDTO.getRisk());
			dissInfoDTO = null; url = null;
			/*model.addAttribute("myAddress", myAddress);*/ //topBody.jsp에 세션이 있기 때문에 model 사용하지 않음
			log.info("Terminate weatherInfo");	
			
			return "redirect:/seller/inMain.do";
			
		}
		
	
	
	
	
}
