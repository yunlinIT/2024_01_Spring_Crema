package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.vo.Article;
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
			SELECT id, name, address, goodReactionPoint, reviewCount, hashtag, cafeImgUrl1
			FROM cafe
			""")
	public List<Cafe> getForPrintCafes();



}
