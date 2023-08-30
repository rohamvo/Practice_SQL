-- TCL
-- 트랜잭션을 제어하는 명령어로 COMMIT, ROLLBACK, SAVEPOINT가 있다.
-- 트랜잭션 = 쪼개질 수 없는 업무처리의 단위

-- 트랜잭션의 특징
/*
원자성(Atomicity) : 트랜잭션으로 묶인 일련의 동작들은 모두 성공하거나 모두 실패해야 한다.
일관성(Consistency) : 트랜잭션이 완료된 후에도 데이터베이스가 가진 데이터에 일관성이 있어야 한다.
고립성(Isolation) : 하나의 트랜잭션은 고립되어 수행되어야 한다.
지속성(Durability) : 트랜잭션이 성공적으로 수행되었을 경우 트랜잭션이 변경한 데이터가 영구적으로 저장되어야 한다.
모든 트랜잭션이 로그에 남겨진 뒤 COMMIT 되어야 하고, 그래서 시스템 장애가 발생하더라도 복구가 가능해야 한다.
*/

-- COMMIT
/*
INSERT, DELETE, UPDATE 후 변경된 내용을 확정, 반영하는 명령어
COMMIT을 실행하지 않으면 메모리까지만 반영 되는데 메모리는 휘발성이기 때문에
언제는 사라질 수 있고 다른 사용자는 변경된 값을 조회할 수 없다.
UPDATE 한 뒤 오랜 시간 동안 COMMIT이나 ROLLBACK을 하지 않았을 경우 Lock에 걸려서
다른 사용자가 변경할 수 없는 상황이 발생할 수 있으니 주의해야 한다.
*/

-- ROLLBACK
/*
INSERT, DELETE, UPDATE 후 변경된 내용을 취소하는 명령어이다.
ROLLBACK을 하면 변경하기 이전 값으로 복구된다.
*/

-- SAVEPOINT
/*
ROLLBACK을 수행할 때 전체 작업을 되돌리지 않고 일부만 되돌릴 수 있게 하는 기능을 가진 명령어
ROLLBACK 뒤에 특정 SAVEPOINT를 지정해주면 그 지점까지만 데이터가 복구된다.
*/


-- DDL(Data Definition Language)
-- 데이터를 정의하는 명령어로 CREATE, ALTER, DROP, RENAME, TRUNCATE가 있다.
/*
CREATE 쿼리를 수행할 때 테이블을 생성하면서 그 안에 담게 될 데이터에 대한 데이터 유형을 정해주도록 되어 있다.
데이터 유형은 크게 문자, 숫자, 날짜 타입으로 나뉜다.
문자 - CHAR(고정형), VARCHAR(가변형), CLOB
CHAR 타입은 공백을 문자로 취급하지 않고 VARCHAR는 공백을 문자로 취급한다.
EX) CHAR에서는 'ABC' = 'ABC ' / VARCHAR에서는 'ABC' != 'ABC '
숫자 - NUMBER
날짜 - DATE
데이터 유형을 정의하면서 크기도 함께 정해주게 되는데 한글과 영어의 BYTE수가 다르다.
영어는 한 글자가 1 BYTE, 한글은 한 글자가 3 BYTE이기 때문에 주의해야 한다.
*/

-- CREATE
-- 테이블을 생성하기 위한 명렁어
-- CREATE TABLE 테이블명(컬럼명1 데이터 타입(DEFALUT / NULL 여부), ...);

CREATE TABLE TEST5 (
    COL1 NUMBER NOT NULL,
    COL2 VARCHAR(20) NOT NULL,
    COL3 VARCHAR(5) NOT NULL,
    COL4 VARCHAR(15),
    COL5 VARCHAR(100),
    CONSTRAINT COL1_PK PRIMARY KEY(COL1),
    CONSTRAINT COL3_FK FOREIGN KEY (COL3) REFERENCES TEST4(COL2)
);

/*
테이블 생성 시 반드시 지켜야 할 규칙
1. 테이블명은 고유해야 한다.
2. 한 테이블 내에서 컬럼명은 고유해야 한다.
3. 컬럼명 뒤에 데이터 유형과 데이터 크기가 명시되어야 한다.
4. 컬럼에 대한 정의는 괄호() 안에 기술한다.
5. 각 컬럼들은 , (콤마)로 구분된다.
6. 테이블명과 컬럼명은 숫자로 시작될 수 없다.
7. 마지막은 ; (세미콜론)으로 끝난다.

에러를 발생시키지는 않지만 지키는것이 좋은 규칙
1. 테이블은 각각의 정체성을 내포한 이름을 가져야 한다.
2. 컬럼명을 정의할 때는 다른 테이블과 통일성이 있어야 한다.
*/

-- CONSTRAINT
/*
CREATE TABLE 할 때 제약조건을 정의하는 명령어.
제약조건은 테이블에 저장될 데이터의 무결성, 즉 데이터의 정확성과 일관성을 유지하고,
데이터에 결손과 부정합이 없음을 보증하기 위해 해놓는 장치.
테이블 생성 시 정의해야 할 필수 요소는 아니지만 데이터가 많이 쌓인 후에 정의하려고 하면 골치 아파지므로 초기에 정의해주는 것이 바람직하다.

종류
1. PRIMARY KEY(기본키) : 테이블에 저장된 각각의 Row에 대한 교유성을 보장한다.
한테이블에 하나씩만 정의할 수 있으며 PK로 지정된 컬럼에는 NULL 값이 입력될 수 없고 자동으로 UNIQUE 인덱스로 생성된다.

2. UNIQUE KEY(고유키) : PRIMARY KEY와 유사하게 테이블에 저장된 각각의 Row에 대한 고유성을 보장하기 위한 제약조건이지만 NULL 값이 허용된다.

3. NOT NULL : 해당 컬럼에 NULL 값이 입력되는 것을 허용하지 않는 제약조건

4. CHECK : 컬럼에 저장될 수 있는 값의 범위를 제한.

5. FOREIGN KEY(외래키) : 하나의 테이블이 다른 테이블을 참조하고자 할 때 FK를 정의해준다.
A 테이블에 있는 A_1 컬럼이 B 테이블에 있는 B_1 컬럼을 참조한다고 했을 때 A 테이블의 A_1 값은 반드시
B 테이블의 B_1 컬럼에 존재해야 하며 이와 관련된 상세한 참조 무결성 제약 옵션은 별도로 선택 가능하다.
    * 참조 무결성 규정 관련 옵션
    - CASCADE : Parent 값 삭제 시 Child 값 같이 삭제
    - SET NULL : Parent 값 삭제 시 Child의 해당 컬럼 NULL 처리
    - SET DEFAULT : Parent 값 삭제 시 Child의 해당 컬럼 DEFALUT 값으로 변경
    - RESTRICT : Child 테이블에 해당 데이터가 PK로 존재하지 않는 경우에만 Parent 값 삭제 및 수정 가능
    - NO ACTION : 참조 무결성 제약이 걸려있는 경우 삭제 및 수정 불가
*/

/*
완전히 새로운 테이블을 생성하는 것이 아니고 기존에 존재하던 테이블을 복사해서 생성하고 싶은 경우
CTAS(CREATE TABLE ~ AS SELECT ~) 문을 활용할 수 있는데 컬럼별로 데이터 유형을 다시 명시해주지 않아도 되는 장점이 있다.
제약조건의 백 퍼센트가 복사되는 것은 아니고 NOT NULL 조건만 되며 PRIMARY KEY, UNIQUE KEY, CHECK 등의 제약조건은 초기화 되므로
ALTER 명령어를 써서 정의해주어야 한다.
*/

CREATE TABLE TEST5 (
    COL1 NUMBER,
    COL2 VARCHAR(20) NOT NULL,
    COL3 VARCHAR(5) NOT NULL,
    COL4 VARCHAR(15),
    COL5 VARCHAR(100),
    CONSTRAINT COL1_PK PRIMARY KEY(COL1)
);

CREATE TABLE TEST6 AS SELECT * FROM TEST5;

SELECT * FROM TEST6;

INSERT INTO TEST6 VALUES(NULL, '2', '3', '4', '5');
INSERT INTO TEST5 VALUES(NULL, '2', '3', '4', '5');