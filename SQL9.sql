/*
물고기 종류 별로 가장 큰 물고기의 ID, 물고기 이름, 길이를 출력하는 SQL 문을 작성해주세요.

물고기의 ID 컬럼명은 ID, 이름 컬럼명은 FISH_NAME, 길이 컬럼명은 LENGTH로 해주세요.
결과는 물고기의 ID에 대해 오름차순 정렬해주세요.
단, 물고기 종류별 가장 큰 물고기는 1마리만 있으며 10cm 이하의 물고기가 가장 큰 경우는 없습니다.
*/
SELECT ID, FISH_NAME, LENGTH
FROM FISH_NAME_INFO AS N JOIN (SELECT I.ID, I.LENGTH, I.FISH_TYPE
FROM FISH_INFO AS I 
JOIN (SELECT FISH_TYPE, MAX(LENGTH) AS M_LENGTH FROM FISH_INFO GROUP BY FISH_TYPE) AS M
ON I.FISH_TYPE = M.FISH_TYPE
WHERE I.LENGTH = M.M_LENGTH) AS I
ON N.FISH_TYPE = I.FISH_TYPE
ORDER BY ID;

/*
FISH_INFO에서 평균 길이가 33cm 이상인 물고기들을 종류별로 분류하여 잡은 수, 최대 길이, 물고기의 종류를 출력하는 SQL문을 작성해주세요. 
결과는 물고기 종류에 대해 오름차순으로 정렬해주시고, 10cm이하의 물고기들은 10cm로 취급하여 평균 길이를 구해주세요.
컬럼명은 물고기의 종류 'FISH_TYPE', 잡은 수 'FISH_COUNT', 최대 길이 'MAX_LENGTH'로 해주세요.
*/
SELECT COUNT(*) AS FISH_COUNT, MAX(LENGTH) AS MAX_LENGTH, FISH_TYPE
FROM (SELECT ID, FISH_TYPE,
CASE WHEN LENGTH <= 10 OR LENGTH IS NULL THEN 10 ELSE LENGTH
END AS LENGTH
FROM FISH_INFO) AS I
GROUP BY FISH_TYPE
HAVING AVG(LENGTH) >= 33
ORDER BY FISH_TYPE;

/*
대장균 개체의 ID(ID)와 자식의 수(CHILD_COUNT)를 출력하는 SQL 문을 작성해주세요. 
자식이 없다면 자식의 수는 0으로 출력해주세요. 
이때 결과는 개체의 ID 에 대해 오름차순 정렬해주세요.
*/
SELECT ID, 
CASE WHEN CHILD_COUNT IS NULL THEN 0
ELSE CHILD_COUNT
END AS CHILD_COUNT
FROM ECOLI_DATA AS E LEFT JOIN
(SELECT PARENT_ID, COUNT(*) AS CHILD_COUNT FROM ECOLI_DATA GROUP BY PARENT_ID) AS P
ON E.ID = P.PARENT_ID
ORDER BY ID;

/*
대장균 개체의 크기가 100 이하라면 'LOW', 100 초과 1000 이하라면 'MEDIUM', 1000 초과라면 'HIGH' 라고 분류합니다. 
대장균 개체의 ID(ID) 와 분류(SIZE)를 출력하는 SQL 문을 작성해주세요.이때 결과는 개체의 ID 에 대해 오름차순 정렬해주세요.
*/
SELECT ID,
CASE WHEN SIZE_OF_COLONY <= 100 THEN 'LOW'
WHEN SIZE_OF_COLONY <= 1000 THEN 'MEDIUM'
ELSE 'HIGH'
END AS SIZE
FROM ECOLI_DATA
ORDER BY ID;

/*
대장균 개체의 크기를 내름차순으로 정렬했을 때 상위 0% ~ 25% 를 'CRITICAL', 26% ~ 50% 를 'HIGH', 51% ~ 75% 를 'MEDIUM', 76% ~ 100% 를 'LOW' 라고 분류합니다. 
대장균 개체의 ID(ID) 와 분류된 이름(COLONY_NAME)을 출력하는 SQL 문을 작성해주세요. 이때 결과는 개체의 ID 에 대해 오름차순 정렬해주세요 . 
단, 총 데이터의 수는 4의 배수이며 같은 사이즈의 대장균 개체가 서로 다른 이름으로 분류되는 경우는 없습니다.
*/
SELECT E.ID,
CASE WHEN E.P <= 0.25 THEN 'CRITICAL'
WHEN E.P <= 0.5 THEN 'HIGH'
WHEN E.P <= 0.75 THEN 'MEDIUM'
ELSE 'LOW'
END AS COLONY_NAME
FROM (SELECT ID, PERCENT_RANK() OVER (ORDER BY SIZE_OF_COLONY DESC) AS P
FROM ECOLI_DATA) AS E
ORDER BY ID;

/*
3세대의 대장균의 ID(ID) 를 출력하는 SQL 문을 작성해주세요. 
이때 결과는 대장균의 ID 에 대해 오름차순 정렬해주세요.
*/
SELECT ID
FROM ECOLI_DATA
WHERE PARENT_ID IN (SELECT ID
FROM ECOLI_DATA
WHERE PARENT_ID IN (SELECT ID
FROM ECOLI_DATA
WHERE PARENT_ID IS NULL))
ORDER BY ID;

/*
HR_DEPARTMENT, HR_EMPLOYEES, HR_GRADE 테이블을 이용해 사원별 성과금 정보를 조회하려합니다. 
평가 점수별 등급과 등급에 따른 성과금 정보가 아래와 같을 때, 사번, 성명, 평가 등급, 성과금을 조회하는 SQL문을 작성해주세요.
평가등급의 컬럼명은 GRADE로, 성과금의 컬럼명은 BONUS로 해주세요.
결과는 사번 기준으로 오름차순 정렬해주세요.
*/
SELECT E.EMP_NO, E.EMP_NAME, G.GRADE,
CASE WHEN G.GRADE = 'S' THEN E.SAL * 0.2
WHEN G.GRADE = 'A' THEN E.SAL * 0.15
WHEN G.GRADE = 'B' THEN E.SAL * 0.1
ELSE 0
END AS BONUS
FROM HR_EMPLOYEES AS E JOIN (SELECT EMP_NO,
CASE WHEN AVG(SCORE) >= 96 THEN 'S'
WHEN AVG(SCORE) >= 90 THEN 'A'
WHEN AVG(SCORE) >= 80 THEN 'B'
ELSE 'C'
END AS GRADE
FROM HR_GRADE
GROUP BY EMP_NO) AS G
ON E.EMP_NO = G.EMP_NO
ORDER BY E.EMP_NO;

/*
DEVELOPERS 테이블에서 GRADE별 개발자의 정보를 조회하려 합니다. GRADE는 다음과 같이 정해집니다.

A : Front End 스킬과 Python 스킬을 함께 가지고 있는 개발자
B : C# 스킬을 가진 개발자
C : 그 외의 Front End 개발자
GRADE가 존재하는 개발자의 GRADE, ID, EMAIL을 조회하는 SQL 문을 작성해 주세요.

결과는 GRADE와 ID를 기준으로 오름차순 정렬해 주세요.
*/
WITH S AS
(SELECT (SELECT CODE FROM SKILLCODES WHERE NAME = 'Python') AS P, 
(SELECT CODE FROM SKILLCODES WHERE NAME = 'C#') AS C,
(SELECT SUM(CODE) FROM SKILLCODES WHERE CATEGORY = 'Front End') AS F)

SELECT CASE
WHEN D.SKILL_CODE & S.P AND D.SKILL_CODE & S.F THEN 'A'
WHEN D.SKILL_CODE & S.C THEN 'B'
WHEN D.SKILL_CODE & S.F THEN 'C'
END AS GRADE, ID, EMAIL
FROM DEVELOPERS AS D, S
WHERE SKILL_CODE & (S.C + S.F)
ORDER BY GRADE, ID;