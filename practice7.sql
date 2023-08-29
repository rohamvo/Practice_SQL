-- 행 순서 함수

-- FIRST_VALUE
-- 파티션 별 가장 선두에 위치한 데이터를 구하는 함수이다.

SELECT NO, TITLE, FIRST_VALUE(DOWNLOAD_CNT) OVER(ORDER BY NO) AS F_V FROM SSAK3;

SELECT NO, TITLE, FIRST_VALUE(DOWNLOAD_CNT) OVER(PARTITION BY NO ORDER BY DOWNLOAD_CNT) AS F_V FROM SSAK3;

-- LAST_VALUE
-- 파티션 별 가장 끝에 위치한 데이터를 구하는 함수이다.

SELECT NO, TITLE, LAST_VALUE(DOWNLOAD_CNT) OVER(ORDER BY DOWNLOAD_CNT) AS F_V FROM SSAK3;

SELECT NO, TITLE, LAST_VALUE(DOWNLOAD_CNT) OVER(PARTITION BY NO ORDER BY DOWNLOAD_CNT) AS F_V FROM SSAK3;
-- WINDOWING절의 default가 RANGE UNBOUNDED PRECEDING이어서 파티션의 범위가 맨 위 끝 행부터 현재행까지 지정되어서 각 행의 DOWNLOAD_CNT값이 출력

-- 수정
SELECT NO, TITLE, LAST_VALUE(DOWNLOAD_CNT) OVER(PARTITION BY NO ORDER BY DOWNLOAD_CNT RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS F_V FROM SSAK3;

-- LAG
-- 파티션 별로 특정 수만큼 앞선 데이터를 구하는 함수이다.

SELECT NO, TITLE, LAG(DOWNLOAD_CNT,3) OVER(ORDER BY DOWNLOAD_CNT) AS LA FROM SSAK3;

-- LEAD
-- 파티션 별 특정 수만큼 뒤에 있는 데이터를 구하는 함수이다.

SELECT NO, TITLE, LEAD(DOWNLOAD_CNT,1) OVER(PARTITION BY NO ORDER BY DOWNLOAD_CNT) AS LA FROM SSAK3;


-- 비율 함수

-- RATIO_TO_REPORT
-- 파티션 별 합계에서 차지하는 비율을 구하는 함수이다.

SELECT NO, TITLE, RATIO_TO_REPORT(DOWNLOAD_CNT) OVER(PARTITION BY NO) AS RTR FROM SSAK3;

-- PERCENT_RANK
-- 해당 파티션의 맨 위 끝행을 0, 맨 아래 끝행을 1로 놓고 현재 행이 위치하는 백분위 순위 값을 구하는 함수이다.
SELECT NO, TITLE, PERCENT_RANK() OVER(PARTITION BY NO ORDER BY DOWNLOAD_CNT) FROM SSAK3;

-- CUME_DIST
-- 해당 파티션에서의 누적 백분율을 구하는 함수이다. 결과값은 0보다 크고 1보다 작거나 같은 값을 가진다.
SELECT NO, TITLE, CUME_DIST() OVER(PARTITION BY NO ORDER BY DOWNLOAD_CNT) FROM SSAK3;

-- NTILE
-- 주어진 수만큼 행들을 N등분한 후 현재 행에 해당하는 등급을 구하는 함수이다.

SELECT NO, TITLE,
NTILE(3) OVER(ORDER BY DOWNLOAD_CNT) AS NTILE3,
NTILE(4) OVER(ORDER BY NO) AS NTILE5
FROM SSAK3;

SELECT NO, TITLE, NTILE(2) OVER(PARTITION BY NO ORDER BY DOWNLOAD_CNT) AS NTILE2 FROM SSAK3;


CREATE TABLE TEST3 (JOB_ID VARCHAR(10), SALARY NUMBER(10));

DROP TABLE TEST3;

INSERT INTO TEST3 VALUES ('AD_VP', 17000);
INSERT INTO TEST3 VALUES ('AD_VP', 17000);
INSERT INTO TEST3 VALUES ('IT_PROG', 14000);
INSERT INTO TEST3 VALUES ('IT_PROG', 10000);
INSERT INTO TEST3 VALUES ('IT_PROG', 5800);
INSERT INTO TEST3 VALUES ('IT_PROG', 4800);
INSERT INTO TEST3 VALUES ('IT_PROG', 4200);

SELECT JOB_ID, SALARY, NTILE(2) OVER(PARTITION BY JOB_ID ORDER BY SALARY DESC) AS RESULT FROM TEST3;