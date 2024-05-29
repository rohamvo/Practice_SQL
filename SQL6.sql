/*
분화된 연도(YEAR), 분화된 연도별 대장균 크기의 편차(YEAR_DEV), 대장균 개체의 ID(ID) 를 출력하는 SQL 문을 작성해주세요. 
분화된 연도별 대장균 크기의 편차는 분화된 연도별 가장 큰 대장균의 크기 - 각 대장균의 크기로 구하며 결과는 연도에 대해 오름차순으로 정렬하고 같은 연도에 대해서는 대장균 크기의 편차에 대해 오름차순으로 정렬해주세요.
*/
SELECT YEAR(DIFFERENTIATION_DATE) AS YEAR, 
(SELECT MAX(SIZE_OF_COLONY) FROM ECOLI_DATA WHERE YEAR(DIFFERENTIATION_DATE) = YEAR) - SIZE_OF_COLONY AS YEAR_DEV, ID 
FROM ECOLI_DATA
ORDER BY YEAR, YEAR_DEV;

/*
USER_INFO 테이블과 ONLINE_SALE 테이블에서 2021년에 가입한 전체 회원들 중 상품을 구매한 회원수와 상품을 구매한 회원의 비율(=2021년에 가입한 회원 중 상품을 구매한 회원수 / 2021년에 가입한 전체 회원 수)을 년, 월 별로 출력하는 SQL문을 작성해주세요. 
상품을 구매한 회원의 비율은 소수점 두번째자리에서 반올림하고, 전체 결과는 년을 기준으로 오름차순 정렬해주시고 년이 같다면 월을 기준으로 오름차순 정렬해주세요.
*/
SET @T= (select count(DISTINCT USER_ID) from USER_INFO where YEAR(JOINED) = 2021);

SELECT YEAR(SALES_DATE) AS YEAR, MONTH(SALES_DATE) AS MONTH, 
COUNT(DISTINCT I.USER_ID) AS PURCHASED_UESRS, ROUND(COUNT(DISTINCT I.USER_ID) / @T,1) AS PURCHASED_RATIO
FROM ONLINE_SALE S
LEFT JOIN (SELECT USER_ID FROM USER_INFO WHERE JOINED LIKE '2021%') AS I
ON I.USER_ID = S.USER_ID
WHERE I.USER_ID IS NOT NULL
GROUP BY YEAR(SALES_DATE), MONTH(SALES_DATE)
ORDER BY YEAR, MONTH;