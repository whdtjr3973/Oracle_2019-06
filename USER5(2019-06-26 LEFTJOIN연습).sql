-- USER5 화면입니다.

-- JOIN은 2개의 테이블에 데이터가 분산되어 있을때
-- A테이블에는 고객코드만 있고
-- B테이블에 고객정보가 들어 있을 경우
-- A테이블의 데이터를 조회하면서(SELECT, READ, RELATIVE)
-- B테이블의 고객정보를 연결하여
-- A테이블의 고객코드가 누구를 가르키는지 알고자 할때

-- 001 코코넛 10 100 1000 이런 데이터가 있을때
-- 001은 고객코드이고 현재 테이블에 데이터 칼럼이 없어서
-- 001 고객의 정보를 확인하려면 따로 고객 테이블을 열어서 확인해야 하는데
-- 두 테이블을 JOIN하면 한 리스트에서 같이 연동하여 조회할수 있다.

SELECT * FROM tbl_iolist;

-- 5월 5일부터 5월 10일까지 매입매출 정보를 확인하자
SELECT *FROM tbl_iolist
WHERE io_date BETWEEN '2018-05-05' AND '2018-05-10';

-- 데이터를 조회했더니 SEQ 97번의 데이터가 금액이 많아보인다.
-- 97번 데이터만 조회해보자
SELECT *FROM tbl_iolist
WHERE io_seq = 97;

-- 위 리스트에서 알수있는것은
-- 상품코드 = P0220이고
-- 고객코드가 D0124라는 것만 알수있다
-- 누가, 어떤상품을 매입했는지 알수없다
-- 먼저 고객이 누군지 확인
SELECT * FROM tbl_comp
WHERE c_code = 'D0124';
-- 고객이 벤딩테크 이이형 대표 라는것을 확인

-- 상품이 어떤 상품인지 확인
SELECT *FROM tbl_product
WHERE p_code = 'P0220';
-- 상품이름이 셀렘원 이라는것을 확인

-- 벤딩테크의 고객이 셀렘원이라는 상품을 1844원에 65개를 구입

-- 이 간단한 정보를 확인하기 위해 여러차례 SELECT를 수행
-- 그래도 결과물에 신뢰성이 없음

-- 그래서 97거래내역을 조회할때
-- 상품정보(이름)와 고객정보를 한눈에 볼수 있으면 좋겠다 라는 생각이든다.
-- 이럴때 우리는 테이블을 JOIN하여 결과를 확인

SELECT io_seq, io_date, io_inout, io_ccode,c_name, io_pcode,p_name, io_amt, io_price, io_total
         
FROM tbl_iolist  -- 주목적의 tbl
    LEFT JOIN tbl_product 
        ON io_pcode = p_code
    LEFT JOIN tbl_comp 
        ON io_ccode = c_code
WHERE io_seq = 97;
-- LEFT의 왼쪽에 오는 테이블은 확인하고자 하는 주목적의 테이블을 위치
-- 주목적의 테이블을 확인하면서 보조적으로 정보를 확인하고자 하는 테이블을
-- 오른쪽에 위치시킨다

DROP VIEW view_iolist_com_pro;
CREATE VIEW view_iolist_com_pro

AS(

SELECT io_seq, io_date, io_inout, io_ccode,c_name, io_pcode,p_name, io_amt, io_price, io_total
         
FROM tbl_iolist  -- 주목적의 tbl
    LEFT JOIN tbl_product 
        ON io_pcode = p_code
    LEFT JOIN tbl_comp 
        ON io_ccode = c_code

);

SELECT * FROM view_iolist_com_pro
WHERE io_seq = 97;

SELECT * FROM view_iolist_com_pro
WHERE io_date BETWEEN '2018-05-01' AND '20188-05-31'
ORDER BY io_date;

SELECT * FROM view_iolist_com_pro
WHERE io_date BETWEEN '2018-05-01' AND '20188-05-31'
ORDER BY io_pcode;

SELECT * FROM view_iolist_com_pro
WHERE io_date BETWEEN '2018-05-01' AND '20188-05-31'
ORDER BY p_name;