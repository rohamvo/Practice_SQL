-- Active: 1692846238725@@127.0.0.1@3306@world

# OUTER JOIN
# JOIN 조건에 충족하는 데이터가 아니어도 출력될 수 있는 방식이다.

# LEFT OUTER JOIN
/* 
SQL에서 왼쪽에 표기된 테이블의 데이터는 무조건 출력되는 JOIN이다.
오른쪽 테이블에 JOIN되는 데이터가 없는 Row들은 오른쪽 테이블 컬럼의 값은 NULL로 출력된다.
*/

# RIGHT OUTER JOIN
# LEFT OUTER JOIN과 동일한 방식이고 오른쪽에 표기된 테이블의 데이터는 무조건 출력되는 방식이다.

# FULL OUTER JOIN
# 왼쪽, 오른쪽 테이블의 데이터가 모두 출력되는 방식이다.(단, 중복값은 제거)

SELECT * FROM TEST1 A RIGHT OUTER JOIN TEST2 B ON (A.T1 = B.T3 AND B.T4 IS NOT NULL);

# NATRUAL JOIN
# A테이블과 B테이블에서 같은 이름을 가진 컬럼들이 모두 동일한 데이터를 가지고 있을 경우 JOIN되는 방식.
SELECT * FROM TEST1 T1 NATURAL JOIN TEST2 T2;

CREATE TABLE TEST1(  
    COL1 INT(255),
    COL2 VARCHAR(10)
);

INSERT INTO TEST1 VALUES(2, 'G'), (3, 'H'), (4, 'I');
INSERT INTO TEST2 VALUES(1, 'A'), (2, 'G'), (3, 'H'), (4, 'D'), (4, 'I');
UPDATE TEST1 SET COL1 = '4' WHERE COL2 = 'I';
SELECT SUM(COL1) FROM TEST1 A JOIN TEST2 B USING(COL1);

# CROSS JOIN
# A 테이블과 B 테이블 사이에 JOIN 조건이 없는 경우, 조합할 수 있는 모든 경우를 출력하는 방식이다. (다른 말로 Cartesian Product)라고 표현하기도 한다.

# 서브쿼리
/*
하나의 쿼리 안에 존재하는 도 다른 쿼리이다. 바깥에 있는 쿼리를 메인 쿼리라고 부르고 안에 있는 쿼리를 서브쿼리라고 부른다.
서브쿼리는 위치에 따라 다음과 같이 나눌 수 있다.
SELECT 절 : 스칼라 서브쿼리(Scalar Subquery)
FROM 절 : 인라인 뷰(Inline View)
WHERE 절, HAVING 절 : 중첩 서브쿼리(Nested Subquery)

메인 쿼리의 컬럼이 포함된 서브쿼리를 연관 서브쿼리 메인 쿼리의 컬럼이 포함되지 않은 서브쿼리를 비연관 서브쿼리라 한다.
*/

# 스칼라 서브쿼리
# 주로 SELECT 절에 위치하지만 컬럼이 올 수 있는 대부분 위치에 사용할 수 있다. 컬럼 대신 사용되므로 반드시 하나의 값만을 반환해야 하며 그렇지 않은 경우 에러를 발생시킨다.
SELECT co.GNP, (SELECT ci.Name FROM city ci WHERE Population = 237500) AS big_p FROM country co;

# 인라인 뷰
# FROM 절 등 테이블명이 올 수 있는 위치에 사용 가능하다.
SELECT co.LifeExpectancy, ci.Name, ci.Population FROM country co, (SELECT Name, Population FROM city) ci WHERE co.Code = 'GRL' and ci.Population > 100000;

# 중첩 서브쿼리
# WHERE 절과 HAVING 절에 사용할 수 있다. 중첩 서브쿼리는 메인 쿼리와의 관계에 따라 다음과 같이 나눌 수 있다.
# 비연관 서브쿼리 : 메인 쿼리와 관계를 맺고 있지 않음
# 연관 서브쿼리 : 메인 쿼리와 관계를 맺고 있음

# 비연관 서브쿼리 : 서브쿼리 내에 메인 쿼리의 컬럼이 존재하지 않음
SELECT Name, SurfaceArea FROM country WHERE Code = (SELECT CountryCode FROM city WHERE Population = 186800);

# 연관 서브쿼리 : 서브쿼리 내에 메인 쿼리의 컬럼 존재

# 중첩 서브쿼리는 반환하는 데이터 형태에 따라 다음과 같이 나눌 수 있다.
# 단일 행(Single Row) 서브쿼리 : 서브쿼리가 1건 이하의 데이터를 반환 / 단일 행 비교 연산자(=,<,>,<=,>=,<>)와 함께 사용
# 다중 행(Multi Row) 서브쿼리 : 서브쿼리가 여러 건의 데이터를 반환 / 다중 행 비교 연산자(IN, ALL, ANY, SOME, EXITS)와 함께 사용
# 다중 컬럼(Multi Column) 서브쿼리 : 서브쿼리가 여러 컬럼의 데이터를 반환

# 단일 행 서브쿼리 : 항상 1건 이하의 결과만 반환
SELECT * FROM country WHERE Population = (SELECT MAX(Population) FROM country);

# 다중 행 서브쿼리 : 2건 이상의 행을 반환
SELECT * FROM country WHERE Code IN (SELECT CountryCode FROM city);

# 뷰(View)
/*
특정 SELECT 문에 이름을 붙여서 재사용이 가능하도록 저장해놓은 오브젝트이다.
뷰는 가상 테이블이다. 실제 데이터를 저장하지는 않고 해당 데이터를 조회해오는 SELECT 문만 가지고 있다.
*/

CREATE OR REPLACE VIEW TEST_VIEW AS
    SELECT co.Name, ci. District FROM country co, city ci;

SELECT * FROM TEST_VIEW;
DROP VIEW TEST_VIEW;

# 집합 연산자
/* 집합 연산자는 각 쿼리의 결과 집합을 가지고 연산을 하는 명령어이다.
UNION ALL : 각 쿼리의 결과 집합의 합집합이다. 중복된 행도 그대로 출력된다.
UNION : 각 쿼리의 결과 집합의 합집합이다. 중복된 행은 한 줄로 출력된다.
INTERSECT : 각 쿼리의 결과 집합의 교집합이다. 중복된 행은 한 줄로 출력된다.
MINUS/EXCEPT : 앞에 있는 쿼리의 결과 집합에서 뒤에 있는 쿼리의 결과 집합을 뺀 차집합이다. 중복된 행은 한 줄로 출력된다.
헤더값은 첫 번째 쿼리를 따라간다.
*/
SELECT Name FROM city
UNION ALL
SELECT LANGUAGE FROM countrylanguage;

# 그룹 함수
/*
데이터를 GROUP BY 하여 나타낼 수 있는 데이터를 구하는 함수이다. 역할에 따라 구분해보면 집계 함수와 소계(총계) 함수로 나눌 수 있다.
집계 함수 : COUNT, SUM, AVG, MAX, MIN 등
소계(총계) 함수 : ROLLUP, CUBE, GROUPING SETS 등
*/

# ROLLUP
/* 
소그룹 간의 소계 및 총계를 계산하는 함수이다.
ROLLUP(A) - A로 그룹핑 / 총합계
ROLLUP(A,B) - A, B로 그룹핑 / A로 그룹핑 / 총합계
ROLLUP(A,B,C) - A, B, C로 그룹핑 / A, B로 그룹핑 / A로 그룹핑 / 총합계
