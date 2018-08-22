package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.cmmn.CMMN_UserDTO;
import poly.dto.seller.SELLER_OrderInfoDTO;

@Mapper("SELLER_OrderMapper")
public interface SELLER_OrderMapper {
	public CMMN_UserDTO getOrderUserDTO(CMMN_UserDTO uDTO)throws Exception;

	public List<SELLER_OrderInfoDTO> getOrderList(String userSeq)throws Exception;

}
