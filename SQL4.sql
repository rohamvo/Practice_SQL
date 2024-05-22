/*
동물 보호소에 들어온 동물 이름 중, 이름에 "EL"이 들어가는 개의 아이디와 이름을 조회하는 SQL문을 작성해주세요. 
이때 결과는 이름 순으로 조회해주세요. 단, 이름의 대소문자는 구분하지 않습니다.
*/
SELECT ANIMAL_ID, NAME 
FROM ANIMAL_INS
WHERE NAME LIKE '%EL%' AND ANIMAL_TYPE = 'DOG'
ORDER BY NAME;

/*
동물 보호소에 들어온 동물 중 이름이 Lucy, Ella, Pickle, Rogan, Sabrina, Mitty인 동물의 아이디와 이름, 성별 및 중성화 여부를 조회하는 SQL 문을 작성해주세요.
*/
SELECT ANIMAL_ID, NAME, SEX_UPON_INTAKE
FROM ANIMAL_INS
WHERE NAME IN ('LUCY', 'ELLA', 'PICKLE', 'ROGAN', 'SABRINA', 'MITTY')
ORDER BY ANIMAL_ID;

/*
동물 보호소에 들어온 동물 이름 중 두 번 이상 쓰인 이름과 해당 이름이 쓰인 횟수를 조회하는 SQL문을 작성해주세요. 이때 결과는 이름이 없는 동물은 집계에서 제외하며, 결과는 이름 순으로 조회해주세요.
*/
SELECT NAME, COUNT(*) AS COUNT
FROM ANIMAL_INS
WHERE NAME IS NOT NULL
GROUP BY NAME
HAVING COUNT(*) >= 2
ORDER BY NAME;

/*
동물 보호소에 들어온 동물 중 고양이와 개가 각각 몇 마리인지 조회하는 SQL문을 작성해주세요. 이때 고양이를 개보다 먼저 조회해주세요.
*/
SELECT ANIMAL_TYPE, COUNT(*) AS COUNT
FROM ANIMAL_INS
GROUP BY ANIMAL_TYPE
ORDER BY ANIMAL_TYPE;

/*
보호소의 동물이 중성화되었는지 아닌지 파악하려 합니다. 중성화된 동물은 SEX_UPON_INTAKE 컬럼에 'Neutered' 또는 'Spayed'라는 단어가 들어있습니다. 
동물의 아이디와 이름, 중성화 여부를 아이디 순으로 조회하는 SQL문을 작성해주세요. 이때 중성화가 되어있다면 'O', 아니라면 'X'라고 표시해주세요.
*/
SELECT ANIMAL_ID, NAME, CASE
WHEN SEX_UPON_INTAKE LIKE '%NEUTERED%' OR SEX_UPON_INTAKE LIKE '%SPAYED%' THEN 'O'
ELSE 'X'
END AS '중성화'
FROM ANIMAL_INS
ORDER BY ANIMAL_ID;

/*
ANIMAL_INS 테이블에 등록된 모든 레코드에 대해, 각 동물의 아이디와 이름, 들어온 날짜1를 조회하는 SQL문을 작성해주세요. 이때 결과는 아이디 순으로 조회해야 합니다.
*/
SELECT ANIMAL_ID, NAME, DATE_FORMAT(DATETIME, '%Y-%m-%d') AS '날짜'
FROM ANIMAL_INS
ORDER BY ANIMAL_ID;

/*
PRODUCT 테이블에서 상품 카테고리 코드(PRODUCT_CODE 앞 2자리) 별 상품 개수를 출력하는 SQL문을 작성해주세요. 결과는 상품 카테고리 코드를 기준으로 오름차순 정렬해주세요.
*/
SELECT CATEGORY, COUNT(*) PRODUCTS
FROM(SELECT *, SUBSTRING(PRODUCT_CODE, 1, 2) AS CATEGORY FROM PRODUCT) AS CA
GROUP BY CATEGORY
ORDER BY CATEGORY;

/*
PRODUCT 테이블에서 만원 단위의 가격대 별로 상품 개수를 출력하는 SQL 문을 작성해주세요. 
이때 컬럼명은 각각 컬럼명은 PRICE_GROUP, PRODUCTS로 지정해주시고 가격대 정보는 각 구간의 최소금액(10,000원 이상 ~ 20,000 미만인 구간인 경우 10,000)으로 표시해주세요. 
결과는 가격대를 기준으로 오름차순 정렬해주세요.
*/
SELECT PRICE_GROUP, COUNT(*) AS PRODUCTS
FROM (SELECT *, LEFT(PRICE, 1) * 10000 AS PRICE_GROUP FROM PRODUCT) AS PG
GROUP BY PRICE_GROUP
ORDER BY PRICE_GROUP;

/*
APPOINTMENT 테이블에서 2022년 5월에 예약한 환자 수를 진료과코드 별로 조회하는 SQL문을 작성해주세요. 
이때, 컬럼명은 '진료과 코드', '5월예약건수'로 지정해주시고 결과는 진료과별 예약한 환자 수를 기준으로 오름차순 정렬하고, 예약한 환자 수가 같다면 진료과 코드를 기준으로 오름차순 정렬해주세요.
*/
SELECT MCDP_CD AS '진료과코드', COUNT(*) AS '5월예약건수'
FROM APPOINTMENT
WHERE MONTH(APNT_YMD) = 5 
GROUP BY MCDP_CD
ORDER BY 5월예약건수 ASC, 진료과코드 ASC;

/*
상반기 동안 각 아이스크림 성분 타입과 성분 타입에 대한 아이스크림의 총주문량을 총주문량이 작은 순서대로 조회하는 SQL 문을 작성해주세요. 
이때 총주문량을 나타내는 컬럼명은 TOTAL_ORDER로 지정해주세요.
*/
SELECT ICE.INGREDIENT_TYPE, SUM(FH.TOTAL_ORDER) AS TOTAL_ORDER
FROM FIRST_HALF AS FH
LEFT JOIN ICECREAM_INFO AS ICE ON FH.FLAVOR = ICE.FLAVOR
GROUP BY INGREDIENT_TYPE
ORDER BY TOTAL_ORDER;

/*
'경제' 카테고리에 속하는 도서들의 도서 ID(BOOK_ID), 저자명(AUTHOR_NAME), 출판일(PUBLISHED_DATE) 리스트를 출력하는 SQL문을 작성해주세요.
결과는 출판일을 기준으로 오름차순 정렬해주세요.
*/
SELECT B.BOOK_ID, A.AUTHOR_NAME, DATE_FORMAT(B.PUBLISHED_DATE, '%Y-%m-%d') AS PUBLISHED_DATE
FROM BOOK AS B
JOIN AUTHOR AS A ON B.AUTHOR_ID = A.AUTHOR_ID
WHERE B.CATEGORY = '경제'
ORDER BY PUBLISHED_DATE;

/*
CAR_RENTAL_COMPANY_CAR 테이블에서 '통풍시트', '열선시트', '가죽시트' 중 하나 이상의 옵션이 포함된 자동차가 자동차 종류 별로 몇 대인지 출력하는 SQL문을 작성해주세요. 
이때 자동차 수에 대한 컬럼명은 CARS로 지정하고, 결과는 자동차 종류를 기준으로 오름차순 정렬해주세요.
*/
SELECT CAR_TYPE, COUNT(*) AS CARS
FROM CAR_RENTAL_COMPANY_CAR
WHERE OPTIONS LIKE '%시트%'
GROUP BY CAR_TYPE
ORDER BY CAR_TYPE;

/*
CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 평균 대여 기간이 7일 이상인 자동차들의 자동차 ID와 평균 대여 기간(컬럼명: AVERAGE_DURATION) 리스트를 출력하는 SQL문을 작성해주세요. 
평균 대여 기간은 소수점 두번째 자리에서 반올림하고, 결과는 평균 대여 기간을 기준으로 내림차순 정렬해주시고, 평균 대여 기간이 같으면 자동차 ID를 기준으로 내림차순 정렬해주세요.
*/
SELECT D.CAR_ID, ROUND(AVG(DIFF),1) AS AVERAGE_DURATION
FROM (SELECT CAR_ID, DATEDIFF(END_DATE, START_DATE)+1 AS DIFF FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY) AS D
GROUP BY CAR_ID
HAVING AVG(DIFF) >= 7
ORDER BY AVERAGE_DURATION DESC, CAR_ID DESC;

/*
USED_GOODS_BOARD 테이블에서 2022년 10월 5일에 등록된 중고거래 게시물의 게시글 ID, 작성자 ID, 게시글 제목, 가격, 거래상태를 조회하는 SQL문을 작성해주세요. 
거래상태가 SALE 이면 판매중, RESERVED이면 예약중, DONE이면 거래완료 분류하여 출력해주시고, 결과는 게시글 ID를 기준으로 내림차순 정렬해주세요.
*/
SELECT BOARD_ID, WRITER_ID, TITLE, PRICE,
CASE WHEN STATUS = 'SALE' THEN '판매중'
WHEN STATUS = 'RESERVED' THEN '예약중'
WHEN STATUS = 'DONE' THEN '거래완료'
END AS STATUS
FROM USED_GOODS_BOARD
WHERE CREATED_DATE = '2022-10-05'
ORDER BY BOARD_ID DESC;

