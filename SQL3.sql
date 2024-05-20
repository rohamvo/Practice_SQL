/*
각 분기(QUARTER)별 분화된 대장균의 개체의 총 수(ECOLI_COUNT)를 출력하는 SQL 문을 작성해주세요. 
이때 각 분기에는 'Q' 를 붙이고 분기에 대해 오름차순으로 정렬해주세요. 
대장균 개체가 분화되지 않은 분기는 없습니다.
*/

SELECT CASE
WHEN MONTH(DIFFERENTIATION_DATE) < 4 THEN '1Q'
WHEN MONTH(DIFFERENTIATION_DATE) < 7 THEN '2Q'
WHEN MONTH(DIFFERENTIATION_DATE) < 10 THEN '3Q'
ELSE '4Q' END AS QUARTER, COUNT(*) AS ECOLI_COUNT
FROM ECOLI_DATA
GROUP BY QUARTER ORDER BY QUARTER;

/*
SUBWAY_DISTANCE 테이블에서 노선별로 노선, 총 누계 거리, 평균 역 사이 거리를 노선별로 조회하는 SQL문을 작성해주세요.

총 누계거리는 테이블 내 존재하는 역들의 역 사이 거리의 총 합을 뜻합니다. 
총 누계 거리와 평균 역 사이 거리의 컬럼명은 각각 TOTAL_DISTANCE, AVERAGE_DISTANCE로 해주시고, 총 누계거리는 소수 둘째자리에서, 평균 역 사이 거리는 소수 셋째 자리에서 반올림 한 뒤 단위(km)를 함께 출력해주세요.
결과는 총 누계 거리를 기준으로 내림차순 정렬해주세요.
*/
SELECT ROUTE, 
CONCAT(ROUND(SUM(D_BETWEEN_DIST),1), 'km') AS TOTAL_DISTANCE, 
CONCAT(ROUND(AVG(D_BETWEEN_DIST),2), 'km') AS AVERAGE_DISTANCE
FROM SUBWAY_DISTANCE 
GROUP BY ROUTE
ORDER BY ROUND(SUM(D_BETWEEN_DIST),2) DESC;

/*
FISH_NAME_INFO에서 물고기의 종류 별 물고기의 이름과 잡은 수를 출력하는 SQL문을 작성해주세요.

물고기의 이름 컬럼명은 FISH_NAME, 잡은 수 컬럼명은 FISH_COUNT로 해주세요.
결과는 잡은 수 기준으로 내림차순 정렬해주세요.
*/
SELECT COUNT(*) AS FISH_COUNT, FISH_NAME 
FROM FISH_INFO A 
LEFT JOIN FISH_NAME_INFO B ON A.FISH_TYPE = B.FISH_TYPE 
GROUP BY FISH_NAME ORDER BY FISH_COUNT DESC;

/*
월별 잡은 물고기의 수와 월을 출력하는 SQL문을 작성해주세요.

잡은 물고기 수 컬럼명은 FISH_COUNT, 월 컬럼명은 MONTH로 해주세요.
결과는 월을 기준으로 오름차순 정렬해주세요.
단, 월은 숫자형태 (1~12) 로 출력하며 9 이하의 숫자는 두 자리로 출력하지 않습니다. 
잡은 물고기가 없는 월은 출력하지 않습니다.
*/
SELECT COUNT(*) AS FISH_COUNT, MONTH(TIME) AS MONTH 
FROM FISH_INFO 
GROUP BY MONTH(TIME) ORDER BY MONTH;

/*
FISH_INFO 테이블에서 잡은 BASS와 SNAPPER의 수를 출력하는 SQL 문을 작성해주세요.

컬럼명은 'FISH_COUNT`로 해주세요.
*/
SELECT COUNT(*) AS FISH_COUNT
FROM FISH_INFO AS FI
LEFT JOIN FISH_NAME_INFO AS FNI ON FI.FISH_TYPE = FNI.FISH_TYPE
WHERE FNI.FISH_NAME = 'BASS' OR FNI.FISH_NAME = 'SNAPPER';

/*
ROOT 아이템을 찾아 아이템 ID(ITEM_ID), 아이템 명(ITEM_NAME)을 출력하는 SQL문을 작성해 주세요. 
이때, 결과는 아이템 ID를 기준으로 오름차순 정렬해 주세요.
*/
SELECT I.ITEM_ID, I.ITEM_NAME 
FROM ITEM_INFO I LEFT JOIN ITEM_TREE T ON I.ITEM_ID = T.ITEM_ID
WHERE PARENT_ITEM_ID IS NULL
ORDER BY I.ITEM_ID;

/*
ITEM_INFO 테이블에서 희귀도가 'LEGEND'인 아이템들의 가격의 총합을 구하는 SQL문을 작성해 주세요. 
이때 컬럼명은 'TOTAL_PRICE'로 지정해 주세요.
*/
SELECT SUM(PRICE) AS TOTAL_PRICE 
FROM ITEM_INFO 
WHERE RARITY = 'LEGEND';

/*
ONLINE_SALE 테이블에서 동일한 회원이 동일한 상품을 재구매한 데이터를 구하여, 재구매한 회원 ID와 재구매한 상품 ID를 출력하는 SQL문을 작성해주세요. 
결과는 회원 ID를 기준으로 오름차순 정렬해주시고 회원 ID가 같다면 상품 ID를 기준으로 내림차순 정렬해주세요.
*/
SELECT USER_ID, PRODUCT_ID 
FROM ONLINE_SALE 
GROUP BY USER_ID, PRODUCT_ID 
HAVING COUNT(PRODUCT_ID) > 1 
ORDER BY 1,2 DESC;

/*
PRODUCT 테이블과 OFFLINE_SALE 테이블에서 상품코드 별 매출액(판매가 * 판매량) 합계를 출력하는 SQL문을 작성해주세요. 
결과는 매출액을 기준으로 내림차순 정렬해주시고 매출액이 같다면 상품코드를 기준으로 오름차순 정렬해주세요.
*/
SELECT P.PRODUCT_CODE, P.PRICE * S.SALES_AMOUNT AS SALES
FROM PRODUCT P 
JOIN 
(SELECT PRODUCT_ID, SUM(SALES_AMOUNT) AS SALES_AMOUNT 
 FROM OFFLINE_SALE GROUP BY PRODUCT_ID) AS S
 ON P.PRODUCT_ID = S.PRODUCT_ID
ORDER BY SALES DESC, PRODUCT_CODE;

/*
MEMBER_PROFILE 테이블에서 생일이 3월인 여성 회원의 ID, 이름, 성별, 생년월일을 조회하는 SQL문을 작성해주세요. 
이때 전화번호가 NULL인 경우는 출력대상에서 제외시켜 주시고, 결과는 회원ID를 기준으로 오름차순 정렬해주세요.
*/
SELECT MEMBER_ID, MEMBER_NAME, GENDER, 
DATE_FORMAT(DATE_OF_BIRTH, '%Y-%m-%d') AS DATE_OF_BIRTH
FROM MEMBER_PROFILE
WHERE DATE_OF_BIRTH LIKE '%03%' AND GENDER = 'W' AND TLNO IS NOT NULL;

/*
FOOD_PRODUCT 테이블에서 가격이 제일 비싼 식품의 식품 ID, 식품 이름, 식품 코드, 식품분류, 식품 가격을 조회하는 SQL문을 작성해주세요.
*/
SELECT * 
FROM FOOD_PRODUCT 
ORDER BY PRICE DESC LIMIT 1;

/*
보호소에서는 몇 시에 입양이 가장 활발하게 일어나는지 알아보려 합니다. 09:00부터 19:59까지, 각 시간대별로 입양이 몇 건이나 발생했는지 조회하는 SQL문을 작성해주세요. 
이때 결과는 시간대 순으로 정렬해야 합니다.
*/
SELECT HOUR(DATETIME) AS HOUR, COUNT(*) AS 'COUNT' 
FROM ANIMAL_OUTS
WHERE HOUR(DATETIME) BETWEEN 9 AND 19
GROUP BY HOUR(DATETIME) ORDER BY HOUR;

/*
마지막 줄의 개는 이름이 없기 때문에, 이 개의 이름은 "No name"으로 표시합니다. 따라서 SQL문을 실행하면 다음과 같이 나와야 합니다.
*/
SELECT ANIMAL_TYPE, IFNULL(NAME, 'No name'), SEX_UPON_INTAKE 
FROM ANIMAL_INS;

/*
보호소에 들어온 동물의 이름은 NULL(없음), *Sam, *Sam, *Sweetie입니다. 이 중 NULL과 중복되는 이름을 고려하면, 보호소에 들어온 동물 이름의 수는 2입니다. 따라서 SQL문을 실행하면 다음과 같이 나와야 합니다.
*/
SELECT COUNT(DISTINCT NAME) FROM ANIMAL_INS;

