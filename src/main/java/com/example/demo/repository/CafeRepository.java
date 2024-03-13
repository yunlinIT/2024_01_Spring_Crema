package com.example.demo.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import com.example.demo.vo.Cafe;

@Mapper
public interface CafeRepository {

    @Insert("""
            INSERT INTO cafe (
                regDate, updateDate, name, address, businessHours,
                phoneNum, facilities, goodReactionPoint, reviewCount, hashtag,
                area, theme, status
            )
            VALUES (
                #{regDate}, #{updateDate}, #{name}, #{address}, #{businessHours},
                #{phoneNum}, #{facilities}, #{goodReactionPoint}, #{reviewCount}, #{hashtag},
                #{area}, #{theme}, #{status}
            )
            """)
    void insertCafe(Cafe cafe);
}

