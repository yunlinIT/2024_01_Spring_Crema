package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.vo.CafeReview;
import com.example.demo.vo.Reply;

@Mapper
public interface CafeReviewRepository {



	@Select("""
			SELECT CR.*, M.nickname AS extra__writer
			FROM cafeReview AS CR
			INNER JOIN `member` AS M
			ON CR.memberId = M.id
			WHERE cafeId = #{cafeId}
			ORDER BY CR.id ASC;
		""")
	List<CafeReview> getForPrintCafeReviews(int loginedMemberId, int cafeId);

	@Insert("""
			INSERT INTO cafeReview
			SET regDate = NOW(),
			updateDate = NOW(),
			memberId = #{loginedMemberId},
			cafeId = #{cafeId},
			`body` = #{body}
		""")
	void writeCafeReview(int loginedMemberId, int cafeId, String body);

	@Select("SELECT LAST_INSERT_ID()")
	public int getLastInsertId();

	@Select("""
				SELECT R.*
				FROM reply AS R
				WHERE R.id = #{id}
			""")
	Reply getReply(int id);

	@Delete("""
				DELETE FROM cafeReview
				WHERE id = #{id}
			""")
	void deleteCafeReview(int id);

	@Update("""
			UPDATE cafeReview
			SET `body` = #{body},
			updateDate = NOW()
			WHERE id = #{id}
				""")
	public void modifyCafeReview(int id, String body);
	
	@Select("""
			SELECT CR.*
			FROM cafeReview AS CR
			WHERE CR.id = #{id}
		""")
	CafeReview getCafeReview(int id);





	



}