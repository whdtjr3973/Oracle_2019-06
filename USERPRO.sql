--Project 화면

CREATE TABLE tbl_board (
    b_seq NUMBER PRIMARY KEY,
    b_title nVARCHAR2(30) NOT NULL,
    b_auth  nVARCHAR2(10) NOT NULL,
    b_date  nVARCHAR2(10)
);

DROP SEQUENCE seq_board;

CREATE SEQUENCE seq_board
START WITH 1
INCREMENT BY 1;