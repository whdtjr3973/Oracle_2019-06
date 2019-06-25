-- 관리자 화면입니다.
-- C:/bizwork/mydb 폴더에 user5TS 이름으로 tablespace를 생성하고
-- 초기크기는 500MB, 자동증가 100KB

CREATE TABLESPACE user5TS
DATAFILE 'C:/bizwork/MyDB/user5TS.dbf'
SIZE 500M AUTOEXTEND ON NEXT 100K;
-- user5 사용자를 생성
-- DBA로 권한을 부여

CREATE USER user5
IDENTIFIED BY 1234
DEFAULT TABLESPACE user5TS;

DROP USER user5 cascade;
GRANT DBA TO user5;

-- student엑셀파일을 참조하여 학생 테이블을 생성하고
-- 엑셀 데이터를 임포트 수행


