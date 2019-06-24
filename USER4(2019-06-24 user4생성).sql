-- user4 화면입니다

CREATE TABLE tbl_student(
    st_no CHAR(3) PRIMARY KEY ,
    st_name nVARCHAR2(30) NOT NULL,
    st_addr nVARCHAR2(50),
    st_grade NUMBER(1) NOT NULL,
    st_height NUMBER(3),
    st_weight NUMBER(3),
    st_nick nVARCHAR2(20),
    st_nick_rem nVARCHAR2(50),
    st_dep_no CHAR(3) NOT NULL
);

SELECT * FROM tbl_student ;

CREATE TABLE tbl_dept(
dept_no	CHAR(3)	PRIMARY KEY	NOT NULL,
dept_name	nVARCHAR2(50)		NOT NULL,
dept_pro	nVARCHAR2(50)		,
dept_te	nVARCHAR2(50)		
);

-- tbl_student 와 tbl_dept 테이블을 LEFT JOIN해서 리스트를 확인
SELECT * FROM tbl_student, tbl_dept
WHERE st_dep_no = dept_no;

-- DDL 생성 : CREATE
-- DDL 삭제 : DROP
-- DDL 변경 : ALTER
-- 칼럼명 변경
ALTER TABLE tbl_student RENAME COLUMN st_dep_no TO st_dept_no;
-- 칼럼의 타입
-- 원래 존재하는 st_weight 칼럼의 데이터 타입 변경
-- CHAR <--> VARCHAR2 까지 변경을 하면
--      WHERE 절에서 값을 못찾는 경우도 있다.
ALTER TABLE tbl_student MODIFY (st_weight NUMBER(5));

ALTER TABLE tbl_dept RENAME COLUMN dept_te TO dept_ta;


SELECT * FROM tbl_student, tbl_dept
WHERE st_dept_no = dept_no;

-- EQ JOIN으로 데이터 연동하기
-- 두 테이블의 데이터가 모두 존재하는 경우 사용가능
SELECT ST.st_name,ST.staddr, ST.st_dept_no, DT.dept_name
FROM tbl_student ST, tbl_dept DT
WHERE ST.st_dept_no = DT.detp_no;
-- LEFT JOIN으로 데이터 연동하기
SELECT ST.st_name, ST.st_addr,ST.st_dept_no, DT.dept_name
FROM tbl_student ST
LEFT JOIN tbl_dept DT
    ON ST.st_dept_no = DT.dept_no;
    
-- 실제 데이터가 아니고
-- 복잡한 구조의 SELECT문을 마치 하나의 TABLE 인것처럼 취급하기 위한
-- 데이터객체
CREATE VIEW view_student
AS(    
SELECT ST.st_no, ST.st_name, ST.st_addr,ST.st_dept_no, DT.dept_name
FROM tbl_student ST
LEFT JOIN tbl_dept DT
    ON ST.st_dept_no = DT.dept_no
);
DROP VIEW view_student;
-- view는 한번 생성을 하면
-- 물리적인 table처럼 자유롭게 사용할수 있다
SELECT * FROM view_student;
SELECT * FROM view_student
WHERE st_name = '조용필';

SELECT * FROM view_student
ORDER BY st_no;

-- view는 생성한 후 변경(ALTER)기능이 없다
-- view는 수정하려면 삭제(DROP)한 후 재 생성을 해야한다.

-- 기존의 테이블을 새로운 테이블로 복제
-- 원본 테이블에서 WHERE 조건을 포함하여
-- 조건에 맞는 부분만 복제도 가능하다.
-- 데이터를 복제하게 되면 원본데이터에 있는 여러 제약조건이 해제되기도 한다.
CREATE TABLE tbl_score
AS(
    SELECT * FROM user3.tbl_score
    WHERE sc_subject = '국어'
);

-- 복제된 데이터의 PK가 해제되었기 때문에
-- 복제된 데이터에 PK를 재 설정한다.
ALTER TABLE tbl_score 
-- tbl_score 테이블에 sc_seq 칼럼을 PRIMARY KEY로 설정을해라
-- 이때 이름을 pk로 설정한다.
ADD CONSTRAINT pk PRIMARY KEY(sc_seq);

-- PK삭제
ALTER TABLE tbl_score
DROP PRIMARY KEY;

select * from tbl_score;