package poly.service;

import java.util.List;

import poly.dto.cmmn.CMMN_UserDTO;
import poly.dto.seller.SELLER_OrderInfoDTO;

public interface SELLER_IOrderService {
	public CMMN_UserDTO getOrderUserDTO(CMMN_UserDTO uDTO)throws Exception;
	public List<SELLER_OrderInfoDTO> getOrderList(String userSeq) throws Exception;
}
