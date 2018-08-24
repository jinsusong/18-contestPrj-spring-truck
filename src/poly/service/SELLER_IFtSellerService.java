package poly.service;

import java.util.HashMap;
import java.util.List;

import poly.dto.seller.SELLER_FtDistrictDataDTO;
import poly.dto.seller.SELLER_FtSellerDTO;
import poly.dto.seller.SELLER_ImageDTO;
import poly.dto.seller.SELLER_OrderInfoDTO;

public interface SELLER_IFtSellerService {
	//public int insertFtSInfo(FtSellerDTO ftSDTO) throws Exception;
	public HashMap<String, Object> insertFtSInfo(HashMap<String, Object> hMap)throws Exception;

	public SELLER_FtSellerDTO getTruckConfig(SELLER_FtSellerDTO ftsDTO)throws Exception;
	
/*	public SELLER_ImageDTO getTruckImage(SELLER_ImageDTO imgDTO)throws Exception;
	
	public int updateTruckImage(SELLER_ImageDTO imgDTO)throws Exception;*/

	public List<SELLER_FtDistrictDataDTO> getFtDstctData(String keyWord) throws Exception;
	
	public List<SELLER_FtSellerDTO> getSalesList(SELLER_FtSellerDTO ftsDTO)throws Exception;

	public SELLER_OrderInfoDTO getChartWeek(String userSeq)throws Exception;

	public List<SELLER_OrderInfoDTO> getOrderWeek(String userSeq)throws Exception;
	
	
}
