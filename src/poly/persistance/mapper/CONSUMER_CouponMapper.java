package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.consumer.CONSUMER_CouponIssueDTO;

@Mapper("CONSUMER_CouponMapper")
public interface CONSUMER_CouponMapper {

	public List<CONSUMER_CouponIssueDTO> couponList(String userSeq) throws Exception;

}
