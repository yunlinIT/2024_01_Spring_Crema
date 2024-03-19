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
    `goodReactionPoint` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '찜수', 
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
`goodReactionPoint` = 1, 
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
`businessHours` = '월 ~ 금 카페&베이커리 11:00 - 20:30 (20:00 라스트오더) / 브런치 11:00 - 17:30 (17:00 라스트오더); 토 ~ 일 카페&베이커리 10:30 - 20:30 (20:00 라스트오더) / 브런치	10:30 - 18:30 (18:00 라스트오더)', 
`phoneNum` = '0507-1380-9522', 
`facilities` = '주차, 남/녀 화장실 구분, 반려동물 동반, 포장, 단체 이용 가능, 무선 인터넷', 
#`goodReactionPoint` = 1, 
#`reviewCount` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '리뷰 수', 
`hashtag` = '#넓은 #뷰맛집 #테라스 #사진맛집 #반려동물', 
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




# 2번 회원이 10번 카페에 리뷰 작성
INSERT INTO cafeReview
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
cafeId = 10,
`body` = '분위기가 너무 좋아요';

# 2번 회원이 10번 카페에 리뷰 작성
INSERT INTO cafeReview
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
cafeId = 10,
`body` = '단골이에요';

# 3번 회원이 10번 카페에 리뷰 작성
INSERT INTO cafeReview
SET regDate = NOW(),
updateDate = NOW(),
memberId = 3,
cafeId = 10,
`body` = '커피맛이 좋아요';





###############################################

SELECT * FROM article;

SELECT * FROM `member`;

SELECT * FROM `board`;

SELECT * FROM reactionPoint;

SELECT * FROM `reply`;

SELECT * FROM cafe;

DESC cafe;

SELECT * FROM cafeReview;

DELETE * FROM cafeReview;




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