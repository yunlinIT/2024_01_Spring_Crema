package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

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
			cafeScrapCount = #{cafeScrapCount},
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
			     SELECT id, name, address, cafeScrapCount, reviewCount, hashtag, cafeImgUrl1
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
			<script>
			     SELECT id, name, address, cafeScrapCount, reviewCount, hashtag, cafeImgUrl1
			     FROM cafe
				 WHERE
			        `name` LIKE CONCAT('%', #{keyword}, '%')
				 OR `address` LIKE CONCAT('%', #{keyword}, '%')
				 OR `hashtag` LIKE CONCAT('%', #{keyword}, '%')
			     GROUP BY id
			     ORDER BY id DESC
			     <if test="limitFrom >= 0 ">
			         LIMIT #{limitFrom}, #{limitTake}
			     </if>
			     </script>
			""")
	public List<Cafe> getForPrintCafesKeyword(int limitFrom, int limitTake, String keyword);

//	@Select("""
//		    <script>
//		        SELECT id, name, address, cafeScrapCount, reviewCount, hashtag, cafeImgUrl1
//		        FROM cafe
//		        WHERE
//		        <foreach item="item" index="index" collection="keywords" open="(" separator=" OR " close=")">
//		            `name` LIKE CONCAT('%', #{item}, '%') OR `address` LIKE CONCAT('%', #{item}, '%') OR `hashtag` LIKE CONCAT('%', #{item}, '%')
//		        </foreach>
//		        GROUP BY id
//		        ORDER BY id DESC
//		        <if test="limitFrom >= 0 ">
//		            LIMIT #{limitFrom}, #{limitTake}
//		        </if>
//		    </script>
//		""")
//		public List<Cafe> getForPrintCafesKeyword(@Param("limitTake") int limitTake, @Param("limitFrom") int limitFrom, @Param("keywords") List<String> keywords);

	@Select("""
			SELECT COUNT(*)
			FROM cafe
			""")
	public int getCafesCount();

	@Select("""
			SELECT COUNT(*)
			FROM cafe
			WHERE `name` LIKE CONCAT('%', #{keyword}, '%')
			OR `address` LIKE CONCAT('%', #{keyword}, '%')
			OR `hashtag` LIKE CONCAT('%', #{keyword}, '%')
			""")
	public int getCafesCountKeyword(String keyword);

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

	@Update("""
			UPDATE cafe
			SET cafeScrapCount = cafeScrapCount - 1
			WHERE id = #{cafeId}
			""")
	public int decreaseGoodReactionPoint(int cafeId); // TODO

	@Update("""
			UPDATE cafe
			SET cafeScrapCount = cafeScrapCount + 1
			WHERE id = #{cafeId}
			""")
	public int increaseCafeScrapCount(int cafeId); // TODO

	@Select("""
			SELECT cafeScrapCount
			FROM cafe
			WHERE id = #{cafeId}
			""")
	public int getDoScrap(int relId);

	@Select("""
			UPDATE cafe AS C
			INNER JOIN (
			    SELECT CS.cafeId,
			    SUM(IF(CS.scrap > 0, CS.scrap, 0)) AS scrapCount
			    FROM cafeScrap AS CS
			    GROUP BY CS.cafeId
			) AS CS_SUM
			ON C.id = CS_SUM.cafeId
			SET C.cafeScrapCount = CS_SUM.scrapCount;

									""")
	public void updateCafeScrapCount();

}
