/*
부모의 형질을 모두 보유한 대장균의 ID(ID), 대장균의 형질(GENOTYPE), 부모 대장균의 형질(PARENT_GENOTYPE)을 출력하는 SQL 문을 작성해주세요. 
이때 결과는 ID에 대해 오름차순 정렬해주세요.
*/
SELECT S.ID, S.GENOTYPE AS GENOTYPE, P.GENOTYPE AS PARENT_GENOTYPE
FROM ECOLI_DATA AS S 
JOIN (SELECT ID, GENOTYPE FROM ECOLI_DATA) AS P
ON S.PARENT_ID = P.ID
WHERE (S.GENOTYPE & P.GENOTYPE) = P.GENOTYPE
ORDER BY ID;

/*
입양을 간 동물 중, 보호 기간이 가장 길었던 동물 두 마리의 아이디와 이름을 조회하는 SQL문을 작성해주세요. 
이때 결과는 보호 기간이 긴 순으로 조회해야 합니다.
*/
SELECT AI.ANIMAL_ID, AI.NAME
FROM ANIMAL_INS AS AI JOIN ANIMAL_OUTS AS AO ON AI.ANIMAL_ID = AO.ANIMAL_ID
ORDER BY DATEDIFF(AO.DATETIME, AI.DATETIME) DESC LIMIT 2;

/*
이 서비스에서는 공간을 둘 이상 등록한 사람을 "헤비 유저"라고 부릅니다. 
헤비 유저가 등록한 공간의 정보를 아이디 순으로 조회하는 SQL문을 작성해주세요.
*/
SELECT *
FROM PLACES
WHERE HOST_ID IN (SELECT HOST_ID FROM PLACES GROUP BY HOST_ID HAVING COUNT(HOST_ID) > 1)
ORDER BY ID;

/*
FOOD_ORDER 테이블에서 5월 1일을 기준으로 주문 ID, 제품 ID, 출고일자, 출고여부를 조회하는 SQL문을 작성해주세요. 
출고여부는 5월 1일까지 출고완료로 이 후 날짜는 출고 대기로 미정이면 출고미정으로 출력해주시고, 결과는 주문 ID를 기준으로 오름차순 정렬해주세요.
*/
SELECT ORDER_ID, PRODUCT_ID, DATE_FORMAT(OUT_DATE, '%Y-%m-%d'),
CASE WHEN OUT_DATE > '2022-05-01' THEN '출고대기'
WHEN OUT_DATE IS NULL THEN '출고미정'
ELSE '출고완료'
END AS '출고여부'
FROM FOOD_ORDER
ORDER BY ORDER_ID;

/*
REST_INFO 테이블에서 음식종류별로 즐겨찾기수가 가장 많은 식당의 음식 종류, ID, 식당 이름, 즐겨찾기수를 조회하는 SQL문을 작성해주세요. 
이때 결과는 음식 종류를 기준으로 내림차순 정렬해주세요.
*/
SELECT R.FOOD_TYPE, R.REST_ID, R.REST_NAME, R.FAVORITES
FROM REST_INFO AS R JOIN (SELECT FOOD_TYPE, MAX(FAVORITES) AS MAX_FAVORITES
FROM REST_INFO
GROUP BY FOOD_TYPE) AS M ON R.FOOD_TYPE = M.FOOD_TYPE
WHERE R.FAVORITES = M.MAX_FAVORITES
ORDER BY FOOD_TYPE DESC;

/*
2022년 1월의 카테고리 별 도서 판매량을 합산하고, 카테고리(CATEGORY), 총 판매량(TOTAL_SALES) 리스트를 출력하는 SQL문을 작성해주세요.
결과는 카테고리명을 기준으로 오름차순 정렬해주세요.
*/
SELECT B.CATEGORY, SUM(SALES) AS TOTAL_SALES
FROM BOOK AS B JOIN BOOK_SALES AS S ON B.BOOK_ID = S.BOOK_ID
WHERE YEAR(S.SALES_DATE) = 2022 AND MONTH(S.SALES_DATE) = 1
GROUP BY B.CATEGORY
ORDER BY B.CATEGORY;

/*
CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 대여 시작일을 기준으로 2022년 8월부터 2022년 10월까지 총 대여 횟수가 5회 이상인 자동차들에 대해서 해당 기간 동안의 월별 자동차 ID 별 총 대여 횟수(컬럼명: RECORDS) 리스트를 출력하는 SQL문을 작성해주세요. 
결과는 월을 기준으로 오름차순 정렬하고, 월이 같다면 자동차 ID를 기준으로 내림차순 정렬해주세요. 
특정 월의 총 대여 횟수가 0인 경우에는 결과에서 제외해주세요.
*/
SELECT MONTH(START_DATE) AS MONTH, CAR_ID, COUNT(*) AS RECORDS
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
WHERE START_DATE BETWEEN '2022-08-01' AND '2022-10-31' AND CAR_ID IN (SELECT CAR_ID
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
WHERE START_DATE BETWEEN '2022-08-01' AND '2022-10-31'
GROUP BY CAR_ID
HAVING COUNT(*) >= 5)
GROUP BY MONTH(START_DATE), CAR_ID
HAVING COUNT(*) != 0
ORDER BY MONTH ASC, CAR_ID DESC;

/*
CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 2022년 10월 16일에 대여 중인 자동차인 경우 '대여중' 이라고 표시하고, 대여 중이지 않은 자동차인 경우 '대여 가능'을 표시하는 컬럼(컬럼명: AVAILABILITY)을 추가하여 자동차 ID와 AVAILABILITY 리스트를 출력하는 SQL문을 작성해주세요. 
이때 반납 날짜가 2022년 10월 16일인 경우에도 '대여중'으로 표시해주시고 결과는 자동차 ID를 기준으로 내림차순 정렬해주세요.
*/
SELECT CAR_ID, MAX(AVAILABILITY) AS AVAILABILITY
FROM (SELECT CAR_ID,
CASE WHEN START_DATE <= '2022-10-16' AND END_DATE >= '2022-10-16' THEN '대여중'
ELSE '대여 가능'
END AS AVAILABILITY
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY) AS C
GROUP BY CAR_ID
ORDER BY CAR_ID DESC;
