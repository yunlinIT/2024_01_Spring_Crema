package com.example.demo.repository;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface CafeScrapRepository {
	
	
	
	
//수정중....... memberId가 필요할까? 고민즁... memberID not found error 떠서  memberId 삭제
//	@Select("""
//			SELECT IFNULL(SUM(CS.scrap),0)
//			FROM cafeScrap AS CS
//			WHERE CS.cafeId = #{cafeId}
//			""")
//	public int getSumScrapCount(int cafeId);
	
	
	//AND CS.memberId = #{memberId}
	
	
	
	@Select("""
			SELECT IFNULL(SUM(CS.scrap),0)
			FROM cafeScrap AS CS
			WHERE CS.cafeId = #{cafeId}
			AND CS.memberId =#{memberId}
			""")
	public int getSumCafeScrapCount(int memberId, int cafeId); //getSumReactionPoint

	@Insert("""
			INSERT INTO cafeScrap
			SET regDate = NOW(),
			updateDate = NOW(),
			cafeId = #{cafeId},
			memberId = #{memberId},
			scrap = 1
			""")
	public int addCafeScrapCount(int memberId, int cafeId); //addGoodReactionPoint

//	@Insert("""
//			INSERT INTO reactionPoint
//			SET regDate = NOW(),
//			updateDate = NOW(),
//			relTypeCode = #{relTypeCode},
//			relId = #{relId},
//			memberId = #{memberId},
//			`point` = -1
//			""")
//	public int addBadReactionPoint(int memberId, String relTypeCode, int relId);

	@Delete("""
			DELETE FROM cafeScrap
			WHERE memberId = #{memberId}
			AND cafeId = #{cafeId}
			""")
	public void deleteCafeScrapCount(int memberId, int cafeId); //deleteReactionPoint
	
	
	
	


}
