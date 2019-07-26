-- 여기는 User6화면

CREATE TABLE tbl_menu(
menu_id	VARCHAR2(5)	PRIMARY KEY	,
main_id	VARCHAR2(5)		,
menu_title	nVARCHAR2(50)		NOT NULL,
menu_href	nVARCHAR2(50)		NOT NULL
);

SELECT * FROM tbl_menu;
SELECT M.menu_id, M.menu_title, S.main_id, S.menu_title 
FROM tbl_menu M
    LEFT JOIN tbl_menu S
        ON M.menu_id = S.main_id
WHERE main_id IS NULL;

CREATE TABLE tbl_bbs(
    bbs_seq	NUMBER	PRIMARY KEY,
    bbs_main_seq	NUMBER	,
    bbs_layer	NUMBER	,
    bbs_date	VARCHAR2(10)	,
    bbs_time	VARCHAR2(20)	,
    bbs_auth	nVARCHAR2(50)	,
    bbs_title	nVARCHAR2(255)	,
    bbs_content	nVARCHAR2(1000)	
);
CREATE SEQUENCE seq_bbs
Start with 1
increment by 1;

SELECT * FROM tbl_bbs;

delete from tbl_bbs;
commit;

CREATE TABLE tbl_bbs_file(
    file_seq	NUMBER	PRIMARY KEY,
    file_bbs_seq	NUMBER	,
    file_origin_name	nVARCHAR2(1000)	,
    file_name	nVARCHAR2(1000)	
);

CREATE SEQUENCE seq_bbs_file
START WITH 1
INCREMENT BY 1;

SELECT * FROM tbl_bbs_file;
SELECT * FROM tbl_bbs;

DELETE FROM tbl_bbs;
DELETE FROM tbl_bbs_file;

commit;

delete from tbl_menu;
