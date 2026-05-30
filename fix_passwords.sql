USE quan_ly_lop_hoc;
SET SQL_SAFE_UPDATES = 0;
UPDATE users SET password_hash = '$2b$12$KcQeIS2h2UPXMz1/WA3T8OjaArylWfz7lsvEMZn/MEVZkKXQ0I5JG';
SET SQL_SAFE_UPDATES = 1;
SELECT LEFT(password_hash, 7) AS prefix, COUNT(*) AS cnt FROM users GROUP BY 1;
