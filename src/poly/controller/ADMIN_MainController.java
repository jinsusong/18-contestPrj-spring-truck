package poly.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ADMIN_MainController {
	public Logger log = Logger.getLogger(this.getClass());
	
	@RequestMapping(value="admin/admin_main")
	public String main(HttpServletRequest request, Model model) throws Exception{
		
		return "/admin/admin_main";
	}
	
}
