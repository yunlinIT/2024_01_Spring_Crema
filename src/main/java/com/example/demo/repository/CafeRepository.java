package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.demo.vo.Cafe;

@Mapper
public interface CafeRepository {

	@Select("""
			SELECT COUNT(name)
			FROM cafe
			WHERE name = #{name}
			""")
	public int countDuplicateCafeName(String name);

	@Insert("""
			INSERT INTO
			cafe SET
			regDate = NOW(),
			updateDate = NOW(),
			name = #{name},
			address = #{address},
			businessHours = #{businessHours},
			phoneNum = #{phoneNum},
			facilities = #{facilities},
			cafeImgUrl1 = #{cafeImgUrl1},
			cafeImgUrl2 = #{cafeImgUrl2},
			cafeImgUrl3 = #{cafeImgUrl3},
			cafeImgUrl4 = #{cafeImgUrl4},
			cafeImgUrl5 = #{cafeImgUrl5},
			goodReactionPoint = #{goodReactionPoint},
			reviewCount = #{reviewCount},
			hashtag = #{hashtag}
			""")

	public void insertCafe(Cafe cafe);

	@Select("""
			SELECT *
			FROM cafe
			WHERE id = #{id}
			GROUP BY id
			""")
	public Cafe getForPrintCafe(int id);

	@Select("""
			<script>
			SELECT id, name, address, goodReactionPoint, reviewCount, hashtag, cafeImgUrl1
			FROM cafe
			GROUP BY id
			ORDER BY id DESC
			<if test="limitFrom >= 0 ">
				LIMIT #{limitFrom}, #{limitTake}
			</if>
			</script>
			""")
	public List<Cafe> getForPrintCafes(int limitFrom, int limitTake);

	@Select("""
			SELECT COUNT(*)
			FROM cafe
			ORDER BY id DESC
			""")
	public int getCafesCount();

	@Select("""
			UPDATE cafe AS C
			INNER JOIN (
			    SELECT CR.cafeId, COUNT(CR.cafeId) AS cafeReviewCount
			    FROM cafeReview AS CR
			    GROUP BY CR.cafeId
			) AS CR_COUNT
			ON C.id = CR_COUNT.cafeId
			SET C.reviewCount = CR_COUNT.cafeReviewCount;

						""")
	public void updateReviewCount();

	@Select("""
			SELECT * FROM cafe
			WHERE `name` LIKE CONCAT('%', #{keyword}, '%')
			OR `address` LIKE CONCAT('%', #{keyword}, '%')
			OR `hashtag` LIKE CONCAT('%', #{keyword}, '%')
			""")
	List<Cafe> searchCafes(@Param("keyword") String keyword);

}
