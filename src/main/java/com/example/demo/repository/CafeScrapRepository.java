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
			SELECT IFNULL(SUM(RP.point),0)
			FROM reactionPoint AS RP
			WHERE RP.relTypeCode = #{relTypeCode}
			AND RP.relId = #{relId}
			AND RP.memberId = #{memberId}
			""")
	public int getSumReactionPoint(int memberId, String relTypeCode, int relId);

	@Insert("""
			INSERT INTO reactionPoint
			SET regDate = NOW(),
			updateDate = NOW(),
			relTypeCode = #{relTypeCode},
			relId = #{relId},
			memberId = #{memberId},
			`point` = 1
			""")
	public int addGoodReactionPoint(int memberId, String relTypeCode, int relId);

	@Insert("""
			INSERT INTO reactionPoint
			SET regDate = NOW(),
			updateDate = NOW(),
			relTypeCode = #{relTypeCode},
			relId = #{relId},
			memberId = #{memberId},
			`point` = -1
			""")
	public int addBadReactionPoint(int memberId, String relTypeCode, int relId);

	@Delete("""
			DELETE FROM reactionPoint
			WHERE memberId = #{memberId}
			AND relTypeCode = #{relTypeCode}
			AND relId = #{relId}
			""")
	public void deleteReactionPoint(int memberId, String relTypeCode, int relId);
	
	
	
	


}
