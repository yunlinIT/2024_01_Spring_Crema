package com.example.demo.repository;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface CafeScrapRepository {
	
	
	
	
//수정중....... memberId가 필요할까? 고민즁... memberID not found error 떠서  memberId 삭제
	@Select("""
			SELECT IFNULL(SUM(CS.scrap),0)
			FROM cafeScrap AS CS
			WHERE CS.cafeId = #{cafeId}
			""")
	public int getSumScrapCount(int cafeId);
	
	
	//AND CS.memberId = #{memberId}


}
