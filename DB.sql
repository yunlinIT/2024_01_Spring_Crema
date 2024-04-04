DROP DATABASE IF EXISTS `Spring_AM_01`;
CREATE DATABASE `Spring_AM_01`;
USE `Spring_AM_01`;

# article 테이블 생성
CREATE TABLE article(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    title CHAR(100) NOT NULL,
    `body` TEXT NOT NULL
);

# member 테이블 생성
CREATE TABLE `member`(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    loginId CHAR(20) NOT NULL,
    loginPw CHAR(80) NOT NULL,
    `authLevel` SMALLINT(2) UNSIGNED DEFAULT 3 COMMENT '권한 레벨 (3=일반,7=관리자)',
    `name` CHAR(20) NOT NULL,
    nickname CHAR(20) NOT NULL,
    cellphoneNum CHAR(20) NOT NULL,
    email CHAR(50) NOT NULL,
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '탈퇴 여부 (0=탈퇴 전, 1=탈퇴 후)',
    delDate DATETIME COMMENT '탈퇴 날짜'
);



# article TD 생성
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목1',
`body` = '내용1';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목2',
`body` = '내용2';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목3',
`body` = '내용3';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목4',
`body` = '내용4';

# member TD 생성
# (관리자)
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'admin',
loginPw = 'admin',
`authLevel` = 7,
`name` = '관리자',
nickname = '관리자',
cellphoneNum = '01012341234',
email = 'abcd@gmail.com';

# (일반)
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test1',
loginPw = 'test1',
`name` = '회원1',
nickname = '회원1',
cellphoneNum = '01043214321',
email = 'abcde@gmail.com';

# (일반)
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test2',
loginPw = 'test2',
`name` = '회원2',
nickname = '회원2',
cellphoneNum = '01056785678',
email = 'abcdef@gmail.com';

ALTER TABLE article ADD COLUMN memberId INT(10) UNSIGNED NOT NULL AFTER updateDate;

UPDATE article
SET memberId = 2
WHERE id IN (1,2);

UPDATE article
SET memberId = 3
WHERE id IN (3,4);


# board 테이블 생성
CREATE TABLE board(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `code` CHAR(50) NOT NULL UNIQUE COMMENT 'notice(공지사항), free(자유), QnA(질의응답) ...',
    `name` CHAR(20) NOT NULL UNIQUE COMMENT '게시판 이름',
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제 여부 (0=삭제 전, 1=삭제 후)',
    delDate DATETIME COMMENT '삭제 날짜'
);

# board TD 생성
INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'NOTICE',
`name` = '크레마 소식';

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'FREE',
`name` = '자유게시판';

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'QnA',
`name` = '질문게시판';

ALTER TABLE article ADD COLUMN boardId INT(10) UNSIGNED NOT NULL AFTER `memberId`;

UPDATE article
SET boardId = 1
WHERE id IN (1,2);

UPDATE article
SET boardId = 2
WHERE id = 3;

UPDATE article
SET boardId = 3
WHERE id = 4;

ALTER TABLE article ADD COLUMN hitCount INT(10) UNSIGNED NOT NULL DEFAULT 0 AFTER `body`;

# reactionPoint 테이블 생성
CREATE TABLE reactionPoint(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    relTypeCode CHAR(50) NOT NULL COMMENT '관련 데이터 타입 코드',
    relId INT(10) NOT NULL COMMENT '관련 데이터 번호',
    `point` INT(10) NOT NULL
);

# reactionPoint 테스트 데이터 생성
# 1번 회원이 1번 글에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'article',
relId = 1,
`point` = -1;

# 1번 회원이 2번 글에 좋아요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'article',
relId = 2,
`point` = 1;

# 2번 회원이 1번 글에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 1,
`point` = -1;

# 2번 회원이 2번 글에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 2,
`point` = -1;

# 3번 회원이 1번 글에 좋아요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 3,
relTypeCode = 'article',
relId = 1,
`point` = 1;

# article 테이블에 좋아요 관련 컬럼 추가
ALTER TABLE article ADD COLUMN goodReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE article ADD COLUMN badReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;

# update join -> 기존 게시물의 good,bad RP 값을 RP 테이블에서 가져온 데이터로 채운다
UPDATE article AS A
INNER JOIN (
    SELECT RP.relTypeCode,RP.relId,
    SUM(IF(RP.point > 0, RP.point, 0)) AS goodReactionPoint,
    SUM(IF(RP.point < 0, RP.point * -1, 0)) AS badReactionPoint
    FROM reactionPoint AS RP
    GROUP BY RP.relTypeCode, RP.relId
) AS RP_SUM
ON A.id = RP_SUM.relId
SET A.goodReactionPoint = RP_SUM.goodReactionPoint,
A.badReactionPoint = RP_SUM.badReactionPoint;

# reply 테이블 생성
CREATE TABLE reply (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    relTypeCode CHAR(50) NOT NULL COMMENT '관련 데이터 타입 코드',
    relId INT(10) NOT NULL COMMENT '관련 데이터 번호',
    `body`TEXT NOT NULL
);

# 2번 회원이 1번 글에 댓글 작성
INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 1,
`body` = '댓글 1';

# 2번 회원이 1번 글에 댓글 작성
INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 1,
`body` = '댓글 2';

# 3번 회원이 1번 글에 댓글 작성
INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 3,
relTypeCode = 'article',
relId = 1,
`body` = '댓글 3';

# 3번 회원이 1번 글에 댓글 작성
INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 2,
`body` = '댓글 4';

# reply 테이블에 좋아요 관련 컬럼 추가
ALTER TABLE reply ADD COLUMN goodReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE reply ADD COLUMN badReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;

# reactionPoint 테스트 데이터 생성
# 1번 회원이 1번 댓글에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'reply',
relId = 1,
`point` = -1;

# 1번 회원이 2번 댓글에 좋아요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'reply',
relId = 2,
`point` = 1;

# 2번 회원이 1번 댓글에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'reply',
relId = 1,
`point` = -1;

# 2번 회원이 2번 댓글에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'reply',
relId = 2,
`point` = -1;

# 3번 회원이 1번 댓글에 좋아요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 3,
relTypeCode = 'reply',
relId = 1,
`point` = 1;

# update join -> 기존 게시물의 good,bad RP 값을 RP 테이블에서 가져온 데이터로 채운다
UPDATE reply AS R
INNER JOIN (
    SELECT RP.relTypeCode,RP.relId,
    SUM(IF(RP.point > 0, RP.point, 0)) AS goodReactionPoint,
    SUM(IF(RP.point < 0, RP.point * -1, 0)) AS badReactionPoint
    FROM reactionPoint AS RP
    GROUP BY RP.relTypeCode, RP.relId
) AS RP_SUM
ON R.id = RP_SUM.relId
SET R.goodReactionPoint = RP_SUM.goodReactionPoint,
R.badReactionPoint = RP_SUM.badReactionPoint;


CREATE TABLE cafe (
    `id` INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '카페 번호', 
    `regDate` DATETIME COMMENT '등록 날짜', 
    `updateDate` DATETIME COMMENT '수정 날짜', 
    `name` CHAR(50) NOT NULL COMMENT '카페 상호명', 
    `address` CHAR(100) COMMENT '카페 주소', 
    `businessHours` TEXT COMMENT '영업시간', 
    `phoneNum` CHAR(20) COMMENT '전화번호', 
    `facilities` TEXT COMMENT '시설', 
    `cafeScrapCount` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '찜수', 
    `reviewCount` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '리뷰 수', 
    `hashtag` CHAR(200) COMMENT '해쉬태그', 
    `cafeImgUrl1` TEXT COMMENT '카페 사진1',
    `cafeImgUrl2` TEXT COMMENT '카페 사진2',
    `cafeImgUrl3` TEXT COMMENT '카페 사진3',
    `cafeImgUrl4` TEXT COMMENT '카페 사진4',
    `cafeImgUrl5` TEXT COMMENT '카페 사진5'
);


# 카페 테스트 데이터 1 (동구)
INSERT INTO cafe 
SET regDate = NOW(),
updateDate = NOW(),
`name` = '카페사소한',
`address` = '대전 동구 백룡로38번길 19 1층',
`businessHours` = '월 11:30 - 21:00; 화 11:30 - 21:00; 수 11:30 - 21:00; 목 11:30 - 21:00; 금 11:30 - 21:00; 토 12:30 - 18:30; 일 12:30 - 18:30;', 
`phoneNum` = '0507-1388-1844', 
`facilities` = NULL, 
`cafeScrapCount` = 1, 
#`reviewCount` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '리뷰 수', 
`hashtag` = '#아늑한 #대화 #데이트 #사진맛집 #클래식', 
`cafeImgUrl1` = 'https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20201117_59%2F1605607665526NPlXg_JPEG%2FG7oFmpFP-9oX4fU7fK1_kJsw.jpeg.jpg',
`cafeImgUrl2` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20201117_115%2F1605607674000iq6jm_JPEG%2FvBatF4-javorvm0chk1s5NwF.jpeg.jpg',
`cafeImgUrl3` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20201117_276%2F1605607680055jKj83_JPEG%2FnppOHwFGfqDLGkJ5o2LPrd3C.jpeg.jpg',
`cafeImgUrl4` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20201117_64%2F1605607688521tn2Ua_JPEG%2F706ednnHFfhiUnlxedhhjyii.jpeg.jpg',
`cafeImgUrl5` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20201117_125%2F1605607697204cNkYr_JPEG%2FP1ubOwNMIPh9qL8VWUqlQ9A9.jpeg.jpg';

# 카페 테스트 데이터 2 (동구)
INSERT INTO cafe 
SET regDate = NOW(),
updateDate = NOW(),
`name` = '파이브퍼센트',
`address` = '대전 동구 동대전로110번길 177',
`businessHours` = '월 11:00 - 23:00; 화 11:00 - 23:00; 수 11:00 - 23:00; 목 11:00 - 23:00; 금 11:00 - 23:00; 토 11:00 - 23:00; 일 11:00 - 23:00; ', 
`phoneNum` = NULL, 
`facilities` = '무선 인터넷, 포장, 남/녀 화장실 구분', 
#`goodReactionPoint` = 1, 
#`reviewCount` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '리뷰 수', 
`hashtag` = '#뷰맛집 #테라스 #데이트 #사진맛집 #모던', 
`cafeImgUrl1` = 'https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231108_51%2F1699434996882sOpky_JPEG%2Fscaled_1699434867969.jpg',
`cafeImgUrl2` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231119_100%2F1700384237212oMyjk_JPEG%2Fscaled_20231119_170835.jpg',
`cafeImgUrl3` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231113_262%2F1699848031088OhR5v_JPEG%2Fscaled_20231112_194927.jpg',
`cafeImgUrl4` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231108_285%2F1699446257991ILAjN_JPEG%2Fscaled_1699445911053.jpg',
`cafeImgUrl5` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230716_157%2F1689503122459G0rJj_JPEG%2F20230716_192218.jpg';

# 카페 테스트 데이터 3 (동구)
INSERT INTO cafe 
SET regDate = NOW(),
updateDate = NOW(),
`name` = '롤라',
`address` = '대전 동구 회남로275번길 123',
`businessHours` = '월 ~ 금 카페&베이커리 11:00 - 20:30 (20:00 라스트오더); 브런치 11:00 - 17:30 (17:00 라스트오더); 토 ~ 일 카페&베이커리 10:30 - 20:30 (20:00 라스트오더); 브런치 10:30 - 18:30 (18:00 라스트오더)', 
`phoneNum` = '0507-1380-9522', 
`facilities` = '주차, 남/녀 화장실 구분, 반려동물 동반, 포장, 단체 이용 가능, 무선 인터넷', 
#`goodReactionPoint` = 1, 
#`reviewCount` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '리뷰 수', 
`hashtag` = '#넓은 #뷰맛집 #테라스 #사진맛집 #반려동물 #대형카페', 
`cafeImgUrl1` = 'https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20220930_130%2F1664503526528Qa7wy_JPEG%2FIMG_1145.jpeg',
`cafeImgUrl2` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230630_64%2F1688091175554k8zWy_JPEG%2FEECD5943-29EF-4F9C-8EAE-5C26AFA1835B.jpeg',
`cafeImgUrl3` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20220930_265%2F1664503526532x9bCc_JPEG%2FIMG_1146.jpeg',
`cafeImgUrl4` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20220930_123%2F1664503526558yRVWI_JPEG%2FIMG_1151.jpeg',
`cafeImgUrl5` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230630_279%2F1688091140016bdRc3_JPEG%2FE99A225C-7DC4-414F-9CD1-A4C93D1612F6.jpeg';

# 카페 테스트 데이터 4 (동구)
INSERT INTO cafe 
SET regDate = NOW(),
updateDate = NOW(),
`name` = '풍류소제',
`address` = '대전 동구 수향길 31',
`businessHours` = '매일 11:00 - 21:00;', 
`phoneNum` = '0507-1331-6717', 
`facilities` = '포장, 무선 인터넷', 
#`goodReactionPoint` = 1, 
#`reviewCount` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '리뷰 수', 
`hashtag` = '#넓은 #뷰맛집 #테라스 #사진맛집 #반려동물', 
`cafeImgUrl1` = 'https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240305_223%2F17096104557822Wi1l_JPEG%2FKakaoTalk_20240227_173726820_02.jpg',
`cafeImgUrl2` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240305_72%2F1709610451256UwX2v_JPEG%2FKakaoTalk_20240227_173726820_01.jpg',
`cafeImgUrl3` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240305_77%2F1709610445786E18z6_JPEG%2FKakaoTalk_20240227_173726820.jpg',
`cafeImgUrl4` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240305_230%2F1709610440387SpbLX_JPEG%2FKakaoTalk_20240227_173726820_07.jpg',
`cafeImgUrl5` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240305_65%2F1709610432647AYQw1_JPEG%2FKakaoTalk_20240227_173726820_06.jpg';

# 카페 테스트 데이터 5 (중구)
INSERT INTO cafe 
SET 
    regDate = '2024-03-19 21:55:08',
    updateDate = '2024-03-19 21:55:08',
    `name` = '도마카포 에스프레소바',
    `address` = '대전 중구 중앙로170번길 23 1층 101호',
    `businessHours` = '화 11:00 - 21:00; 수 11:00 - 21:00; 목 11:00 - 21:00; 금 11:00 - 21:00; 토 11:00 - 21:00; 일 11:00 - 21:00; 월 11:00 - 21:00; 20:30 라스트오더;',
    `phoneNum` = '0507-1415-2931',
    `facilities` = '남/녀 화장실 구분, 무선 인터넷, 포장, 단체 이용 가능, 간편결제',
    `hashtag` = '#에스프레소바 #넓은 #데이트 #모던 #대화',
    `cafeImgUrl1` = 'https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230828_131%2F1693207754934Mmp6w_JPEG%2FKakaoTalk_20230828_155350227_11.jpg',
    `cafeImgUrl2` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230828_112%2F1693207755656Fpo02_JPEG%2FKakaoTalk_20230828_155350227_10.jpg',
    `cafeImgUrl3` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230828_124%2F1693207699340XFfsu_JPEG%2FKakaoTalk_20230828_162222135_01.jpg',
    `cafeImgUrl4` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230828_258%2F16932076992819coU9_JPEG%2FKakaoTalk_20230828_162222135.jpg',
    `cafeImgUrl5` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230828_64%2F1693207699855eMSnS_JPEG%2FKakaoTalk_20230828_162222135_07.jpg';
# 카페 테스트 데이터 6 (서구)
INSERT INTO cafe 
SET 
    regDate = '2024-03-19 22:09:38',
    updateDate = '2024-03-19 22:09:38',
    `name` = '스니프커피바',
    `address` = '대전 서구 복수동로52번길 49 1층',
    `businessHours` = '화 12:00 - 24:00; 수 12:00 - 24:00; 목 12:00 - 24:00; 금 정기휴무 (매주 금요일); 토 12:00 - 24:00; 일 12:00 - 24:00; 월 12:00 - 24:00; 23:00 라스트오더;',
    `phoneNum` = '010-2456-9052',
    `facilities` = '무선 인터넷, 반려동물 동반, 포장',
    `hashtag` = '#심플 #모던 #반려동물 #업무/공부 #콘센트',
    `cafeImgUrl1` = 'https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200615_44%2F1592222673181HnuMn_JPEG%2FZX-GjFA1lfUBlZuRL9sgJ9b1.jpeg.jpg',
    `cafeImgUrl2` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200615_180%2F1592222462627oQ5qH_JPEG%2F_w7O7enoDpy7UCJ2HvJWrfXp.jpeg.jpg',
    `cafeImgUrl3` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200615_49%2F1592222478161cBVDN_JPEG%2Fq2qQdOz3HOktZxcuhC_WJ2kJ.jpeg.jpg',
    `cafeImgUrl4` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200615_23%2F1592222537950s1xzi_JPEG%2FmTVnIAxLznk3xmIIhN1Pj3hS.jpeg.jpg',
    `cafeImgUrl5` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200620_233%2F1592631908855qRFAY_JPEG%2FVmJoJR3tYlUhfRbKb8saRzJR.jpeg.jpg';

# 카페 테스트 데이터 7 (서구)
INSERT INTO cafe 
SET 
    regDate = '2024-03-19 22:34:48',
    updateDate = '2024-03-19 22:34:48',
    `name` = '컨사이스',
    `address` = '대전 서구 둔산남로180번길 31',
    `businessHours` = '화 정기휴무 (매주 화요일); 수 11:30 - 21:30 - 20:30 라스트오더; 목 11:30 - 21:30 - 20:30 라스트오더; 금 11:30 - 21:30 - 20:30 라스트오더; 토 11:30 - 21:30 - 20:30 라스트오더; 일 11:30 - 21:30 - 20:30 라스트오더; 월 11:30 - 21:30 - 20:30 라스트오더;',
    `phoneNum` = '0507-1314-1256',
    `facilities` = '단체 이용 가능, 반려동물 동반, 포장, 무선 인터넷',
    `hashtag` = '#단체 #반려동물 #디저트맛집 #편한좌석 #대화',
    `cafeImgUrl1` = ' https://search.pstatic.net/common/?autoRotate=TRUE&TYPE=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230726_239%2F1690361523355G8rdr_JPEG%2F1660104885027.jpg',
    `cafeImgUrl2` = 'https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20191108_238%2F1573212385144VAvnF_JPEG%2FvxDr4EunuXOVIdjWx8LdcLzf.jpg',
    `cafeImgUrl3` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230726_128%2F16903615646153u2xX_JPEG%2F1660104885268.jpg',
    `cafeImgUrl4` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230726_33%2F16903615894222Lxcg_JPEG%2F1660104885514.jpg',
    `cafeImgUrl5` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230726_86%2F1690361589370avi7t_JPEG%2F1660104885467.jpg';

# 카페 테스트 데이터 8 (서구)
INSERT INTO cafe 
SET 
    regDate = '2024-03-19 23:02:17',
    updateDate = '2024-03-19 23:02:17',
    `name` = '투데이엣 로스터리',
    `address` = '대전 서구 용소로58번길 21 1층',
    `businessHours` = '화 11:00 - 22:00 - 21:30 라스트오더; 수 11:00 - 22:00 - 21:30 라스트오더; 목 11:00 - 22:00 - 21:30 라스트오더; 금 11:00 - 22:00 - 21:30 라스트오더; 토 11:00 - 22:00 - 21:30 라스트오더; 일 11:00 - 22:00 - 21:30 라스트오더; 월 정기휴무 (매주 월요일);',
    `phoneNum` = '010-4798-1214',
    `facilities` = '예약, 단체 이용 가능, 포장, 무선 인터넷, 남/녀 화장실 구분, 주차',
    `hashtag` = '#로스터리 #대화 #모던 #심플 #데이트',
    `cafeImgUrl1` = 'https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240131_273%2F17066653240356crAv_JPEG%2F1000003231.jpg',
    `cafeImgUrl2` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240131_233%2F1706665158091D0zrk_JPEG%2F1000005464.jpg',
    `cafeImgUrl3` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230314_168%2F1678747838023ROBIr_JPEG%2FIMG_20230203_130508_151.jpg',
    `cafeImgUrl4` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230805_167%2F1691204519852yo1UT_JPEG%2F20230804_002030.jpg',
    `cafeImgUrl5` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230106_58%2F1672976398628OxVLv_JPEG%2F1000001214.jpg';

# 카페 테스트 데이터 9 (서구)
INSERT INTO cafe 
SET 
    regDate = '2024-03-19 23:17:23',
    updateDate = '2024-03-19 23:17:23',
    `name` = '카페 일오이오',
    `address` = '대전 서구 관저중로64번길 24 카페 일오이오',
    `businessHours` = '화 10:00 - 24:00 - 23:00 라스트오더; 수 10:00 - 24:00 - 23:00 라스트오더; 목 10:00 - 24:00 - 23:00 라스트오더; 금 10:00 - 24:00 - 23:00 라스트오더; 토 10:00 - 24:00 - 23:00 라스트오더; 일 10:00 - 22:00 - 21:00 라스트오더; 월 10:00 - 24:00 - 23:00 라스트오더;',
    `phoneNum` = '042-822-5510',
    `facilities` = '포장, 남/녀 화장실 구분, 무선 인터넷, 단체 이용 가능, 예약, 간편결제, 주차',
    `hashtag` = '#대형카페 #단체 #테라스 #디저트맛집 #주차',
    `cafeImgUrl1` = 'https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231209_50%2F1702131681710NFjzD_JPEG%2FKakaoTalk_20231012_103957009.jpg',
    `cafeImgUrl2` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231121_80%2F17005204782848LQzV_JPEG%2FIMG_7036.jpg',
    `cafeImgUrl3` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231121_21%2F1700520391933Xm5He_JPEG%2FIMG_6925.jpg',
    `cafeImgUrl4` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231121_221%2F1700520464498mMTbG_JPEG%2FIMG_7003.jpg',
    `cafeImgUrl5` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231121_198%2F1700520453929HNHJ8_JPEG%2FIMG_6989.jpg';

# 카페 테스트 데이터 10 (서구)
INSERT INTO cafe 
SET 
    regDate = '2024-03-19 23:29:25',
    updateDate = '2024-03-19 23:29:25',
    `name` = '빈이어',
    `address` = '대전 서구 계룡로 399 2층',
    `businessHours` = '매일 12:00 - 22:00;',
    `phoneNum` = '0507-1335-1396',
    `facilities` = '무선 인터넷, 포장, 반려동물 동반, 배달',
    `hashtag` = '#빈이어 #반려동물 #디저트맛집 #데이트 #대화 #심플',
    `cafeImgUrl1` = 'https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240103_195%2F1704272884978ICiRw_JPEG%2FIMG_5251.jpeg',
    `cafeImgUrl2` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231116_2%2F1700064596615RjksM_JPEG%2FIMG_3764.jpeg',
    `cafeImgUrl3` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240103_66%2F1704272883187HJDAU_JPEG%2FBC0E4B08-703E-4710-9AED-BA4F5F00F777.jpeg',
    `cafeImgUrl4` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240103_212%2F1704272884234wHozz_JPEG%2FIMG_5241.jpeg',
    `cafeImgUrl5` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231116_3%2F1700064589147tQKrY_JPEG%2FADF4B16C-1C04-41BA-AB0E-789804B546D8.jpeg';


# 카페 테스트 데이터 11(대덕구)
INSERT INTO cafe 
SET 
    regDate = '2024-03-20 00:57:15',
    updateDate = '2024-03-20 00:57:15',
    `name` = '라끄블루',
    `address` = '대전 동구 회남로275번길 161',
    `businessHours` = '수 정기휴무 (매주 수요일); 목 10:00 - 21:00\n19:30 라스트오더; 금 10:00 - 21:00\n19:30 라스트오더; 토 10:00 - 21:00\n19:30 라스트오더; 일 10:00 - 21:00\n19:30 라스트오더; 월 10:00 - 21:00\n19:30 라스트오더; 화 10:00 - 21:00\n19:30 라스트오더;',
    `phoneNum` = '0507-1309-6458',
    `hashtag` = '#뷰맛집 #대형카페 #주차 #단체 #대화',
    `cafeImgUrl1` = 'https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20180417_41%2F1523969566894nuHPV_JPEG%2FiDLLahRotyTiWFfw7d3FrRU_.jpg',
    `cafeImgUrl2` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230612_198%2F16865600121914dYFc_JPEG%2FIMG_1600.jpeg',
    `cafeImgUrl3` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230612_282%2F1686560004257w1KzA_JPEG%2FPHOTO_0306.jpeg',
    `cafeImgUrl4` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20170511_102%2F1494482476015sGak2_JPEG%2FKakaoTalk_20170508_132456639.jpg',
    `cafeImgUrl5` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230612_141%2F1686560005500zNgTW_JPEG%2FPHOTO_0321.jpeg';



# 카페 테스트 데이터 12(대덕구)

INSERT INTO cafe 
SET 
    regDate = '2024-03-20 00:57:15',
    updateDate = '2024-03-20 00:57:15',
    `name` = '에이트',
    `address` = '대전 유성구 한밭대로 458 에이트',
    `businessHours` = '화 10:00 - 02:00\n01:30 라스트오더; 수 10:00 - 02:00\n01:30 라스트오더; 목 10:00 - 02:00\n01:30 라스트오더; 금 10:00 - 02:00\n01:30 라스트오더; 토 10:00 - 02:00\n01:30 라스트오더; 일 10:00 - 02:00\n01:30 라스트오더; 월 10:00 - 02:00\n01:30 라스트오더;',
    `phoneNum` = '042-716-1195',
    `hashtag` = '#사진맛집 #대형카페 #대관 #단체 #주차',
    `cafeImgUrl1` = 'https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240119_76%2F1705633229938ombuI_JPEG%2F1702464463604.jpg',
    `cafeImgUrl2` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20220712_15%2F1657620881597u6lF7_JPEG%2FD0D1A1E0-152D-4BC1-812B-4BDE51A9C919.jpeg',
    `cafeImgUrl3` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240119_79%2F1705633409408vlm5c_JPEG%2F1705494125332.jpg',
    `cafeImgUrl4` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240119_59%2F17056334105739GYsv_JPEG%2F1705494299441.jpg',
    `cafeImgUrl5` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240119_270%2F1705633410786UaXqU_JPEG%2F1691571905846.jpg';


# 카페 테스트 데이터 13(대덕구)
INSERT INTO cafe 
SET 
    regDate = '2024-03-20 00:49:12',
    updateDate = '2024-03-20 00:49:12',
    `name` = '두두당',
    `address` = '대전 대덕구 대청로 234',
    `businessHours` = '매일 10:30 - 22:00\n21:30 라스트오더;',
    `phoneNum` = '042-933-0086',
    `hashtag` = '#대형카페 #반려동물 #단체 #주차 #사진맛집',
    `cafeImgUrl1` = 'https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20220805_238%2F1659688859117j0z41_JPEG%2F1648565585588_105633522.t.jpg',
    `cafeImgUrl2` = 'https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240318_236%2F1710696620192Gz227_PNG%2F%25BD%25BA%25B8%25B6%25C6%25AE_%25C7%25C3%25B7%25B9%25C0%25CC%25BD%25BA_%25BE%25F7%25B7%25CE%25B5%25E5%25BF%25EB_%25B5%25CE%25B5%25CE%25B4%25E7.png',
    `cafeImgUrl3` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20220805_193%2F1659688995631Lo6GR_JPEG%2F227779407_520352499219346_8436309852526508935_n_%25281%2529.jpg',
    `cafeImgUrl4` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20220805_25%2F1659688422127803ct_JPEG%2F20210815_103238.jpg';




# 카페 테스트 데이터 14(대덕구)

INSERT INTO cafe 
SET 
    regDate = '2024-03-20 00:49:12',
    updateDate = '2024-03-20 00:49:12',
    `name` = '몽심',
    `address` = '대전 대덕구 한남로38번길 28 1층',
    `businessHours` = '매일 11:00 - 19:30;',
    `phoneNum` = '010-4459-1014',
    `hashtag` = '#디저트맛집 #대화 #데이트 #아늑한 #아기자기',
    `cafeImgUrl1` = 'https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240212_242%2F170770471091951z62_JPEG%2FIMG_5072.jpeg',
    `cafeImgUrl2` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240212_12%2F1707704697875KItvX_JPEG%2FIMG_5105.jpeg',
    `cafeImgUrl3` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240212_238%2F1707704699341JSJfU_JPEG%2FIMG_5106.jpeg',
    `cafeImgUrl4` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20221231_65%2F1672474002750QQv32_JPEG%2F8C75A85D-8D7A-4217-8256-A16CF8A4BCBE.jpeg',
    `cafeImgUrl5` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20221231_183%2F16724740026559IFWi_JPEG%2F5149EF91-6482-498D-9B0B-F5112DF40CC5.jpeg';



# 카페 테스트 데이터 15(대덕구)
INSERT INTO cafe 
SET 
    regDate = '2024-03-20 00:49:12',
    updateDate = '2024-03-20 00:49:12',
    `name` = '삼삼카페',
    `address` = '대전 대덕구 대청호수로 1875 1층',
    `businessHours` = '수 11:30 - 20:00; 목 11:30 - 21:00; 금 11:30 - 21:00; 토 11:00 - 21:00; 일 11:00 - 21:00; 월 정기휴무 (매주 월요일); 화 11:30 - 20:00;',
    `phoneNum` = '0507-1379-0661',
    `hashtag` = '#뷰맛집 #반려동물 #넓은 #주차 #편한좌석',
    `cafeImgUrl1` = 'https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20201028_66%2F1603875359863pj4sK_JPEG%2F3SnzxT1p4EHfbeLxkdBRyuDQ.jpeg.jpg',
    `cafeImgUrl2` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20210205_227%2F1612457779107qWEyB_JPEG%2Fo831yLYExcYZBzpzSoCPvW2o.jpeg.jpg',
    `cafeImgUrl3` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20210205_139%2F1612457799255BE6VI_JPEG%2FTd7eM_4CWchEjohdlZZtnW6x.jpeg.jpg',
    `cafeImgUrl4` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20210205_82%2F1612457834458njQ63_JPEG%2FPBai_qwIcFYbbp6gb2PiTgeg.jpeg.jpg',
    `cafeImgUrl5` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20210205_162%2F1612457863257Pxur5_JPEG%2FMapZQw27S-24mPDRm7TqkGp0.jpeg.jpg';



# 카페 테스트 데이터 16 (중구)
INSERT INTO cafe 
SET 
    regDate = '2024-03-19 23:34:52',
    updateDate = '2024-03-19 23:34:52',
    `name` = '테디, 스테디, 고',
    `address` = '대전 중구 중앙로79번길 87 2층',
    `businessHours` = '화 12:00 - 22:00; 수 12:00 - 20:00; 목 정기휴무 (매주 목요일); 금 12:00 - 22:00; 토 12:00 - 22:00; 일 12:00 - 22:00; 월 12:00 - 22:00;',
    `phoneNum` = '0507-1370-6546',
    `facilities` = '포장, 유아의자, 무선 인터넷, 간편결제',
    `hashtag` = '#아기자기 # 대화 #레트로 #아늑한 #사진맛집',
    `cafeImgUrl1` = 'https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231221_176%2F1703139370908QGekx_JPEG%2FPS5M1410.',
    `cafeImgUrl2` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231221_191%2F1703139861610Mx5xj_JPEG%2FPS5M1409.',
    `cafeImgUrl3` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231221_119%2F1703139395060MwY47_JPEG%2FPS5M1407.',
    `cafeImgUrl4` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231221_8%2F1703139396881EIXtA_JPEG%2FPS5M1439.',
    `cafeImgUrl5` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231221_48%2F1703139396201E4lTK_JPEG%2FPS5M1408.';

# 카페 테스트 데이터 17 (중구)
INSERT INTO cafe 
SET 
    regDate = '2024-03-19 23:34:52',
    updateDate = '2024-03-19 23:34:52',
    `name` = '오시우커피',
    `address` = '대전 중구 목척8길 39 1층',
    `businessHours` = '화 11:00 - 22:00; 수 11:00 - 22:00; 목 11:00 - 22:00; 금 11:00 - 22:00; 토 11:00 - 22:00; 일 11:00 - 22:00; 월 11:00 - 22:00; 21:30 라스트오더;',
    `phoneNum` = '010-5940-5601',
    `facilities` = '반려동물 동반, 남/녀 화장실 구분, 포장',
    `hashtag` = '#데이트 #반려동물 #모던 #심플 #내추럴',
    `cafeImgUrl1` = 'https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240103_95%2F1704262097045LYH6R_JPEG%2FIMG_0502.jpeg',
    `cafeImgUrl2` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240103_74%2F170426209951330pma_JPEG%2FIMG_0598.jpeg',
    `cafeImgUrl3` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240103_182%2F1704262095822o9VhX_JPEG%2FIMG_9675.jpeg',
    `cafeImgUrl4` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240103_3%2F1704262097742XO5od_JPEG%2FIMG_0824.jpeg',
    `cafeImgUrl5` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20210902_198%2F1630557776186nNbpI_JPEG%2Fte1fLv4KjHai55iGZgS_MUqo.jpeg.jpg';

# 카페 테스트 데이터 18 (중구)
INSERT INTO cafe 
SET 
    regDate = '2024-03-20 00:00:07',
    updateDate = '2024-03-20 00:00:07',
    `name` = '우시아',
    `address` = '대전 중구 목척2길 8 1층',
    `businessHours` = '화 13:00 - 23:00; 수 13:00 - 23:00; 목 13:00 - 23:00; 금 13:00 - 23:00; 토 13:00 - 23:00; 일 12:00 - 22:00; 월 12:00 - 22:00;',
    `phoneNum` = '070-4680-6644',
    `hashtag` = '#아늑한 #디저트맛집 #내추럴 #데이트 #아기자기',
    `cafeImgUrl1` = 'https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231013_233%2F1697171087637UHwBy_JPEG%2F1111111111.jpg',
    `cafeImgUrl2` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240221_294%2F1708495985396CB9qA_JPEG%2FKakaoTalk_Photo_2024-02-21-14-59-51.jpg',
    `cafeImgUrl3` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231128_67%2F1701101107215M2x9r_JPEG%2FIMG_1623.jpeg',
    `cafeImgUrl4` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231013_5%2F1697170960244qhBmh_JPEG%2FIMG_1186.jpg',
    `cafeImgUrl5` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230911_282%2F1694431662638tDLlJ_JPEG%2FIMG_0743.jpeg';

# 카페 테스트 데이터 19 (중구)
INSERT INTO cafe 
SET 
    regDate = '2024-03-20 00:10:47',
    updateDate = '2024-03-20 00:10:47',
    `name` = '오디스커피',
    `address` = '대전 중구 문화로 169-1 1층',
    `businessHours` = '수 11:00 - 20:00; 목 11:00 - 20:00; 금 11:00 - 20:00; 토 11:00 - 20:00; 일 11:00 - 20:00; 월 11:00 - 20:00; 화 11:00 - 20:00;',
    `phoneNum` = '042-385-3456',
    `facilities` = '포장, 배달, 단체 이용 가능, 무선 인터넷, 예약, 간편결제, 주차',
    `hashtag` = '#아늑한 #주차 #심플 #대화 #데이트',
    `cafeImgUrl1` = 'https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231227_69%2F1703650684913Ia7Fw_JPEG%2F1.jpg',
    `cafeImgUrl2` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231228_190%2F1703742949337RFuQL_JPEG%2FIMG_8674.jpeg',
    `cafeImgUrl3` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fnaverbooking-phinf.pstatic.net%2F20231224_256%2F17033833921212J4Of_JPEG%2Fimage.jpg',
    `cafeImgUrl4` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231222_49%2F1703257045864DFA6b_JPEG%2FKakaoTalk_20231222_235649641.jpg',
    `cafeImgUrl5` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fnaverbooking-phinf.pstatic.net%2F20231224_103%2F1703383407356G5uTu_JPEG%2Fimage.jpg';

# 카페 테스트 데이터 20 (동구)
INSERT INTO cafe 
SET 
    regDate = '2024-03-20 00:18:47',
    updateDate = '2024-03-20 00:18:47',
    `name` = '콜드바',
    `address` = '대전 동구 백룡로47번길 2 1층',
    `businessHours` = '수 11:00 - 22:00; 목 11:00 - 22:00; 금 정기휴무 (매주 금요일); 토 12:00 - 21:00; 일 12:00 - 21:00; 월 11:00 - 22:00; 화 11:00 - 22:00;',
    `phoneNum` = '0507-1372-5800',
    `facilities` = '포장',
    `hashtag` = '#사진맛집 #아늑한 #넓은 #디저트맛집 #데이트',  
    `cafeImgUrl1` = 'https://search.pstatic.net/common/?autoRotate=TRUE&TYPE=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230228_166%2F1677561254431XarPX_JPEG%2FKakaoTalk_20230227_210412022_04.jpg',
    `cafeImgUrl2` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20221112_66%2F1668180171767cLLAu_JPEG%2FKakaoTalk_Photo_2022-11-12-00-22-39_002.jpeg',
    `cafeImgUrl3` = 'https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230228_62%2F1677562628085WBhk5_PNG%2F003.png',
    `cafeImgUrl4` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230228_115%2F1677561254617UUwdg_JPEG%2FKakaoTalk_20230227_210412022_03.jpg',
    `cafeImgUrl5` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20221112_149%2F1668181648891RPMRg_JPEG%2FKakaoTalk_Photo_2022-11-12-00-40-28_007.jpeg';




# 카페 테스트 데이터 21 (유성구)
INSERT INTO cafe 
SET 
    regDate = '2024-03-20 00:30:53',
    updateDate = '2024-03-20 00:30:53',
    `name` = '그린베이커리',
    `address` = '대전 유성구 테크노4로 98-8 평원오피스텔 101호',
    `businessHours` = '수 11:00 - 20:00; 목 11:00 - 20:00; 금 11:00 - 20:00; 토 11:00 - 20:00; 일 11:00 - 20:00; 월 11:00 - 20:00; 화 11:00 - 20:00;',
    `phoneNum` = '0507-1313-3497',
    `facilities` = '예약, 무선 인터넷, 남/녀 화장실 구분, 포장',
    `hashtag` = '#디저트맛집 #데이트 #대화 #아늑한 #편한좌석',
    `cafeImgUrl1` = 'https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20181204_9%2F1543908909073ssVMu_JPEG%2FgnaXUwVXFobl5LcTe9agHCgo.jpeg.jpg',
    `cafeImgUrl2` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20181204_176%2F1543908927753p6sTE_JPEG%2FoI0FrrLVHDPEhiqa5ue8-UUD.jpeg.jpg',
    `cafeImgUrl3` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20181204_186%2F1543908942630pGXXc_JPEG%2FDckRGeSQ1DwxpA7frTzXULjE.jpeg.jpg',
    `cafeImgUrl4` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20181204_37%2F1543908956778xt6oM_JPEG%2FXXIoeitgyC3F7AxyJas-NxQH.jpeg.jpg',
    `cafeImgUrl5` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20181204_221%2F1543908978177aBPbf_JPEG%2F1qcI2x2zbcMJrFAMEAUwvPGz.jpeg.jpg';

# 카페 테스트 데이터 22 (유성구)
INSERT INTO cafe 
SET 
    regDate = '2024-03-20 00:30:53',
    updateDate = '2024-03-20 00:30:53',
    `name` = '아케이드커피',
    `address` = '대전 유성구 대학로 48-17 1층',
    `businessHours` = '매일 12:00 - 24:00;',
    `phoneNum` = '042-826-5400',
    `facilities` = '단체 이용 가능, 포장, 남/녀 화장실 구분, 반려동물 동반, 대기공간, 방문접수/출장',
    `hashtag` = '#대형카페 #넓은 #단체 #모던 #사진맛집',
    `cafeImgUrl1` = 'https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20191219_170%2F1576732914661Tpqof_JPEG%2FgMNXr7VsE77DShP0eZO8yApN.jpeg.jpg',
    `cafeImgUrl2` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20220814_53%2F1660484053777jFPEN_JPEG%2FKakaoTalk_20220814_223353493.jpg',
    `cafeImgUrl3` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20220814_171%2F1660483757482qeQ8H_JPEG%2FKakaoTalk_20220814_222843651.jpg',
    `cafeImgUrl4` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20220814_229%2F1660483924793vekfx_JPEG%2FKakaoTalk_20220814_223135685.jpg',
    `cafeImgUrl5` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20220814_209%2F16604839249532tUPk_JPEG%2FKakaoTalk_20220814_223135685_02.jpg';

# 카페 테스트 데이터 23 (유성구)
INSERT INTO cafe 
SET 
    regDate = '2024-03-20 00:30:53',
    updateDate = '2024-03-20 00:30:53',
    `name` = '커피인터뷰',
    `address` = '대전 유성구 한밭대로371번길 25-3',
    `businessHours` = '수 11:00 - 22:00; 목 11:00 - 22:00; 금 11:00 - 22:00; 토 11:00 - 22:00; 일 11:00 - 22:00; 월 11:00 - 22:00; 화 11:00 - 22:00;',
    `phoneNum` = '042-823-3712',
    `facilities` = '주차, 무선 인터넷, 남/녀 화장실 구분, 포장',
    `hashtag` = '#사진맛집 #대형카페 #넓은 #내추럴 #포토존',
    `cafeImgUrl1` = 'https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200515_10%2F1589469090893uiUaX_JPEG%2FdOF7rbWu_ij5Tp01mcTkUbdg.jpg',
    `cafeImgUrl2` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200515_241%2F1589469089917luF9s_JPEG%2FhKyNdwzZBXsLPIlIe7JuhVkV.jpg',
    `cafeImgUrl3` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200515_281%2F1589469091039BiuTl_JPEG%2Fn_91n1R0WvHr9qEkb1cEJCwT.jpg',
    `cafeImgUrl4` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200515_108%2F15894690909220XG8z_JPEG%2FB-X1Nx_lxdbcpj3IqbPcKqlJ.jpg',
    `cafeImgUrl5` = 'https://search.pstatic.net/common/?autoRotate=true&type=w278_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200515_275%2F1589469090889AcDTR_JPEG%2F7eAg_nDEb_0OoCpmkHIJrq3b.jpg';

# 카페 테스트 데이터 24 (유성구)
INSERT INTO cafe 
SET 
    regDate = '2024-03-20 00:30:53',
    updateDate = '2024-03-20 00:30:53',
    `name` = 'Leafful',
    `address` = '대전 유성구 죽동로279번길 40 1층',
    `businessHours` = '수 11:00 - 21:00; 목 11:00 - 21:00; 금 11:00 - 21:00; 토 11:00 - 21:00; 일 11:00 - 21:00; 월 11:00 - 21:00; 화 정기휴무 (매주 화요일);',
    `phoneNum` = '0507-1444-0411',
    `hashtag` = '#아늑한 #내추럴 #클래식 #대화 #데이트',
    `cafeImgUrl1` = 'https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231114_26%2F16999166507384AfL5_JPEG%2FA952455B-BAC9-41F9-9AB7-7BA65AC82402.jpeg',
    `cafeImgUrl2` = 'https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231114_152%2F1699916651070gTFLW_JPEG%2F5278BB16-5719-45BE-A7DF-07F714861E2E.jpeg',
    `cafeImgUrl3` = 'https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231114_264%2F1699916651214qWWK2_JPEG%2FD11FFE13-2114-4863-9EC1-43CCAD8D0D97.jpeg',
    `cafeImgUrl4` = 'https://search.pstatic.net/common/?src=https%3A%2F%2Fpup-review-phinf.pstatic.net%2FMjAyNDAzMDVfMjI4%2FMDAxNzA5NjEzMTU4NzY5.EcYMnWs4ozzfgkuO-HkNcBgr-XDhN4iZfrT5Ex99tekg.JlQSRZvWNjVR3_AIsIhKDLqazQjzKA5knYm2k1fjsF8g.JPEG%2F20240304_114532.jpg.jpg',
    `cafeImgUrl5` = 'https://search.pstatic.net/common/?src=https%3A%2F%2Fpup-review-phinf.pstatic.net%2FMjAyNDAzMTBfMjk4%2FMDAxNzEwMDUyODQ4MDE3.Pbw5oth-2208ZOsXex3N88luShsdRLvfs--L-YkUqXwg._RN9PbL_IA4Sv-kFPfDP8yA1eofqxQ8j8W1-aOaY1mIg.JPEG%2F8B6CFFF3-FF13-47AD-B547-3D00B830E8A6.jpeg';


CREATE TABLE cafeReview (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    cafeId INT(10) NOT NULL COMMENT '관련 데이터 번호',
    `body`TEXT NOT NULL
);


# update join -> 기존 cafe의 reviewCount 값을 CafeReview(CR) 테이블에서 가져온 데이터로 채운다
UPDATE cafe AS C
INNER JOIN (
    SELECT CR.cafeId, COUNT(CR.cafeId) AS cafeReviewCount
    FROM cafeReview AS CR
    GROUP BY CR.cafeId
) AS CR_COUNT
ON C.id = CR_COUNT.cafeId
SET C.reviewCount = CR_COUNT.cafeReviewCount;




# 2번 회원이 24번 카페에 리뷰 작성
INSERT INTO cafeReview
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
cafeId = 24,
`body` = '분위기가 너무 좋아요';

# 2번 회원이 24번 카페에 리뷰 작성
INSERT INTO cafeReview
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
cafeId = 24,
`body` = '단골이에요';

# 3번 회원이 24번 카페에 리뷰 작성
INSERT INTO cafeReview
SET regDate = NOW(),
updateDate = NOW(),
memberId = 3,
cafeId = 24,
`body` = '커피맛이 좋아요';



CREATE TABLE cafeScrap
(   id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `regDate` DATETIME NOT NULL COMMENT '찜 날짜', 
    `updateDate` DATETIME NOT NULL,
    `deleteDate` DATETIME NULL COMMENT '찜 취소 날짜', 
    `memberId` INT(10) UNSIGNED NOT NULL COMMENT '회원 번호', 
    `cafeId` INT(10) UNSIGNED NOT NULL  COMMENT '카페 번호', 
    `scrap` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '찜 상태 찜 여부 (0=찜 취소, 1= 찜)'
);

# 2번 회원이 24번 카페에 찜(스크랩)
INSERT INTO cafeScrap
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
cafeId = 24,
`scrap` = 1;

# 2번 회원이 23번 카페에 찜(스크랩)
INSERT INTO cafeScrap
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
cafeId = 23,
`scrap` = 1;

# 1번 회원이 19번 카페에 찜(스크랩)
INSERT INTO cafeScrap
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
cafeId = 19,
`scrap` = 1;

# 2번 회원이 19번 카페에 찜(스크랩)
INSERT INTO cafeScrap
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
cafeId = 22,
`scrap` = 1;

# 1번 회원이 19번 카페에 찜(스크랩)
INSERT INTO cafeScrap
SET regDate = NOW(),
updateDate = NOW(),
memberId = 3,
cafeId = 19,
`scrap` = 1;


# update join -> 기존 카페의 scrapCount 값을 cafeScrap 테이블에서 가져온 데이터로 채운다
UPDATE cafe AS C
INNER JOIN (
    SELECT CS.cafeId,
    SUM(IF(CS.scrap > 0, CS.scrap, 0)) AS scrapCount
    FROM cafeScrap AS CS
    GROUP BY CS.cafeId
) AS CS_SUM
ON C.id = CS_SUM.cafeId
SET C.cafeScrapCount = CS_SUM.scrapCount;



###############################################

SELECT * FROM article;

DESC article;

SELECT * FROM `member`;

SELECT * FROM `board`;

SELECT * FROM reactionPoint;

SELECT * FROM `reply`;

SELECT * FROM cafe;

DESC cafe;

SELECT * FROM cafeReview;

SELECT * FROM cafeScrap;


SELECT * 
FROM cafe 
ORDER BY RAND() 
LIMIT 1;


SELECT COUNT(*)
FROM cafeScrap 
WHERE memberId = 2;

SELECT COUNT(*)
FROM `article` 
WHERE (boardId = 1 OR boardId = 2)
AND memberId = 2;

SELECT COUNT(*)
FROM `reply` 
WHERE relTypeCode = 'article'
AND memberId = 2;

SELECT COUNT(*)
FROM `article` 
WHERE boardId = 3
AND memberId = 2;



INNER JOIN `member` AS M
ON CR.memberId = M.id
WHERE cafeId = 10



SELECT * 
FROM cafe 
WHERE cafeScrapCount = (SELECT MAX(cafeScrapCount) FROM cafe);


SELECT * 
FROM cafe 
WHERE hashtag LIKE CONCAT('%', '아늑한', '%')
ORDER BY RAND() 
LIMIT 1;




SELECT IFNULL(SUM(CS.scrap),0)
	FROM cafeScrap AS CS
	WHERE CS.cafeId = 24
	AND CS.memberId = 2;



SELECT CR.*, M.nickname AS extra__writer
    FROM cafeReview AS CR
    INNER JOIN `member` AS M
    ON CR.memberId = M.id
    WHERE cafeId = 10
    ORDER BY CR.id ASC;


SELECT goodReactionPoint
FROM article 
WHERE id = 1

INSERT INTO article
(
    regDate, updateDate, memberId, boardId, title, `body`
)
SELECT NOW(),NOW(), FLOOR(RAND() * 2) + 2, FLOOR(RAND() * 3) + 1, CONCAT('제목_',RAND()), CONCAT('내용_',RAND())
FROM article;

SELECT IFNULL(SUM(RP.point),0)
FROM reactionPoint AS RP
WHERE RP.relTypeCode = 'article'
AND RP.relId = 3
AND RP.memberId = 1;


UPDATE article 
SET title = '제목5'
WHERE id = 5;

UPDATE article 
SET title = '제목11'
WHERE id = 6;

UPDATE article 
SET title = '제목45'
WHERE id = 7;

SELECT FLOOR(RAND() * 2) + 2

SELECT FLOOR(RAND() * 3) + 1


SHOW FULL COLUMNS FROM `member`;
DESC `member`;



SELECT LAST_INSERT_ID();

SELECT *
FROM article AS A
WHERE 1

	AND boardId = 1

			AND A.title LIKE CONCAT('%','0000','%')
			OR A.body LIKE CONCAT('%','0000','%')

ORDER BY id DESC

SELECT COUNT(*)
FROM article AS A
WHERE 1
AND boardId = 1
AND A.title LIKE CONCAT('%','0000','%')
OR A.body LIKE CONCAT('%','0000','%')
ORDER BY id DESC


SELECT hitCount
FROM article
WHERE id = 374;

SELECT A.*
FROM article AS A
WHERE A.id = 1

SELECT A.*, M.nickname AS extra__writer
FROM article AS A
INNER JOIN `member` AS M
ON A.memberId = M.id
WHERE A.id = 1

# LEFT JOIN
SELECT A.*, M.nickname AS extra__writer, RP.point
FROM article AS A
INNER JOIN `member` AS M
ON A.memberId = M.id
LEFT JOIN reactionPoint AS RP
ON A.id = RP.relId AND RP.relTypeCode = 'article'
GROUP BY A.id
ORDER BY A.id DESC;

# 서브쿼리
SELECT A.*,
IFNULL(SUM(RP.point),0) AS extra__sumReactionPoint,
IFNULL(SUM(IF(RP.point > 0, RP.point, 0)),0) AS extra__goodReactionPoint,
IFNULL(SUM(IF(RP.point < 0, RP.point, 0)),0) AS extra__badReactionPoint
FROM (
    SELECT A.*, M.nickname AS extra__writer 
    FROM article AS A
    INNER JOIN `member` AS M
    ON A.memberId = M.id
    ) AS A
LEFT JOIN reactionPoint AS RP
ON A.id = RP.relId AND RP.relTypeCode = 'article'
GROUP BY A.id
ORDER BY A.id DESC;

# 조인
SELECT A.*, M.nickname AS extra__writer,
IFNULL(SUM(RP.point),0) AS extra__sumReactionPoint,
IFNULL(SUM(IF(RP.point > 0, RP.point, 0)),0) AS extra__goodReactionPoint,
IFNULL(SUM(IF(RP.point < 0, RP.point, 0)),0) AS extra__badReactionPoint
FROM article AS A
INNER JOIN `member` AS M
ON A.memberId = M.id
LEFT JOIN reactionPoint AS RP
ON A.id = RP.relId AND RP.relTypeCode = 'article'
GROUP BY A.id
ORDER BY A.id DESC;


SELECT *, COUNT(*)
FROM reactionPoint AS RP
GROUP BY RP.relTypeCode,RP.relId

SELECT IF(RP.point > 0, '큼','작음')
FROM reactionPoint AS RP
GROUP BY RP.relTypeCode,RP.relId

# 각 게시물의 좋아요, 싫어요 갯수
SELECT RP.relTypeCode, RP.relId,
SUM(IF(RP.point > 0,RP.point,0)) AS goodReactionPoint,
SUM(IF(RP.point < 0,RP.point * -1,0)) AS badReactionPoint
FROM reactionPoint AS RP
GROUP BY RP.relTypeCode,RP.relId