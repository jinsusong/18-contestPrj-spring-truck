package poly.service;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

import poly.dto.consumer.CONSUMER_Ft_ReviewDTO;
import poly.dto.consumer.CONSUMER_GpsTableDTO;
import poly.dto.consumer.CONSUMER_ImageDTO;
import poly.dto.consumer.CONSUMER_Menu_InfoDTO;
import poly.dto.admin.ADMIN_Ft_Menu_CateDTO;
import poly.dto.consumer.CONSUMER_FtLikeDTO;
import poly.dto.consumer.CONSUMER_FtMenuCateDTO;
import poly.dto.consumer.CONSUMER_Ft_InfoDTO;

public interface CONSUMER_IFtService {
	public List<CONSUMER_Ft_InfoDTO> getFtList(String regCode) throws Exception; //리스트 형식의 값을 반환하는 getUserList() 메소드

	public CONSUMER_Ft_InfoDTO getFtDetail(String ft_seq) throws Exception;

	public List<CONSUMER_Ft_ReviewDTO> getReviewDetail(String ft_seq) throws Exception;

	public List<CONSUMER_Menu_InfoDTO> getMenuList(String keyWord) throws Exception;

	public List<CONSUMER_ImageDTO> getTruckImage(List<CONSUMER_ImageDTO> ImgDTOs) throws Exception;

	public List<CONSUMER_ImageDTO> getReviewImage(List<CONSUMER_ImageDTO> ImgDTOs) throws Exception;

	public List<CONSUMER_ImageDTO> getBannerImages() throws Exception;

	public List<CONSUMER_Menu_InfoDTO> getFtMenuList(String ft_seq) throws Exception;

	public List<CONSUMER_ImageDTO> getMenuImage(List<CONSUMER_ImageDTO> imgDTOs) throws Exception;

	public CONSUMER_ImageDTO getFtImage(String file_id) throws Exception;

	//푸드트럭 리뷰------------------------------------------------------
	public List<CONSUMER_Ft_ReviewDTO> getFT_Review_List(int ft_seq) throws Exception;
	public CONSUMER_Ft_ReviewDTO getFT_Review_Info(int review_seq) throws Exception;
	public int ft_Review_Delete(int review_seq) throws Exception;
	public int ft_Review_Exp_Yn(int review_seq) throws Exception;
	public int ft_Review_Edit(CONSUMER_Ft_ReviewDTO revDTO) throws Exception;
	public int ft_Review_Create(CONSUMER_Ft_ReviewDTO revDTO) throws Exception;
	public int ft_Set_Rev_level(int review_seq) throws Exception;
	public int ft_Set_Revp_level(CONSUMER_Ft_ReviewDTO revDTO) throws Exception;
	public List<CONSUMER_Ft_ReviewDTO> getReview_LevP_List(String search_level) throws Exception;
	public int getReview_Reple_Cnt(String search_level) throws Exception;
	public int ft_Review_Reple_Edit(CONSUMER_Ft_ReviewDTO revDTO) throws Exception;
	
	//특정 푸드트럭 상세 정보 리뷰 전용 -- 답글 제외
	public List<CONSUMER_Ft_ReviewDTO> getFt_Review_List_ftDetail(int ft_seq) throws Exception;
	
	//푸드트럭 메뉴 카테고리 가져오기
	public List<CONSUMER_FtMenuCateDTO> getFT_Cate_List(int ft_seq) throws Exception;
	 
}
