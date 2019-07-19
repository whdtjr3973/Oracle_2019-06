-- USER6화면입니다.

CREATE TABLE tbl_member(
m_userid	VARCHAR2(15)	PRIMARY KEY	NOT NULL,
m_password	VARCHAR2(64)		NOT NULL,
m_name	nVARCHAR2(39)		,
m_email	VARCHAR2(25)		NOT NULL,
m_tel	VARCHAR2(20)		,
m_role	VARCHAR2(5)		
);