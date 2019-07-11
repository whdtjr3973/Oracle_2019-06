-- 관리자화면

-- 데이터를 저장할때 물리적인 저장공간 설정하는데
-- TABLESPACE
DROP TABLESPACE testTS;

CREATE TABLESPACE testTS
DATAFILE 'testTS'
SIZE 100M AUTOEXTEND ON NEXT 100K;

CREATE USER testuser
IDENTIFIED BY 1234
DEFAULT TABLESPACE testTS;

GRANT DBA TO testuser;
REVOKE DBA FROM testuser;

CREATE TABLE tbl_test(
    t1 NUMBER PRIMARY KEY,
    t2 nVARCHAR2(20) NOT NULL
    );
    
DROP TABLE tbl_test;

