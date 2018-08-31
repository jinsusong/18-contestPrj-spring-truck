package poly.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import poly.dto.consumer.CONSUMER_Ft_InfoDTO;
import poly.dto.consumer.CONSUMER_ImageDTO;
import poly.service.CONSUMER_IFtService;
import poly.service.CONSUMER_IImageService;
import poly.util.CmmUtil;
import poly.util.SortTruck;

@Controller
public class ADMIN_MainController {
	public Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "CONSUMER_FtService")
	private CONSUMER_IFtService ftService;
	
	@Resource(name="CONSUMER_ImageService")
	private CONSUMER_IImageService imgService;
	
	@RequestMapping(value="admin/admin_main")
	public String main(HttpServletRequest request, Model model) throws Exception{
		//값 받아 오기 및 확인
				log.info("access findAdjFt");
				//String regCode = request.getParameter("regCode"); //GET방식으로 받은 지역코드를 변수에 할당
				
				String[] locPosition = {"37.54961852825523", "126.8426243815202"};
				
				
				log.info("Current Location's Longitude is :" + locPosition[0]); //받아온 위도 확인
				log.info("Current Location's Latitude is :" + locPosition[1]);	// 받아온 경도 확인
				
				List<CONSUMER_Ft_InfoDTO> ftList = ftService.getFtList_ALL(); //리스트형식의 푸드트럭객체들을 지역코드를 파라미터를 사용해 테이블로부터 불러옴
				
				ftList = SortTruck.getAdjTrucks(ftList, locPosition); // 가까운 트럭들만 모아놓을 리스트 변수 선언
				ftList = SortTruck.sortFtClose(ftList); // 가까운 거리부터 순서대로 정렬 하여 리스트에 할당
				
				model.addAttribute("locPositionLat", locPosition[0]); //전송
				model.addAttribute("locPositionLon", locPosition[1]); //전송
				model.addAttribute("ftList", ftList); //fList라는 변수로 리턴으로 가져갈 리스트 변수 전송 
				
				////////////////////트럭 사진 리스트 불러오기////////////////// 											
				log.info(this.getClass() + " // truckImages start !!");
				List<CONSUMER_ImageDTO> imgDTOs = new ArrayList<CONSUMER_ImageDTO>();
				
				if(ftList.isEmpty() == false) {
					for(int i = 0; i < ftList.size(); i++) {
						CONSUMER_ImageDTO imgDTO = new CONSUMER_ImageDTO();
						imgDTO.setFtSeq(CmmUtil.nvl(Integer.toString(ftList.get(i).getFt_seq())));
						imgDTO.setUserSeq(CmmUtil.nvl(Integer.toString(ftList.get(i).getUser_seq())));
						imgDTO.setFileId(CmmUtil.nvl((ftList.get(i).getFile_id())));
						imgDTOs.add(imgDTO);
						log.info("file ftSeqs : " + imgDTO.getFtSeq());
						log.info("file userSeqs : " + imgDTO.getUserSeq());
					}
																	
					imgDTOs = ftService.getTruckImage(imgDTOs);
					
					if (imgDTOs == null) {			
						imgDTOs = new ArrayList<CONSUMER_ImageDTO>();
					}		
					//받아온 이미지 DTO 들 확인
					for(int i = 0; i < imgDTOs.size(); i++) {
						log.info("imgDTOs. get : " + imgDTOs.get(i).getFileId());											
						log.info("imgDTOs. get : " + imgDTOs.get(i).getFileOrgname());
						log.info("imgDTOs.get : " + imgDTOs.get(i).getFilePath());				
						log.info("imgDTOs. get : " + imgDTOs.get(i).getFileSevname());
						log.info("imgDTOs.get : " + imgDTOs.get(i).getUserSeq());
					}
					
					model.addAttribute("imgDTOs",imgDTOs);
					
					imgDTOs = null;
				}
					log.info(this.getClass() + "truckImage end !!");
				///////////////////////////////////////////////////////
				
		return "/admin/admin_main";
	}
	
}
