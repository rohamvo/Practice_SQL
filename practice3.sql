-- WHERE절
/* INSERT를 제외한 DML(Data Manipulation Language : 데이터 조작어)문을 수행할 때 원하는 데이터만 골라 수행할 수 있도록 해주는 구문이다.*/
SELECT * FROM actor;
SELECT * FROM actor WHERE actor_id = 1;
SELECT * FROM actor WHERE actor_id > 50;
SELECT * FROM actor WHERE first_name = 'FAY';
SELECT * FROM actor WHERE first_name <> 'FAY'; # <>(!=, ^=) : not equal
SELECT * FROM actor WHERE NOT last_name = 'CHASE';

# 조건식에서 컬럼명은 일반적으로 좌측에 위치하지만 우측에 위치해도 정상적으로 동작한다.

# SQL 연산자
# BETWEEN A AND B / A부터 B까지
# LIKE '비교 문자열' / 비교 문자열 포함
# IN (LIST) / LIST 중 하나와 일치
# IS NULL / NULL 값
SELECT actor_id FROM actor WHERE actor_id BETWEEN 10 AND 50;
SELECT actor_id FROM actor WHERE NOT (actor_id BETWEEN 10 AND 50);
SELECT first_name FROM actor WHERE first_name LIKE 'N%';
SELECT first_name FROM actor WHERE first_name LIKE '%S%';
SELECT first_name FROM actor WHERE first_name IN ('ED', 'JOE');
SELECT first_name FROM actor WHERE first_name IS NULL;

# 부정 SQL 연산자
# NOT BETWEEN A AND B / A 부터 B까지가 아님
# NOT IN (LIST) / LIST 중 일치하는 것이 없음
# IS NOT NULL / NULL 값이 아님
SELECT actor_id, first_name, last_name FROM actor WHERE actor_id NOT BETWEEN 2 AND 50;
SELECT actor_id, first_name, last_name FROM actor WHERE first_name NOT IN ('NICK', 'ED', 'CHRISTIAN');
SELECT first_name FROM actor WHERE first_name IS NOT NULL;

# 논리 연산자
# AND / 모든 조건이 TRUE여야 함
# OR / 하나 이상의 조건이 TRUE여야 함
# NOT / TRUE면 FALSE이고 FALSE이면 TRUE
# 논리 연산자는 SQL에 명시된 순서와는 관계없이 () -> NOT -> AND -> OR 순으로 처리된다.

SELECT * FROM actor WHERE first_name = 'JOE' AND last_name = 'SWANK';
SELECT * FROM actor WHERE first_name = 'JOE' OR last_name = 'WOOD';
SELECT * FROM actor WHERE NOT (first_name = 'JOE' OR last_name = 'WOOD');
