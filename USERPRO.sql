--Project 화면
DROP TABLE tbl_board;
CREATE TABLE tbl_board (
    b_seq NUMBER PRIMARY KEY,
    b_title nVARCHAR2(30) NOT NULL,
    b_auth nVARCHAR2(10) NOT NULL,
    b_content nVARCHAR2(1000) NOT NULL,
    b_date VARCHAR2(10),
    b_time VARCHAR2(10)
);

DROP SEQUENCE seq_board;

CREATE SEQUENCE seq_board
START WITH 1
INCREMENT BY 1;

select * from tbl_board;