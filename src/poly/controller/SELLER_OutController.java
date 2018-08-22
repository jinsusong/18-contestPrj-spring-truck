package poly.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import poly.dto.admin.ADMIN_Ft_InfoDTO;
import poly.dto.admin.ADMIN_Ft_Menu_CateDTO;
import poly.dto.admin.ADMIN_ImageDTO;
import poly.dto.admin.ADMIN_Menu_InfoDTO;
import poly.dto.seller.SELLER_FtSellerDTO;
import poly.dto.seller.SELLER_MenuJsDTO;
import poly.dto.seller.SELLER_OrderInfoDTO;
import poly.service.ADMIN_IFtService;
import poly.service.ADMIN_IImageService;
import poly.service.SELLER_IFtSellerService;
import poly.service.SELLER_IOrderService;
import poly.service.SELLER_IOutService;
import poly.util.CmmUtil;
import poly.util.UtilTime;

@Controller
public class SELLER_OutController {

	private Logger log = Logger.getLogger(this.getClass());
	//로그를 찍고 파일로 남깁니다 .
	
	@Resource(name="ADMIN_FtService")
	private ADMIN_IFtService ftService;
	
	@Resource(name="ADMIN_ImageService")
	private ADMIN_IImageService imgService;
	
	@Resource(name="SELLER_OutService")
	private SELLER_IOutService OutService;
	//메모리에 올려두고 싱글톤 패턴을 적용시켜줍니다 .
	
	@Resource(name="SELLER_OrderService")
	private SELLER_IOrderService orderService;
	
	@Resource(name="SELLER_FtSellerService")
	private SELLER_IFtSellerService FtSellerService;
	
	@RequestMapping(value="/seller/out/out_info")
	public String out_info(HttpServletRequest request , Model model) throws Exception{
		log.info(this.getClass() + " out start !!~");
		String userSeq = CmmUtil.nvl(request.getParameter("userSeq"));
		log.info("userSeq : " + userSeq);
		
		SELLER_FtSellerDTO ftsDTO = new SELLER_FtSellerDTO();
		ftsDTO.setUserSeq(userSeq);
		log.info("ftsDTO set : " + ftsDTO.getUserSeq());
		
		ftsDTO = OutService.getOutTruckInfo(ftsDTO);
		log.info("ftsDTO .get : " +ftsDTO.getFtSeq());
		
		ADMIN_Ft_InfoDTO fDTO = new ADMIN_Ft_InfoDTO();
		fDTO = ftService.getFT_Info(Integer.parseInt(ftsDTO.getFtSeq()));
		
		//
		String cmd = "";
		int ft_seq = Integer.parseInt(ftsDTO.getFtSeq());
		log.info("ft_seq : " + ft_seq);
		
		//메뉴&카테고리 리스트
		List<ADMIN_Ft_Menu_CateDTO> cateDTOarr = ftService.getFT_Cate_List(ft_seq);
		List<ADMIN_Menu_InfoDTO> menuDTOarr = ftService.getFt_Menu_List(ft_seq);
		List<String> ImgDTOs = new ArrayList<String>();
		if(menuDTOarr.size()!=0) {
			int i=0;
			for(ADMIN_Menu_InfoDTO menuDTO : menuDTOarr) {
				ImgDTOs.add(menuDTO.getFile_id());
				i++;
			}
			List<ADMIN_ImageDTO> imgDTOarr = imgService.getMenuImage(ImgDTOs);
			model.addAttribute("imgDTOarr", imgDTOarr);
		}
		model.addAttribute("cateDTOarr", cateDTOarr);
		model.addAttribute("menuDTOarr", menuDTOarr);
		
		log.info("outC cmd : " +cmd );
		log.info("outC ft_seq : " + ft_seq);
		
		
		
		//페이지 커맨드 전송
		model.addAttribute("cmd", cmd);
		
		//좌측 푸드트럭 기본정보
		fDTO = ftService.getFT_Info(ft_seq);
		
		model.addAttribute("ftDTO", fDTO);
		model.addAttribute("ft_seq", ft_seq);
		
		cmd = null;
		fDTO = null;
		
		log.info(this.getClass() + " out end !!@@");
		
		return "/seller/out/out_info";
		// 0223 주석 담
	}
	@RequestMapping(value="seller/out/item")//장바구니 메뉴 클릭 시
	public String insertTemp (HttpServletRequest request,HttpSession session,Model model) throws Exception{
		log.info(this.getClass() + "insert item Start !!!!!");
		String ftSeq = CmmUtil.nvl(request.getParameter("ftSeq"));
		log.info("ftSeq : " + ftSeq);
		String menuSeq = CmmUtil.nvl(request.getParameter("menuSeq"));
		log.info("menuSeq : " + menuSeq);
		
		List<HashMap> beforeList = (List<HashMap>) session.getAttribute("Ilist");
		log.info("session.get : " + beforeList);
		
		boolean existItem = false;
		int existIndex = 0;
		//동일 메뉴 가 있는지 확인 
		if(beforeList != null) {
			for(int i=0; i<beforeList.size(); i++) {
				log.info("for beforList : " + i +" : " +beforeList.get(i).get("menuSeq"));
				log.info("for menuSeq : " + menuSeq);
				if(menuSeq.equals(beforeList.get(i).get("menuSeq"))) {
					log.info("if start !!!" );
					existItem = true;
					existIndex = i;
					log.info("if end !!");
					break;
				}
			}	
		}//동일 메뉴가 있으면 수량 증가
		if(existItem) {
			log.info(" amntPlus start");
			log.info("index : " + existIndex);
			List<HashMap> existList = (List<HashMap>) session.getAttribute("Ilist");
			log.info("session.get : " + existList);
			log.info("if beforeList get : " + existList.get(existIndex));
			int amnt = (int) existList.get(existIndex).get("amnt");
	
			existList.get(existIndex).put("amnt", amnt+1);
			session.setAttribute("Ilist", existList);
			//		amnt++;
			log.info("amnt : " +amnt);
			
			log.info(" amntPlus end");
			
		}else {
			log.info("else start !!! ");
			SELLER_MenuJsDTO mDTO = new SELLER_MenuJsDTO();
			mDTO.setFtSeq(ftSeq);
			mDTO.setMenuSeq(menuSeq);
			
			mDTO = OutService.getItemDTO(mDTO);
			log.info("mDTO : " + mDTO.getMenuName());
			
			int index = 0;
			//ftSeq
			//menuSeq
			//menuName
			int amnt = 1;	

			List<HashMap> Ilist = new ArrayList<HashMap>();
			
			//기존 장바구니 session이 있으면 기존거 담고나서 당믕수 있게 
			if(beforeList != null) {
				for(int i=0; i< beforeList.size(); i++) {
					System.out.println(beforeList.get(i));
					Ilist.add(beforeList.get(i));
					index ++;
				};
				
			}
			
			HashMap<String, Object> iMap = new HashMap<>();
			iMap.put("index", index);
			iMap.put("menuSeq", menuSeq);
			iMap.put("menuName", mDTO.getMenuName());
			iMap.put("menuPrice", mDTO.getMenuPrice());
			iMap.put("amnt", amnt);
			
			log.info("iMap : " + iMap.get("index"));
			Ilist.add(iMap);
			for(int i=0; i< Ilist.size(); i++) {
				log.info("Ilist : " + Ilist.get(i));
				
			}
			session.setAttribute("Ilist", Ilist);
			
			
		}
		
		
			log.info(this.getClass() + "insert item end ~~!!!!");
		return null;
	}
	@RequestMapping(value="/seller/out/itemBtn")//장바구니 버튼
	public void delitem(HttpServletRequest request, HttpSession session) throws Exception{
		
		log.info(this.getClass() + "itemBtn start !! ");
		int index = Integer.parseInt(request.getParameter("index"));
		log.info("index : " + index );
		String cmd = CmmUtil.nvl(request.getParameter("cmd"));
		log.info("cmd : "  + cmd);
		
		//취소 버튼 
		if(cmd.equals("delItem")) {
			log.info("delItem  start");
			log.info("index : " + index);
			List<HashMap> beforeList = (List<HashMap>) session.getAttribute("Ilist");
			log.info("session.get : " + beforeList);
			
			beforeList.remove(index);
			
			session.removeAttribute("Ilist");
			session.setAttribute("Ilist", beforeList);
		//수량 증가	
		}else if(cmd.equals("amntPlus")) {
			log.info(" amntPlus start");
			log.info("index : " + index);
			List<HashMap> beforeList = (List<HashMap>) session.getAttribute("Ilist");
			log.info("session.get : " + beforeList);
			log.info("for index : " + index);
			log.info(" if index :" + index);
			log.info("if beforeList get : " + beforeList.get(index));
			int amnt = (int) beforeList.get(index).get("amnt");
	
			beforeList.get(index).put("amnt", amnt+1);
			session.setAttribute("Ilist", beforeList);
			//		amnt++;
			log.info("amnt : " +amnt);
			
			log.info(" amntPlus end");
		//수량 감소
		}else if(cmd.equals("amntMinus")) {
			log.info(" amntMinus start");
			log.info("index : " + index);
			List<HashMap> beforeList = (List<HashMap>) session.getAttribute("Ilist");
			log.info("session.get : " + beforeList);
			log.info("for index : " + index);
			log.info(" if index :" + index);
			log.info("if beforeList get : " + beforeList.get(index));
			int amnt = (int) beforeList.get(index).get("amnt");
	
			beforeList.get(index).put("amnt", amnt-1);
			session.setAttribute("Ilist", beforeList);
			log.info("amnt : " +amnt);
			log.info(" amntMinus end");
		}else if(cmd.equals("delAll")) {
			log.info(" delAll start");
			session.removeAttribute("Ilist");
			log.info(" delAll end");
		}
		log.info(this.getClass() + "itemBtn end !!! ");
		
	}
	@RequestMapping(value="/seller/out/inOut")
	public String inout () throws Exception{
		log.info("inout view start !!!");
		
		log.info("inout view end !!!");
		return "/seller/out/inOut";
	}
	
	@RequestMapping(value="/seller/inMain")
	public String main(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception{
		System.out.println("main");
		log.info("chart Start");
		String userSeq = (String)session.getAttribute("userSeq");
		log.info("getUserSeq : " + userSeq);
		
		/*String userSeq1 = request.getParameter("userSeq");*/
		/*String ftSeq = request.getParameter("ftSeq");
		log.info("getFtSeq : " + ftSeq);*/
		SELLER_FtSellerDTO ftsDTO = new SELLER_FtSellerDTO();
		ftsDTO.setUserSeq(userSeq);
		ftsDTO = FtSellerService.getTruckConfig(ftsDTO);
		
		
		String todayMD = UtilTime.getDateMD();
		String todayYMDhms = UtilTime.getDateYMDhms();
		String todayDD = UtilTime.getDateDD();
		log.info("todayMD : " + todayMD);
		log.info("todayYMDhms : " + todayYMDhms);
		log.info("todayDD : " + todayDD);
		model.addAttribute("todayMD", todayMD);
		model.addAttribute("todayYMDhms", todayYMDhms);
		model.addAttribute("todayDD", todayDD);
		/*OrderInfoDTO oDTO = new OrderInfoDTO();
		oDTO.setUserSeq(userSeq);*/
		
		
		List<SELLER_OrderInfoDTO> oList = orderService.getOrderList(userSeq);
		if(oList.isEmpty()) {
			log.info("oList is Empty");
		}
		
		log.info("============ 주문내역 시작  ============");
		for(int i=0; i<oList.size(); i++) {
			log.info("---------------------------");
			log.info(oList.get(i).getOrd_seq());
			log.info(oList.get(i).getUser_seq());
			log.info(oList.get(i).getOrd_status());
			log.info(oList.get(i).getOrd_date());
			log.info(oList.get(i).getOrd_way());
			log.info(oList.get(i).getBuy_way());
			log.info(oList.get(i).getOrd_sumprice());
			log.info("---------------------------");
		}
		log.info("============ 주문내역 끝  ============");

		model.addAttribute("oList", oList);
		
		log.info("chart End");
		return "/seller/inMain";
	}
}
