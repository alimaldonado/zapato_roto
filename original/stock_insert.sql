USE zapatos_rotos;

INSERT INTO tbl_stock_movements (id,quantity,product_id,entry_date) VALUES
((SELECT UUID()), (SELECT FLOOR(1 + RAND() * 200)), (SELECT `id` FROM tbl_products ORDER BY RAND() LIMIT 1),NOW()),
((SELECT UUID()), (SELECT FLOOR(-200 + RAND() * 200)), (SELECT `id` FROM tbl_products ORDER BY RAND() LIMIT 1),NOW()),
((SELECT UUID()), (SELECT FLOOR(1 + RAND() * 200)), (SELECT `id` FROM tbl_products ORDER BY RAND() LIMIT 1),NOW()),
((SELECT UUID()), (SELECT FLOOR(1 + RAND() * 200)), (SELECT `id` FROM tbl_products ORDER BY RAND() LIMIT 1),NOW()),
((SELECT UUID()), (SELECT FLOOR(-200 + RAND() * 200)), (SELECT `id` FROM tbl_products ORDER BY RAND() LIMIT 1),NOW()),
((SELECT UUID()), (SELECT FLOOR(1 + RAND() * 200)), (SELECT `id` FROM tbl_products ORDER BY RAND() LIMIT 1),NOW()),
((SELECT UUID()), (SELECT FLOOR(-200 + RAND() * 200)), (SELECT `id` FROM tbl_products ORDER BY RAND() LIMIT 1),NOW()),
((SELECT UUID()), (SELECT FLOOR(-200 + RAND() * 200)), (SELECT `id` FROM tbl_products ORDER BY RAND() LIMIT 1),NOW()),
((SELECT UUID()), (SELECT FLOOR(-200 + RAND() * 200)), (SELECT `id` FROM tbl_products ORDER BY RAND() LIMIT 1),NOW()),
((SELECT UUID()), (SELECT FLOOR(-200 + RAND() * 200)), (SELECT `id` FROM tbl_products ORDER BY RAND() LIMIT 1),NOW()),
((SELECT UUID()), (SELECT FLOOR(1 + RAND() * 200)), (SELECT `id` FROM tbl_products ORDER BY RAND() LIMIT 1),NOW()),
((SELECT UUID()), (SELECT FLOOR(1 + RAND() * 200)), (SELECT `id` FROM tbl_products ORDER BY RAND() LIMIT 1),NOW()),
((SELECT UUID()), (SELECT FLOOR(1 + RAND() * 200)), (SELECT `id` FROM tbl_products ORDER BY RAND() LIMIT 1),NOW()),
((SELECT UUID()), (SELECT FLOOR(-200 + RAND() * 200)), (SELECT `id` FROM tbl_products ORDER BY RAND() LIMIT 1),NOW());