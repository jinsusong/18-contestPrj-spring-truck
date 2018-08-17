package poly.persistance.mapper;

import config.Mapper;
import poly.dto.cmmn.CMMN_UserDTO;

@Mapper("SELLER_OrderMapper")
public interface SELLER_OrderMapper {
	public CMMN_UserDTO getOrderUserDTO(CMMN_UserDTO uDTO)throws Exception;

}
