CREATE TABLE TEST (COL1 VARCHAR(10));
ALTER TABLE TEST ADD (COL2 VARCHAR(10));
SELECT * FROM TEST;
INSERT INTO TEST VALUES ('ABC', 'DEF');

-- 변환 함수
/*
명시적 형변환과 암시적 형변환
- 데이터베이스에서 데이터 유형에 대한 형변환을 할 수 있는 방법은 두 가지가 있다.
명시적 형변환 : 변환 함수를 사용하여 데이터 유형 변환을 명시적으로 나타냄
암시적 형변환 : 데이터베이스가 내부적으로 알아서 데이터 유형을 변환함

명시적 형변환
1. TO_NUMBER(문자열)
*/
SELECT TO_NUMBER('1234') FROM TEST;
SELECT TO_NUMBER('ABC') FROM TEST; -- ERROR 발생

-- TO_CHAR(수 OR 날짜 [,포맷]) *[]는 옵션
-- 수나 날짜형의 데이터를 포맷 형식의 문자형으로 변환해주는 함수이다.

SELECT TO_CHAR(1234) FROM TEST;
SELECT TO_CHAR(SYSDATE, 'YYYYMMDD HH24MISS') FROM TEST;

-- TO_DATE(문자열,포맷)
-- 포맷 형식의 문자형의 데이터를 날짜형으로 변환해주는 함수이다.

SELECT TO_DATE('20210602', 'YYYYMMDD') FROM TEST;

-- NULL 관련 함수

-- NVL(인수1, 인수2)
-- 인수1의 값이 NULL일 경우 인수2를 반환하고 NULL이 아닐 경우 인수1을 반환해주는 함수이다.
SELECT COL1, NVL(COL2,0) AS COL2 FROM TEST;

--NULLIF(인수1, 인수2)
--인수1과 인수2가 같으면 NULL을 반환하고 같지 않으면 인수1을 반환해주는 함수이다.
SELECT COL1, NULLIF(COL2, 1) AS COL2, COL1 FROM ;

--COALESCE(인수1, 인수2, 인수3 ...)
--NULL이 아닌 최초의 인수를 반환해주는 함수이다.

SELECT COL2 COALESCE()
