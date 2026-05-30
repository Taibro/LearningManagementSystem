USE quan_ly_lop_hoc;
SET SQL_SAFE_UPDATES = 0;
UPDATE users SET password_hash = '$2b$12$PqzeP1iGSLvHGoZu5Ut4W.HjFLITYipGGfTEkgXqUjhjXzqBLipNa';
SET SQL_SAFE_UPDATES = 1;
SELECT LEFT(password_hash, 7) AS prefix, COUNT(*) AS cnt FROM users GROUP BY 1;
