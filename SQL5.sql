/*
아이템의 희귀도가 'RARE'인 아이템들의 모든 다음 업그레이드 아이템의 아이템 ID(ITEM_ID), 아이템 명(ITEM_NAME), 아이템의 희귀도(RARITY)를 출력하는 SQL 문을 작성해 주세요. 
이때 결과는 아이템 ID를 기준으로 내림차순 정렬주세요.
*/
SELECT ITEM_ID, ITEM_NAME, RARITY
FROM ITEM_INFO
WHERE ITEM_ID IN(SELECT TREE.ITEM_ID
FROM ITEM_INFO AS INFO
LEFT JOIN ITEM_TREE AS TREE ON INFO.ITEM_ID = TREE.PARENT_ITEM_ID
WHERE RARITY = 'RARE' AND PARENT_ITEM_ID IS NOT NULL)
ORDER BY ITEM_ID DESC;

/*
DEVELOPERS 테이블에서 Python이나 C# 스킬을 가진 개발자의 정보를 조회하려 합니다. 
조건에 맞는 개발자의 ID, 이메일, 이름, 성을 조회하는 SQL 문을 작성해 주세요.

결과는 ID를 기준으로 오름차순 정렬해 주세요.
*/
SELECT DEV.ID, DEV.EMAIL, DEV.FIRST_NAME, DEV.LAST_NAME
FROM DEVELOPERS AS DEV
WHERE EXISTS
(SELECT 1
FROM SKILLCODES AS SKILL
WHERE (DEV.SKILL_CODE & SKILL.CODE) != 0 AND (SKILL.NAME = 'Python' OR SKILL.NAME = 'C#'))
ORDER BY DEV.ID;

/*
HR_DEPARTMENT, HR_EMPLOYEES, HR_GRADE 테이블에서 2022년도 한해 평가 점수가 가장 높은 사원 정보를 조회하려 합니다. 
2022년도 평가 점수가 가장 높은 사원들의 점수, 사번, 성명, 직책, 이메일을 조회하는 SQL문을 작성해주세요.

2022년도의 평가 점수는 상,하반기 점수의 합을 의미하고, 평가 점수를 나타내는 컬럼의 이름은 SCORE로 해주세요.
*/
SELECT G.SCORE, E.EMP_NO, E.EMP_NAME, E.POSITION, E.EMAIL
FROM HR_EMPLOYEES AS E
JOIN (SELECT EMP_NO, SUM(SCORE) AS SCORE FROM HR_GRADE GROUP BY EMP_NO) AS G
ON E.EMP_NO = G.EMP_NO
ORDER BY SCORE DESC LIMIT 1;

/*
AIR_POLLUTION 테이블에서 수원 지역의 연도 별 평균 미세먼지 오염도와 평균 초미세먼지 오염도를 조회하는 SQL문을 작성해주세요. 
이때, 평균 미세먼지 오염도와 평균 초미세먼지 오염도의 컬럼명은 각각 PM10, PM2.5로 해 주시고, 값은 소수 셋째 자리에서 반올림해주세요.
결과는 연도를 기준으로 오름차순 정렬해주세요.
*/
SELECT YEAR(YM) AS YEAR, ROUND(AVG(PM_VAL1),2) AS 'PM10', ROUND(AVG(PM_VAL2),2) AS 'PM2.5'
FROM AIR_POLLUTION
WHERE LOCATION2 = '수원'
GROUP BY YEAR(YM)
ORDER BY YEAR;

/*
HR_DEPARTMENT와 HR_EMPLOYEES 테이블을 이용해 부서별 평균 연봉을 조회하려 합니다. 
부서별로 부서 ID, 영문 부서명, 평균 연봉을 조회하는 SQL문을 작성해주세요.

평균연봉은 소수점 첫째 자리에서 반올림하고 컬럼명은 AVG_SAL로 해주세요.
결과는 부서별 평균 연봉을 기준으로 내림차순 정렬해주세요.
*/
SELECT D.DEPT_ID, D.DEPT_NAME_EN, ROUND(AVG(E.SAL), 0) AS AVG_SAL
FROM HR_EMPLOYEES E 
LEFT JOIN HR_DEPARTMENT D ON E.DEPT_ID = D.DEPT_ID
GROUP BY D.DEPT_ID, D.DEPT_NAME_EN
ORDER BY AVG_SAL DESC;

/*
아직 입양을 못 간 동물 중, 가장 오래 보호소에 있었던 동물 3마리의 이름과 보호 시작일을 조회하는 SQL문을 작성해주세요. 
이때 결과는 보호 시작일 순으로 조회해야 합니다.
*/
SELECT NAME, DATETIME
FROM ANIMAL_INS WHERE ANIMAL_ID NOT IN (SELECT ANIMAL_ID FROM ANIMAL_OUTS)
ORDER BY DATETIME LIMIT 3;

/*
관리자의 실수로 일부 동물의 입양일이 잘못 입력되었습니다. 
보호 시작일보다 입양일이 더 빠른 동물의 아이디와 이름을 조회하는 SQL문을 작성해주세요. 
이때 결과는 보호 시작일이 빠른 순으로 조회해야합니다.
*/
SELECT I.ANIMAL_ID, I.NAME
FROM ANIMAL_INS I LEFT JOIN ANIMAL_OUTS O ON I.ANIMAL_ID = O.ANIMAL_ID
WHERE O.DATETIME < I.DATETIME
ORDER BY I.DATETIME;

/*
천재지변으로 인해 일부 데이터가 유실되었습니다. 
입양을 간 기록은 있는데, 보호소에 들어온 기록이 없는 동물의 ID와 이름을 ID 순으로 조회하는 SQL문을 작성해주세요.
*/
SELECT ANIMAL_ID, NAME FROM ANIMAL_OUTS WHERE ANIMAL_ID NOT IN 
(SELECT ANIMAL_ID FROM ANIMAL_INS)
ORDER BY ANIMAL_ID;

/*
7월 아이스크림 총 주문량과 상반기의 아이스크림 총 주문량을 더한 값이 큰 순서대로 상위 3개의 맛을 조회하는 SQL 문을 작성해주세요.
*/
SELECT F.FLAVOR
FROM FIRST_HALF AS F
JOIN (SELECT FLAVOR, SUM(TOTAL_ORDER) AS TOTAL_ORDER FROM JULY GROUP BY FLAVOR) AS J
ON F.FLAVOR = J.FLAVOR
ORDER BY (F.TOTAL_ORDER + J.TOTAL_ORDER) DESC LIMIT 3;

/*
ONLINE_SALE 테이블과 OFFLINE_SALE 테이블에서 2022년 3월의 오프라인/온라인 상품 판매 데이터의 판매 날짜, 상품ID, 유저ID, 판매량을 출력하는 SQL문을 작성해주세요. 
OFFLINE_SALE 테이블의 판매 데이터의 USER_ID 값은 NULL 로 표시해주세요. 
결과는 판매일을 기준으로 오름차순 정렬해주시고 판매일이 같다면 상품 ID를 기준으로 오름차순, 상품ID까지 같다면 유저 ID를 기준으로 오름차순 정렬해주세요.
*/
SELECT DATE_FORMAT(SALES_DATE, '%Y-%m-%d') AS SALES_DATE, PRODUCT_ID, USER_ID, SALES_AMOUNT FROM ONLINE_SALE
WHERE SALES_DATE LIKE '2022-03%'
UNION ALL
SELECT DATE_FORMAT(SALES_DATE, '%Y-%m-%d') AS SALES_DATE, PRODUCT_ID, NULL, SALES_AMOUNT FROM OFFLINE_SALE
WHERE SALES_DATE LIKE '2022-03%'
ORDER BY 1,2,3

/*
보호소에서 중성화 수술을 거친 동물 정보를 알아보려 합니다. 
보호소에 들어올 당시에는 중성화1되지 않았지만, 보호소를 나갈 당시에는 중성화된 동물의 아이디와 생물 종, 이름을 조회하는 아이디 순으로 조회하는 SQL 문을 작성해주세요.
*/
SELECT I.ANIMAL_ID, I.ANIMAL_TYPE, I.NAME
FROM ANIMAL_INS I JOIN ANIMAL_OUTS O
ON I.ANIMAL_ID = O.ANIMAL_ID
WHERE I.SEX_UPON_INTAKE != O.SEX_UPON_OUTCOME
ORDER BY ANIMAL_ID;