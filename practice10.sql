-- ALTER
-- 컬럼 추가, 컬럼 변경, 컬럼 삭제, 제약조건 추가, 제약조건 삭제 등의 기능을 한다.

-- ADD COLUMN
-- 새로운 컬럼을 추가할 때 쓰는 명령어. 추가된 컬럼의 위치는 늘 맨 끝이 되며 별도로 위치를 지정해줄 수 없다.
ALTER TABLE TEST3 ADD TEST_COL VARCHAR(25);
SELECT * FROM TEST3;

-- DROP COLUMN
-- 기존에 있던 컬럼이 필요 없어졌을 때 삭제하는 명령어. 한번 삭제한 컬럼은 복구할 수 없으므로 주의해야 한다.
ALTER TABLE TEST3 DROP COLUMN TEST_COL;
SELECT * FROM TEST3;

-- MODIFY COLUMN
/*
기존에 있던 컬럼을 변경하고 싶을 때 쓰는 명령어.
데이터 유형 및 크기, DEFAULT, NOT NULL 제약조건에 대한 변경이 가능하다.
데이터 크기 변경 : 저장된 모든 데이터의 크기가 줄이고자 하는 컬럼의 크기보다 작을 경우에만 줄일 수 있다.
(크기를 늘리는 것은 데이터와 상관 없이 가능)
데이터 유형 변경 : 컬럼에 저장된 데이터가 없는 경우에만 데이터 유형을 변경 할 수 있다.
DEFAULT 값 변경 : 변경 이후 저장되는 데이터에만 적용된다.
NOT NULL 제약조건 변경 : 현재 NULL 값이 저장되어 있지 않은 컬럼만 변경 가능.
*/
ALTER TABLE TEST3 MODIFY(TEST_COL VARCHAR(3) DEFAULT '9');
INSERT INTO TEST3 (JOB_ID, SALARY) VALUES('ADE', 12345);
SELECT * FROM TEST3;

-- RENAME COLUMN
-- 기존에 있던 컬럼의 이름을 변경하고 싶을 때 쓰는 명령어.
ALTER TABLE TEST3 RENAME COLUMN TEST_COL TO ABC;
SELECT * FROM TEST3;

-- ADD CONSTRAINT
-- 제약조건을 추가하고 싶을 때 쓰는 명령어이다.
ALTER TABLE TEST3 ADD CONSTRAINT PK_JOB PRIMARY KEY (JOB_ID);

-- DROP TABLE
/*
테이블을 삭제할 떄 쓰는 명령어.
해당 테이블을 참조하고 있는 다른 테이블이 존재하는 경우 CASCADE 옵션을 명시하지 않으면 삭제되지 않는다.
CASCADE CONSTRAINT는 참조 제약조건도 함께 삭제한다는 의미이다.
*/
DROP TABLE TEST2 CASCADE CONSTRAINT;

-- TRUNCATE TABLE
-- 테이블에 저장되어 있는 데이터를 모두 제거하는 명령어. ROLLBACK 불가능으로 인해 DDL로 분류

TRUNCATE TABLE TEST5;

-- DCL(Data Control Language)
-- USER를 생성하고, USER에게 데이터를 컨트롤 할 수 있는 권한을 부여하거나 회수하는 명령어.

-- USER 관련 명령어

-- CREATE USER
-- 사용자를 생성하는 명령어. CREATE USER 권한이 있어야 수행 가능하다.
CREATE USER ROHAM IDENTIFIED BY 1234;

-- ALTER USER
-- 사용자를 변경하는 명령어.
ALTER USER ROHAM IDENTIFIED BY 1541;

-- DROP USER
-- 사용자를 삭제하는 명령어.
DROP USER ROHAM;

-- 권한 관련 명령어

-- GRANT
-- 사용자에게 권한을 부여하는 명령어.
GRANT CREATE SESSION TO ROHAM;
GRANT CREATE USER TO ROHAM;
GRANT CREATE TABLE TO ROHAM;

-- ROLE 관련 명령어.
/*
ROLE이란 특정 권한들을 하나의 세트처럼 묶는 것이다.
CREATE SESSION, CREATE USER, CREATE TABLE 권한을 묶어서 CREATE_R이라고 지정할 수 있다.
*/
CREATE ROLE CREATE_T
GRANT CREATE SESSION, CREATE USER, CREATE TABLE TO CREATE_T;
GRANT CREATE_T TO ROHAM;

