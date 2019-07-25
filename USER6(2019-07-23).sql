SELECT * FROM tbl_iolist
    LEFT JOIN tbl_product
        On io_pcode = p_code
    LEFT JOIN tbl_comp
        ON io_ccode = c_code;
        
SELECT 
    io_seq,
    io_date,
    io_inout,
    io_ccode,
    c_name AS io_cname,
    io_pcode,
    p_name AS io_pname,
    io_amt,
    io_price,
    DECODE(io_inout, '1', io_total, 0) AS io_itotal,
    DECODE(io_inout, '2', io_total, 0 ) AS io_ototal
    FROM tbl_iolist
    LEFT JOIN tbl_product
        On io_pcode = p_code
    LEFT JOIN tbl_comp
        ON io_ccode = c_code;