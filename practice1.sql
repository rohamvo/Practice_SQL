CREATE TABLE TEST2 (COL1 VARCHAR2(1));

INSERT INTO TEST2 VALUES('A');

SELECT * FROM actor WHERE first_name = 'NICK';
SELECT * FROM country;

/*
# 별칭(ALIAS)
# 별칭은 테이블, 컬럼 명칭이 길때 줄여서 사용하면 편리하다
# 별칭에 공백이 있다면 '', "" 처리 해주어야 한다
# 예약어 AS 없이도 별칭을 지정할 수 있다.
# 테이블 별칭은 WHERE 절에서 사용 가능하지만 컬럼 별칭은 WHERE절에서 사용 가능하다.(단, GROUP BY나 ORDER BY 같은 절에는 별칭 사용 가능)
# 컬럼 별칭을 where 절에 사용했을 때 에러가 발생하는 이유는 쿼리를 실행할 때 select절보다 where절이 먼저 실행되기 때문이다.*/
SELECT a.city_id, a.phone, ft.description, ft.title
FROM address a, film_text AS ft;
SELECT a.city_id FROM address
/*# 실행불가, 별칭은 해당 쿼리에서만 작동한다

# SQL에서 산술 연산자는 수학의 사칙연산과 같은 우선순위를 가진다.
# 1순위 : () / 2순위 : *, / 3순위 : +. -*/

SELECT 10+5, 10-5, 10*5, 10/5

/*#연산과 동시에 별칭을 지정해줄 수 있다.*/
SELECT 10+5 A, 10-5 B, 10*5 C, 10/5 D

SELECT * FROM TEST2;
/*
#합성연산자
#오라클에선 ||로 가능, MySQL에서 || 는 TRUE, FALSE 판별*/
SELECT CONCAT(Name, District) FROM city WHERE Population > 500000;

/*
#CHAR(ASCII 코드) / 오라클에서는 CHR(ASCII 코드)
#ASCII 코드는 총 128개의 문자를 숫자로 표현할 수 있도록 정의해 놓은 코드. chr 함수는 ascii 코드를 인수로 입력했을 때 매핑되는 문자가 무엇인지를 알려주는 함수이다.*/
SELECT CHAR(65) TIMESTAMP;

/*
#LOWER(문자열) - 문자열을 소문자로 변환해주는 함수*/
SELECT LOWER('ROHAM') TEST;

/*#UPPER(문자열) - 문자열을 대문자로 변환해주는 함수*/
SELECT UPPER('roham') TEST;

/*
#LTRIM(문자열 [,특정 문자]) * []는 옵션
#특정 문자를 따로 명시해주지 않으면 문자열의 왼쪽 공백을 제거하고, 명시해주었을 경우 문자열을 왼쪽부터 한 글자씩 특정 문자와 비교하여 특정 문자에 포함되어 있으면 제거하고 포함되지 않았으면 멈춘다.
#ORACLE에서는 위처럼 동작하지만 MySQL, MSSQL에서는 공백제거만 동작한다.*/
SELECT LTRIM('      ROHAM') TEST;

SELECT LTRIM('ROHAM', 'RO');

/*
#RTRIM(문자열, [,특정 문자]) * []는 옵션
#LTRIM과 비슷한 기능을 하며 방향이 오른쪽이라는것만 다르다.
#LTRIM과 같이 ORACLE 과 MySQL, MSSQL 동작 방식이 다르다.*/
SELECT RTRIM('ROHAM      ');

/*
#TRIM([위치][특정문자][FROM]문자열) *[]는 옵션
#옵션이 하나도 없을 경우 문자열의 왼쪽과 오른쪽 공백을 제거하고, 그렇지 않을 경우 문자열을 위치(LEADING or TRAILING or BOTH)로 지정된 곳부터 한 글자씩 특정 문자와 비교하여 같으면 제거하고 같지 않으면 멈춘다. LTRIM, RTRIM과는 달리 특정 문자는 한글자만 지정할 수 있다.*/
SELECT TRIM('     ROHAM      ') FROM TEST2;
SELECT TRIM(LEADING 'R' FROM 'ROHAM') FROM TEST2;

/*
#SUBSTR(문자열, 시작점 [,길이]) *[]는 옵션
#문자열의 원하는 부분만 잘라서 반환해주는 함수이다. 길이를 명시하지 않았을 경우 문자열의 시작점부터 문자열의 끝까지 반환된다.*/
SELECT SUBSTRING('ROHAM', 2, 3) FROM TEST2;

/*
#LENGTH(문자열)
#문자열의 길이를 반환해주는 함수이다.*/
SELECT LENGTH('ROHAM') FROM TEST2;

/*
#REPLACE(문자열, 변경 전 문자열 [,변경 후 문자열]) *[]는 옵션
#문자열에서 변경 전 문자열을 찾아 변경 후 문자열로 바꿔주는 함수이다.
#MySQL에서는 문자열을 제거하고 싶으면 변경 후 문자열을 빈 문자열로 작성해주어야 한다. 
#ORACLE에서는 변경 후 문자열을 명시해주지 않으면 문자열에서 변경 전 문자열을 제거한다.*/
SELECT REPLACE('ROHAM', 'OHA', 'ABC') FROM TEST2;
SELECT REPLACE('ROHAM', 'ROH') FROM TEST2;

/*
#ABS(수)
#수의 절대값을 반환해주는 함수이다.*/
SELECT ABS(-1);

/*
#SIGN(수)
#수의 부호를 반환해주는 함수이다. 양수이면 1, 음수이면 -1, 0이면 0을 반환한다.*/
SELECT SIGN(-7);
SELECT SIGN(10);
SELECT SIGN(0);

/*
#ROUND(수 [,자릿수]) *[]는 옵션
#수를 지정된 소수점 자릿수까지 반올림하여 반환해주는 함수이다. 자릿수를 명시하지 않았을 경우 기본값은 0이며 반올림된 정수로 반환하고 자릿수가 음수일 경우 지정된 정수부를 반올림하여 반환한다.*/
SELECT ROUND(123.45, 1);
SELECT ROUND(155.45, -2);
SELECT ROUND(155.45, 0);
SELECT ROUND(155.45);

/*
#TRUNCATE(수 [,자릿수])
#수를 지정된 소수점 자릿수까지 버림하여 반환해주는 함수이다. 버림된 정수로 반환하고 자릿수가 음수일 경우 정수부에서 버림하여 반환한다.
#ROUND와 달리 0도 지정을 해주어야 한다.*/
SELECT TRUNCATE(267.87, 1);
SELECT TRUNCATE(267.87, -1);
SELECT TRUNCATE(265.87)

/*
#CEIL(수)
#소수점 이하의 수를 올림한 정수를 반환해주는 함수이다.*/
SELECT CEIL(165.87);
SELECT CEIL(-33.67);

/*
#FLOOR(수)
#소수점 이하의 수를 버림한 정수를 반환해주는 함수이다.*/
SELECT FLOOR(164.83);

/*
#MOD(수1,수2)
#수1을 수2로 나눈 나머지를 반환해주는 함수이다.*/
SELECT * FROM TEST2;
SELECT MOD(15, 6) FROM TEST2;
SELECT MOD(-14, 3) FROM TEST2; /*#나머지가 음수로 출력된다.*/
SELECT MOD(-15,0) FROM TEST2; /*#-15 출력*/


/*
#SYSDATE()
#현재의 연, 월, 일, 시, 분, 초를 반환해주는 함수이다(nls_date_format에 따라서 sysdate의 출력 양식은 달라질 수 있음)*/
SELECT SYSDATE();

/*
#EXTRACT(특정 단위 FROM 날짜 데이터)
#날짜 데이터에서 특정 단위(YEAR, MONTH, DAY, HOUR, MINUTE, SECOND)만을 출력해서 반환해주는 함수이다.*/
SELECT EXTRACT (YEAR FROM SYSDATE());
SELECT EXTRACT (DAY FROM SYSDATE());

/*
#ADD_MONTHS(날짜 데이터, 특정 개월 수)
#날짜 데이터에서 특정 개월 수를 더한 날짜를 반환해주는 함수이다. 날짜의 이전 달이나 다음달에 기준 날짜의 일자가 존재하지 않으면 해당 월의 마지막 일자가 반환된다.*/
SELECT DATE_ADD(TO_DATE('2023-08-24', 'YYYY-MM-DD'), -1);
SELECT ADD_MONTHS(TO_DATE('2023-08-24', 'YYYY-MM-DD'), 1) FROM TEST2;
