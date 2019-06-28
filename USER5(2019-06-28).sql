-- USER5 화면입니다

-- 매우 위험한 명령
-- DDL 명령인데
--DROP AND CREATE
-- tbl_student의 테이블을 새 테이블로 다시 만들겠다
TRUNCATE TABLE tbl_student;
TRUNCATE TABLE tbl_score;

-- DDL 명령 FOREIG KEY(외래키)
-- 두테이블의 연관 제약사항을 만드는 방법

-- 참조 무결성 조건
-- 학생과 성적을 입력하는데
-- 학생에 없는 학번은 절대 성적에 입력할수 없도록 방지하여(오류메시지 발생)
-- 학생에 없는 학번을 성적에 입력하는 실수를 방지하는 방법

ALTER TABLE tbl_score
ADD CONSTRAINT f_no FOREIGN KEY (sc_st_no)
REFERENCES tbl_student(st_no);
-- 001 학생의 국어 점수를 추가하려고 시도를했다
-- F_NO 제약사항에 위배된다.
INSERT INTO tbl_score(sc_seq, sc_date, sc_st_no, sc_subject, sc_score)
VALUES(1, '2019-06-28', '001', '국어', 90);

-- 그래서 먼저 학생 데이터를 추가한다.
INSERT INTO tbl_student(st_no, st_name, st_grade, st_dept_name)
VALUES('001', '홍길동', 3, '컴공과');

INSERT INTO tbl_score(sc_seq, sc_date, sc_st_no, sc_subject, sc_score)
VALUES(1, '2019-06-28', '002', '국어', 90);

-- 참조 무결성
-- 두개의 테이블이 아래와 같을때
-- tbl_student : parents        tbl_score : child
--  값이 있으면          >>      있을수도 있다.
--  값이 없으면          >>      절대 없다. 절대 있을수 없다.
--  반드시 존재          >>      있으면
-- chid 값이 존재하면 parents는 삭제할수 없다. : 일반규칙

-- 두개의 테이블을 FOREIGN KEY로 연결하려면
-- 1. 연결하고자 하는 칼럼의 tpye과 크기가같아야 한다.
-- 2. parents에 있는 칼럼은 PK이거나 UNIQUE

SELECT * FROM tbl_student;
DELETE FROM tbl_student
WHERE st_no = '001';

-- tbl_score 의 FOREIGN KEY 삭제
ALTER TABLE tbl_score
DROP CONSTRAINT f_no;

ALTER TABLE tbl_score
ADD CONSTRAINT f_no FOREIGN KEY (sc_st_no)
REFERENCES tbl_student(st_no)
-- 부모 데이터를 삭제하려고 시도하면
-- 자식 데이터에 해당하는 KEY값이 존재하면 같이 제거해라
ON DELETE CASCADE ; 

-- EQ JOIN
-- 참조무결성이 보장될떄는 완벽한 리스트를 보장
-- 완벽한 리스트 : 두 테이블간에 연결값이 반드시 존대하는 상태
SELECT * FROM tbl_score, tbl_student
WHERE sc_st_no = st_no;

SELECT * FROM tbl_score;
DELETE FROM tbl_student WHERE st_no = '001';

SELECT * FROM tbl_student ;
INSERT INTO tbl_student(st_no,st_name, st_grade, st_dept_name)
VALUES('001', '홍길동', 3, '컴공');

DELETE FROM tbl_student;

ALTER TABLE tbl_score
DROP CONSTRAINT f_no;

ALTER TABLE tbl_student MODIFY st_no varchar2(3);
ALTER TABLE tbl_score MODIFY sc_st_no varchar2(3);

DESC tbl_student;
DESC tbl_score;

SELECT * FROM tbl_student;

ALTER TABLE tbl_score -- child table
ADD CONSTRAINT f_no FOREIGN KEY (sc_st_no) -- child table의 칼럼(FK)
REFERENCES tbl_student(st_no) -- parant table
ON DELETE CASCADE; -- 삭제조건

CREATE SEQUENCE seq_score
START WITH 1 INCREMENT BY 1;



