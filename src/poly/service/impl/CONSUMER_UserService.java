package poly.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import poly.dto.consumer.CONSUMER_FtLikeDTO;
import poly.dto.consumer.CONSUMER_GpsTableDTO;
import poly.dto.consumer.CONSUMER_UserDTO;
import poly.persistance.mapper.CONSUMER_UserMapper;
import poly.service.CONSUMER_IUserService;
import poly.util.SHA256Util;
	
@Service("CONSUMER_UserService")//UserService 이름입니다.
public class CONSUMER_UserService implements CONSUMER_IUserService {
	
	@Resource(name="CONSUMER_UserMapper")
	private CONSUMER_UserMapper userMapper;
	
	@Override
	public int insertUserDTO(CONSUMER_UserDTO uDTO) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.insertUserDTO(uDTO);
	}
	
	@Override
	public List<CONSUMER_UserDTO> getUserList() throws Exception {
		// TODO Auto-generated method stub
		return  userMapper.getUserList();
	}

	@Override
	public CONSUMER_UserDTO getUserDetail(CONSUMER_UserDTO uDTO) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.getUserDetail(uDTO);
	}

	

	@Override
	public int deleteUser(CONSUMER_UserDTO uDTO) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("uDTOdel_service : " + uDTO.getUserSeq());
		return userMapper.deleteUser(uDTO);
	}

	@Override
	public int updateUser(CONSUMER_UserDTO uDTO) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.updateUser(uDTO);
	}

	@Override
	public CONSUMER_UserDTO getUserLogin(CONSUMER_UserDTO uDTO, Logger log) throws Exception {
		log.info("this is service and udto.getuser_email : " + uDTO.getUserEmail());
		// TODO Auto-generated method stub
		return userMapper.getUserLogin(uDTO);
	}

	@Override
	public int emailCheck(CONSUMER_UserDTO uDTO) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("service" + uDTO.getUserEmail());
		return userMapper.emailCheck(uDTO);
	}

	@Override
	public CONSUMER_UserDTO getUserFindEmail(CONSUMER_UserDTO uDTO) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("uDTOservice : " + uDTO.getUserHp());
		
		return userMapper.getUserFindEmail(uDTO);
	}

	@Override
	public CONSUMER_UserDTO getUserFindPwd(CONSUMER_UserDTO uDTO) throws Exception {
		System.out.println("uDTO service : " +uDTO.getUserEmail());
		return userMapper.getUserFindPwd(uDTO);
	}


	
	@Override
	public int updateUserPwd(CONSUMER_UserDTO uDTO) throws Exception {
		System.out.println("Service : " + uDTO.getUserSeq());
		return userMapper.updateUserPwd(uDTO);
	}
	/*
	//임시 비밀번호
	@Override
	public HashMap<String, Object> updateTmpPass(HashMap<String, Object> hMap) throws Exception {
		CONSUMER_UserDTO uDTO = (CONSUMER_UserDTO)hMap.get("uDTO");
		long temp_Pw = (long)(Math.random()*9000000000l) + 1000000000l;
		String temp_password = Long.toHexString(temp_Pw);
		uDTO.setUserPwd(SHA256Util.sha256(temp_password));
		int result = userMapper.updateTmpPass(uDTO);
		hMap.put("tmpPass", temp_password);
		hMap.put("result", result);
		return hMap;
	}
	*/

	@Override
	public int updateUserStatus(CONSUMER_UserDTO uDTO) throws Exception {
		System.out.println("uDTO service : " + uDTO.getUserStatus());
		System.out.println("uDTO service : " + uDTO.getUserEmail());
		return userMapper.updateUserStatus(uDTO);
	}

	//위치정보 DB저장
	@Override
	public int setGps(CONSUMER_GpsTableDTO gpsDTO) throws Exception {
		return userMapper.setGps(gpsDTO);
	}
	//관심매장 추가하기
	@Override
	public int ftAddFavorite(CONSUMER_FtLikeDTO ftLikeDTO) throws Exception {
		return userMapper.ftAddFavortie(ftLikeDTO);
	}
	
	//관심매장 추가 여부 확인
	@Override
	public CONSUMER_FtLikeDTO ftCheckFavrotie(CONSUMER_FtLikeDTO ftLikeDTO) throws Exception{
		return userMapper.ftCheckFavrotie(ftLikeDTO);
	}
	//관심매장 삭제
	@Override
	public int ftRemoveFavorite(CONSUMER_FtLikeDTO ftLikeDTO) throws Exception {
		return userMapper.ftRemoveFavorite(ftLikeDTO);
	}
	
	@Override
	public HashMap<String, Object> updateTmpPass(HashMap<String, Object> hMap) throws Exception {
		return userMapper.updateTmpPass(hMap);
	}

}
