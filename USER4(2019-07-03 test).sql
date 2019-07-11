-- USERT4 화면입니다.
SELECT * FROM tbl_student;

SELECT ST_NO,
    ST_NAME,
    ST_ADDR,
    ST_GRADE,
    ST_HEIGHT,
    ST_WEIGHT,
    ST_NICK,
    ST_NICK_REM,
    ST_DEPT_NO
FROM tbl_student;

SELECT ST_NO,
    ST_NAME,
    ST_ADDR,
    ST_GRADE
FROM tbl_student;

-- 001 학생의 주소가 서울특별시로 되어있다.
-- 주소를 서울특별시에서 광주광역시로 바꾸고싶다.
UPDATE tbl_student
SET st_addr = '광주광역시'
WHERE st_no = '001';

DESC tbl_iolist;
DESC tbl_product;

-- EQ조건이 성립 되려면 두 테이블이 참조 무결성관계이어야 한다.
SELECT * FROM tbl_iolist, tbl_product
WHERE io_pcode = p_code;

SELECT *
FROM tbl_iolist IO
    LEFT JOIN tbl_product P
        ON IO.io_pcode = P.p_code;
        
        
SELECT IO.io_seq, IO.io_date, IO.io_pcode, IO.io_inout, P.p_name, IO.io_price, IO.io_amt
FROM tbl_iolist IO
    LEFT JOIN tbl_product P
        ON IO.io_pcode = P.p_code
WHERE io_inout = '매입'
ORDER BY io_date;

CREATE VIEW view_iolist

AS
(
SELECT IO.io_seq, IO.io_date, IO.io_pcode, IO.io_inout, P.p_name, IO.io_price, IO.io_amt, (IO.io_price * IO.io_amt) AS 매입금액
FROM tbl_iolist IO
    LEFT JOIN tbl_product P
        ON IO.io_pcode = P.p_code
WHERE io_inout = '매입'
);
ORDER BY io_date;

SELECT SUM(DECODE(io_inout, '매입', io_total,0)) AS 매입금액,
        SUM(DECODE(io_inout, '매출', io_total,0)) AS 매출금액,
        SUM(DECODE(io_inout, '매출', io_total,0) -
        DECODE(io_inout, '매입', io_total,0)) AS 마진
FROM tbl_iolist;