package poly.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.cmmn.CMMN_UserDTO;
import poly.persistance.mapper.SELLER_OrderMapper;
import poly.service.SELLER_IOrderService;

@Service("SELLER_OrderService")//service 이름입니다 .
public class SELLER_OrderService implements SELLER_IOrderService {

	@Resource(name="SELLER_OrderMapper")
	private SELLER_OrderMapper orderMapper;

	@Override
	public CMMN_UserDTO getOrderUserDTO(CMMN_UserDTO uDTO) throws Exception {
		// TODO Auto-generated method stub
		return orderMapper.getOrderUserDTO(uDTO);
	}
	
	
}
