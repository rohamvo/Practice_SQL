/*
CAR_RENTAL_COMPANY_CAR 테이블과 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 자동차 종류가 '세단'인 자동차들 중 10월에 대여를 시작한 기록이 있는 자동차 ID 리스트를 출력하는 SQL문을 작성해주세요. 
자동차 ID 리스트는 중복이 없어야 하며, 자동차 ID를 기준으로 내림차순 정렬해주세요.
*/
SELECT DISTINCT(H.CAR_ID)
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY AS H
LEFT JOIN CAR_RENTAL_COMPANY_CAR AS C ON H.CAR_ID = C.CAR_ID 
WHERE MONTH(START_DATE) = 10 AND CAR_TYPE = '세단'
ORDER BY CAR_ID DESC;

/*
USED_GOODS_BOARD와 USED_GOODS_USER 테이블에서 완료된 중고 거래의 총금액이 70만 원 이상인 사람의 회원 ID, 닉네임, 총거래금액을 조회하는 SQL문을 작성해주세요. 
결과는 총거래금액을 기준으로 오름차순 정렬해주세요.
*/
SELECT USER_ID, NICKNAME, TOTAL_SALES
FROM USED_GOODS_USER AS U JOIN
(SELECT WRITER_ID, SUM(PRICE) AS TOTAL_SALES
FROM USED_GOODS_BOARD
WHERE STATUS = 'DONE'
GROUP BY WRITER_ID) AS D
ON U.USER_ID = D.WRITER_ID
WHERE TOTAL_SALES >= 700000
ORDER BY TOTAL_SALES;

/*
USED_GOODS_BOARD와 USED_GOODS_USER 테이블에서 중고 거래 게시물을 3건 이상 등록한 사용자의 사용자 ID, 닉네임, 전체주소, 전화번호를 조회하는 SQL문을 작성해주세요. 
이때, 전체 주소는 시, 도로명 주소, 상세 주소가 함께 출력되도록 해주시고, 전화번호의 경우 xxx-xxxx-xxxx 같은 형태로 하이픈 문자열(-)을 삽입하여 출력해주세요. 
결과는 회원 ID를 기준으로 내림차순 정렬해주세요.
*/
SELECT USER_ID, NICKNAME, 
CONCAT_WS(' ', CITY, STREET_ADDRESS1, STREET_ADDRESS2) AS '전체주소',
CONCAT(SUBSTR(TLNO, 1, 3), '-', SUBSTR(TLNO, 4, 4), '-', SUBSTR(TLNO, 8, 4)) AS '전화번호'
FROM (SELECT WRITER_ID
FROM USED_GOODS_BOARD
GROUP BY WRITER_ID
HAVING COUNT(*) >= 3) AS W 
JOIN USED_GOODS_USER AS U ON W.WRITER_ID = U.USER_ID
ORDER BY USER_ID DESC;

/*
USED_GOODS_BOARD와 USED_GOODS_FILE 테이블에서 조회수가 가장 높은 중고거래 게시물에 대한 첨부파일 경로를 조회하는 SQL문을 작성해주세요. 
첨부파일 경로는 FILE ID를 기준으로 내림차순 정렬해주세요. 
기본적인 파일경로는 /home/grep/src/ 이며, 게시글 ID를 기준으로 디렉토리가 구분되고, 파일이름은 파일 ID, 파일 이름, 파일 확장자로 구성되도록 출력해주세요. 
조회수가 가장 높은 게시물은 하나만 존재합니다.
*/
SELECT CONCAT(CONCAT_WS('/', '/home/grep/src', F.BOARD_ID, F.FILE_ID), F.FILE_NAME, F.FILE_EXT) AS FILE_PATH
FROM (SELECT BOARD_ID
FROM USED_GOODS_BOARD
ORDER BY VIEWS DESC LIMIT 1) AS B
JOIN USED_GOODS_FILE AS F ON B.BOARD_ID = F.BOARD_ID
ORDER BY F.FILE_ID DESC;

/*
더 이상 업그레이드할 수 없는 아이템의 아이템 ID(ITEM_ID), 아이템 명(ITEM_NAME), 아이템의 희귀도(RARITY)를 출력하는 SQL 문을 작성해 주세요. 
이때 결과는 아이템 ID를 기준으로 내림차순 정렬해 주세요.
*/
SELECT I.ITEM_ID, I.ITEM_NAME, I.RARITY
FROM ITEM_INFO AS I
LEFT JOIN ITEM_TREE AS T
ON I.ITEM_ID = T.PARENT_ITEM_ID
WHERE PARENT_ITEM_ID IS NULL
ORDER BY ITEM_ID DESC;

