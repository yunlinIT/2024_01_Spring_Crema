package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.vo.Cafe;

@Mapper
public interface CafeScrapRepository {
	
	
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



	@Delete("""
			DELETE FROM cafeScrap
			WHERE memberId = #{memberId}
			AND cafeId = #{cafeId}
			""")
	public void deleteCafeScrapCount(int memberId, int cafeId); //deleteReactionPoint

	
	
	@Select("""
			SELECT C.id, C.`name`, C.address, C.cafeScrapCount, C.reviewCount, C.hashtag, C.cafeImgUrl1
			FROM cafe AS C
			INNER JOIN cafeScrap CS
			ON CS.cafeId = C.id
			WHERE memberId = #{memberId}
			GROUP BY C.id
			ORDER BY CS.updateDate DESC
			""")

	public List<Cafe> getForPrintScrapCafes(Integer memberId);
	

}
