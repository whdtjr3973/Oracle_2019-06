-- USER6번 화면입니다.

-- 도서정보를 저장할 table을 생성

CREATE TABLE tbl_books(
    b_seq NUMBER PRIMARY KEY,
    b_title nVARCHAR2(100),
    b_comp nVARCHAR2(50),
    b_author nVARCHAR2(50),
    b_price NUMBER
);

-- SEQ 생성

CREATE SEQUENCE seq_book
START WITH 1
INCREMENT BY 1;

SELECT * FROM tbl_books;