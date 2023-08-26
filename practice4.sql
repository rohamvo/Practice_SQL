-- Active: 1692846238725@@127.0.0.1@3306@world
SELECT * FROM country;

# GROUP BY
# GROUP BY는 말 그대로 데이터를 그룹별로 묶을 수 있도록 해주는 절이다.
# GROUP 뒤에 수단의 전치사인 BY가 붙었기 때문에 GROUP BY 뒤에는 그룹핑의 기준이 되는 컬럼이 오게 된다. 컬럼은 하나가 될 수도 있고 그 이상이 될 수도 있다.

# 집계 함수
# 데이터를 그룹별로 나누면 그룹별로 집계 데이터를 도출하는 것이 가능해진다.
# COUNT(*) / 전체 ROW를 COUNT하여 반환
# COUNT(컬럼) / 컬럼값이 NULL인 ROW를 제외하고 COUNT하여 반환
# COUNT(DISTINCT 컬럼) / 컬럼값이 NULL이 아닌 ROW에서 중복을 제거한 COUNT를 반환
# SUM(컬럼) / 컬럼값들의 합계를 반환
# AVG(컬럼) / 컬럼값들의 평균을 반환
# MIN(컬럼) / 컬럼값들의 최소값을 반환
# MAX(컬럼) / 컬럼값들의 최대값을 반환
SELECT COUNT(SurfaceArea) FROM country WHERE Population > 500000;
SELECT COUNT(LifeExpectancy) FROM country;
SELECT * FROM country WHERE LifeExpectancy IS NULL;
SELECT SUM(SurfaceArea) FROM country;
SELECT AVG(SurfaceArea) FROM country;
SELECT MIN(LifeExpectancy) FROM country;
SELECT MAX(LifeExpectancy) FROM country;

# HAVING
# HAVING 절은 GROUP BY 절을 사용할 때 WHERE 절처럼 사용하는 조건절이라고 생각하면 되는데 주로 데이터를 그룹핑한 후 특정 그룹을 골라낼 때 사용한다.
# HAVING 절은 논리적으로 GROUP BY 절 이후에 수행된다.
/* HAVING 절은 논리적으로 SELECT 절 전에 수행되기 때문에 SELECT절에 명시되지 않은 집계 함수로도 조건을 부여할 수 있다. 주의할 점은 WHERE절을 사용해도 되는 조건까지
HAVING 절로 써버리면 성능상 불리할 수 있다는 것이다(수행 시 오류가 나지는 않는다). 왜냐하면 WHERE 절에서 필터링이 선행되어야 GROUP BY 할 데이터량이 줄어들기 때문이다.
GROUP BY는 비교적 많은 비용이 드는 작업이므로 수행 전에 데이터량을 최소로 줄여놓는 것이 바람직하다. */
SELECT Continent, AVG(SurfaceArea) AS AVG FROM country WHERE Population > 5000000 GROUP BY Continent HAVING AVG(SurfaceArea) > 5000000;

# ORDER BY 절
# ORDER BY 절은 SELECT 문에서 논리적으로 맨 마지막에 수행된다.
/*
ORDER BY 절을 사용하여 SELECT한 데이터를 정렬할 수 있으며 ORDER BY 절을 따로 명시하지 않으면 데이터는 임의의 순서대로 출력된다.
ORDER BY 절 뒤에는 정렬의 기준이 되는 컬럼이 오게 되는데 컬럼은 하나가 될 수도 있고 그 이상이 될 수도 있다.
또한 ORDER BY 절 뒤에 오는 컬럼에는 옵션이 붙을 수 있으며 종류는 ASC(오름차순), DESC(내림차순)이 있고 ASC가 기본값이다.
*/

SELECT * FROM country WHERE Population >= 10000000 ORDER BY NAME DESC;

/* 정렬의 기준이 되는 컬럼에 NULL 데이터가 포함되어 잇을 경우 데이터베이스 종류에 따라 정렬의 위치가 달라지는데 Oracle의 경우에는 NULL을 최대값으로
취급하기 때문에 오름차순을 햇을 경우 맨 마지막에 위치하게 된다(SQL Server는 반대). 만약 순서를 변경하고 싶다면 ORDER BY 절에 NULLS FIRST, NULLS LAST
옵션을 써서 NULL의 정렬상 순서를 변경할 수 있다.*/

SELECT LifeExpectancy FROM country ORDER BY LifeExpectancy;
SELECT LifeExpectancy FROM country ORDER BY LifeExpectancy NULLS LAST;
SELECT * FROM country ORDER BY Name ASC, GNP DESC; # ,를 통해 구분지어서 작성해주어야함.

# JOIN
# 각기 다른 테이블을 한 번에 보여줄 때 쓰는 쿼리

# EQUI JOIN
# equal(=) 조건
SELECT c.Name, cl.Language FROM country c, countrylanguage cl WHERE c.Name = 'El Salvador';

# Non EQUI JOIN
# equal(=) 조건이 아닌 다른 조건 (BETWEEN, >, >=, <, <=)으로 JOIN하는 방식
SELECT c.Population, cl.Language FROM country c, countrylanguage cl WHERE cl.Language = 'Dutch' AND c.Population > 500000;

# 3개 이상 TBLE JOIN
SELECT c.Population, cl.language, ci.Population FROM country c, countrylanguage cl, city ci;

# OUTER JOIN
# OUTER JOIN은 앞서 본 JOIN과는 다르게 JOIN조건에 만족하지 않는 행들도 출력되는 형태이다.
# LEFT OUTER JOIN의 경우 LEFT TABLE과 RIGHT TABLE의 데이터 중 JOIN에 성공한 데이터와 JOIN에 성공하지 못한 나머지 LEFT TABLE의 데이터가 함께 출력된다.ADD
# ORACLE에서는 모든 행이 출력되는 테이블의 반대편 테이블의 옆에 (+) 기호를 붙여 작성해주면 된다.
SELECT c.Population, cl.language FROM country c, countrylanguage cl WHERE c.Population = cl.language(+);

# STANDARD JOIN
# 표준 ANSI SQL중 하나 모든 벤더(Oracle, MySQL 등)에서 사용가능한 JOIN쿼리

# INNER JOIN
# JOIN 조건에 충족하는 데이터만 출력되는 방식이다. 앞서 본 SQL과의 차이점은 JOIN 조건을 ON 절을 사용하여 작성해야 한다는 점이다.
SELECT c.Code, ci.CountryCode FROM country c INNER JOIN city ci ON c.Code = ci.CountryCode;