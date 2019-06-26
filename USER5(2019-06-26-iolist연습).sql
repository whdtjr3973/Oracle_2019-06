-- USER5 화면입니다

CREATE TABLE tbl_iolist(
    io_seq	NUMBER	PRIMARY KEY,
    io_date	VARCHAR2(10)		NOT NULL,
    io_product	nVARCHAR2(50)		NOT NULL,
    io_comp	nVARCHAR2(50)		NOT NULL,
    io_ceo	nVARCHAR2(50)		,
    io_inout	nVARCHAR2(10)		NOT NULL,
    io_amt	NUMBER		        ,
    io_price	NUMBER	        ,	
    io_total	NUMBER		
);

SELECT *
FROM tbl_iolist;

SELECT io_inout, COUNT(*) FROM tbl_iolist
GROUP BY io_inout;

-- 상품이름으로 그룹을 한뒤 각 상품별 매입매출 횟수확인하는 SQL
SELECT io_product, COUNT(*) FROM tbl_iolist
GROUP BY io_product;

-- 매입매출 정보에서 상품이름 리스트를 추출하여 상품 정보테이블로 생성
-- GROUP BY로 설정한 칼럼의 중복값이 없는 리스트를 추출하는 방법
SELECT io_product FROM tbl_iolist
GROUP BY io_product
ORDER BY io_product;

CREATE TABLE tbl_product(
    p_code	VARCHAR2(5)	PRIMARY KEY,	
    p_name	nVARCHAR2(50)		NOT NULL,
    p_iprice	NUMBER		,
    p_oprice	NUMBER		
);

-- tbl_iolist 에 상품코드 칼럼을 추가하고
-- tbl_product 테이블과 연동하여 상품코드 칼럼을 UPDATE
-- 매입매출테이블에서 상품정보 테이블을 만들고
-- 매입매출에 있는 모든 상품이름이 상품정보 테이블에 반영되었나 확인하는 절차
-- 아래 SELECT에서 리스트가 1개라도 나오면 잘못 만들어진 상품정보가 된다.
SELECT IO.io_product, P.p_name
FROM tbl_iolist IO
    LEFT JOIN tbl_product P
        ON IO.io_product= P.p_name

WHERE P.p_name IS NULL;

-- tbl_iolist에 상품코드 칼럼을 추가하고
-- tbl_product 테이블과 연동하여 상품코드 칼럼을 UPDATE

-- tbl_iolist 테이블에 io_pcode 이름으로 VARCHAR2 형식의 5자리 칼럼을 추가
ALTER TABLE tbl_iolist ADD io_pcode VARCHAR2(5);

-- 테이블 구조를 변경한 후 변경된 테이블 구조를 확인
DESC tbl_iolist;

-- 생성된 ip_pcode 칼럼에 값을 UPDATE한다.
-- 상품정보 테이블에서 상품이름으로 검색을 하여 각 상품에 맞는
-- 상품코드를 tbl_iolist에 UPDATE한다.

UPDATE tbl_iolist IO
SET io_pcode =
    (
        SELECT p_code FROM tbl_product P
        WHERE IO.io_product = P.p_name
    )
;

-- 상품코드를 업데이트 하고 제대로 잘 수행되었는지 검증
-- 이 경우도 리스트가 1개라도 나오면 잘못된 명령수행된 것이다.
SELECT IO.io_pcode, P.p_code, P.p_name
FROM tbl_iolist IO
    LEFT JOIN tbl_product P
        ON IO.io_pcode = P.p_code
WHERE P.p_code IS NULL OR P.p_name IS NULL;

-- io_product(필요없는 칼럼)을 삭제
ALTER TABLE tbl_iolist DROP COLUMN io_product;

DESC tbl_iolist;

SELECT * FROM tbl_iolist;

-- 거래처 정보를 분리하기
-- 거래처명과 CEO명을 리스트로 추출
SELECT io_comp, io_ceo
FROM tbl_iolist
GROUP BY io_comp, io_ceo
ORDER BY io_comp;

-- 거래처정보 테이블 생성
CREATE TABLE tbl_comp(
c_code	VARCHAR2(5)	PRIMARY KEY,
c_name	nVARCHAR2(50)		NOT NULL,
c_ceo	nVARCHAR2(50)		NOT NULL,
c_tel	VARCHAR2(20)		,
c_addr	nVARCHAR2(255)		
);

SELECT *FROM tbl_comp;
SELECT COUNT(*) FROM tbl_comp;

-- 리스트가 1개라도 나오면 안된다

SELECT IO.io_comp, C.c_name
FROM tbl_iolist IO
    LEFT JOIN tbl_comp C
        ON IO.io_comp = C.c_name
WHERE C.c_name IS NULL;

-- tbl_iolist에 거래처코드 칼럼을 생성하고
-- UPDATE 수행

--tbl_iolist 거래처코드 칼럼 생성
ALTER TABLE tbl_iolist ADD io_ccode VARCHAR2(5);

-- UPDATE 수행
UPDATE tbl_iolist IO
SET io_ccode = 
(
SELECT C.c_code FROM tbl_comp C
WHERE io.io_comp = C.c_name AND
    io.io_ceo = C.c_ceo
);

SELECT IO.io_ccode, IO.io_comp, C.c_name, C.c_ceo
FROM tbl_iolist IO
    LEFT JOIN tbl_comp C
        ON IO.io_ccode = C.c_code
WHERE C.c_name IS NULL;        

-- tbl_iolist에서 거래처명, 거래처대표명 칼럼을 삭제
ALTER TABLE tbl_iolist DROP COLUMN io_comp;
ALTER TABLE tbl_iolist DROP COLUMN io_ceo;

desc tbl_iolist;

-- 매입매출테이블, 상품테이블, 거래처테이블을 JOIN하여 List;
-- view를 생성하기 위해서Query를 작성할때
-- 다른 테이블의 칼럼이름들에는 규칙성있는 Alias를 설정해 두면
-- view를 활용해서 또다른 SELECT를 구현할때 
-- 훨씬 편리하게 사용할 수 있다.
DROP VIEW view_iolist;
CREATE VIEW view_iolist

AS
(
    SELECT 
        IO_DATE,
        IO_PCODE,  P_NAME AS IO_PRO_NAME,
        IO_CCODE,  C_NAME AS IO_COMP, 
                    C_CEO AS IO_COMP_CEO,
                    C_TEL AS IO_COMP_TEL,
        IO_INOUT,
        IO_AMT,
        IO_PRICE,
        IO_TOTAL
    FROM tbl_iolist IO
        LEFT JOIN tbl_product P
            ON IO.io_pcode = P.p_code
        LEFT JOIN tbl_comp C
        ON IO.io_ccode = C.c_code
);

SELECT *
FROM view_iolist;

SELECT io_pcode, IO_PRO_NAME
FROM view_iolist;
