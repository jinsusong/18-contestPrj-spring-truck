package poly.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import poly.dto.consumer.CONSUMER_CouponIssueDTO;
import poly.service.CONSUMER_ICouponService;

@Controller
public class CONSUMER_CouponController {
	private Logger log = Logger.getLogger(this.getClass());
	/*로그를 찍고 파일로 남깁니다 .*/
	String msg = "";
	String url = "";
	
	@Resource(name="CONSUMER_CouponService")
	private CONSUMER_ICouponService couponService;
	
	
	@RequestMapping(value="consumer/coupon/mycoupon")
	public String couponList(HttpServletRequest request, Model model) throws Exception{
		log.info("mycoupon Start");
		
		String userSeq = request.getParameter("userSeq");
		log.info("getUserSeq : " + userSeq);
		
		List<CONSUMER_CouponIssueDTO> cList = couponService.couponList(userSeq);
		
		model.addAttribute("cList", cList);
		
		log.info("mycoupon End");
		return "/consumer/coupon/mycoupon";
	}
	
}
