package poly.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import poly.dto.admin.ADMIN_BoardDTO;
import poly.dto.admin.ADMIN_Board_PostDTO;
import poly.dto.admin.ADMIN_User_InfoDTO;
import poly.service.ADMIN_IBoardService;
import poly.service.ADMIN_IImageService;
import poly.service.ADMIN_IUserService;

@Controller
public class ADMIN_MainController {
	public Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="ADMIN_UserService")
	private ADMIN_IUserService userService;
	
	@Resource(name = "ADMIN_BoardService")
	private ADMIN_IBoardService boardService;
	
	@Resource(name="ADMIN_ImageService")
	private ADMIN_IImageService imgService;
	
/*----------------------------------------------------------------------------------------*/
	
	public String getDate() {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy. MM. dd / hh:mm:ss");
		String date = sdf1.format(cal.getTime());
		
		return date;
	}
	
/*----------------------------------------------------------------------------------------*/
	
	@RequestMapping(value="admin/admin_main")
	public String main(HttpServletRequest request, Model model) throws Exception{
		//공지사항
		List<ADMIN_Board_PostDTO> board_P_List;
		List<ADMIN_User_InfoDTO> bp_uDTOarr = new ArrayList<ADMIN_User_InfoDTO>();
		
		board_P_List = boardService.getBoard_P_List_S(1);
		
		//댓글갯수, 유저 세팅
		for(int i=0; i<board_P_List.size(); i++) {
			board_P_List.get(i).setReple_count(boardService.board_R_Count(board_P_List.get(i).getBoard_p_seq()));
			bp_uDTOarr.add(userService.getUser(board_P_List.get(i).getUser_seq()));
		}
		model.addAttribute("bp_uDTOarr", bp_uDTOarr);
		model.addAttribute("board_P_List", board_P_List);
		
		
		return "/admin/admin_main";
	}
	
}
