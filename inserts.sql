USE zapatos_rotos;

-- insert for countries
INSERT  INTO tbl_countries (`name`,`alpha_2_code`,`alpha_3_code`,`id`) VALUES
('Mexico', 	'MX', 	'MEX', 	484),
('Peru', 	'PE', 	'PER', 	604),
('Colombia', 	'CO', 	'COL', 	170),
('Uruguay', 	'UY', 	'URY', 	858),
('Canada', 	'CA', 	'CAN', 	124);


-- insert for customers
INSERT INTO `tbl_customers` (`id`,`name`,`personal_id`,`country_id`,`created_at`,`updated_at`) VALUES 
((SELECT UUID()),'Regina Ashley','16180606 0545', 484,NOW(),NOW()),
((SELECT UUID()),'Barrett Floyd','16300214 4420', 484,NOW(),NOW()),
((SELECT UUID()),'Shana Myers','16831204 3014', 604,NOW(),NOW()),
((SELECT UUID()),'Adena Le','16700209 7249', 604,NOW(),NOW()),
((SELECT UUID()),'Demetrius Adkins','16990906 7176', 170,NOW(),NOW()),
((SELECT UUID()),'Nathaniel Moss','16870306 3829', 170,NOW(),NOW()),
((SELECT UUID()),'Jessamine Mathews','16920808 6232', 858,NOW(),NOW()),
((SELECT UUID()),'Hiroko Turner','16830430 6700', 858,NOW(),NOW()),
((SELECT UUID()),'Nevada Schultz','16991209 0207', 124,NOW(),NOW()),
((SELECT UUID()),'Jaden Whitley','16010814 0641', 124,NOW(),NOW());

-- insert for products
INSERT INTO tbl_products(id, code, name, price, created_at, updated_at) VALUES
((SELECT UUID()),'P-001','Sneakers', 28.00, NOW(), NOW()),
((SELECT UUID()),'P-002','BoatShoes', 37.95, NOW(), NOW()),
((SELECT UUID()),'P-003','Loafers', 48.50, NOW(), NOW()),
((SELECT UUID()),'P-004','ArmyBoots', 58.75, NOW(), NOW()),
((SELECT UUID()),'P-005','TexasBoots', 99.95, NOW(), NOW());


-- official codes for meassurements in MX
-- codigos de medida oficiales para MX
INSERT INTO tbl_packagings(id, type, code, name, created_at, updated_at) VALUES
((SELECT UUID()),'Múltiplos/Fracciones/Decimales',	'H87',	'Pieza', NOW(), NOW()),
((SELECT UUID()),'Unidades de venta', 'DPC', 'Docena de piezas', NOW(), NOW()),
((SELECT UUID()),'Unidades de empaque',	'XLT',	'Lote', NOW(), NOW());

-- insert products packagings
INSERT INTO tbl_products_packagings (product_id, packaging_id) VALUES
((SELECT id FROM tbl_products WHERE code = 'P-001'),(SELECT id FROM tbl_packagings WHERE code = 'H87')),
((SELECT id FROM tbl_products WHERE code = 'P-002'),(SELECT id FROM tbl_packagings WHERE code = 'H87')),
((SELECT id FROM tbl_products WHERE code = 'P-003'),(SELECT id FROM tbl_packagings WHERE code = 'H87')),
((SELECT id FROM tbl_products WHERE code = 'P-004'),(SELECT id FROM tbl_packagings WHERE code = 'H87')),
((SELECT id FROM tbl_products WHERE code = 'P-005'),(SELECT id FROM tbl_packagings WHERE code = 'H87')),

((SELECT id FROM tbl_products WHERE code = 'P-001'),(SELECT id FROM tbl_packagings WHERE code = 'DPC')),
((SELECT id FROM tbl_products WHERE code = 'P-002'),(SELECT id FROM tbl_packagings WHERE code = 'DPC')),
((SELECT id FROM tbl_products WHERE code = 'P-003'),(SELECT id FROM tbl_packagings WHERE code = 'DPC')),
((SELECT id FROM tbl_products WHERE code = 'P-004'),(SELECT id FROM tbl_packagings WHERE code = 'DPC')),
((SELECT id FROM tbl_products WHERE code = 'P-005'),(SELECT id FROM tbl_packagings WHERE code = 'DPC')),

((SELECT id FROM tbl_products WHERE code = 'P-001'),(SELECT id FROM tbl_packagings WHERE code = 'XLT')),
((SELECT id FROM tbl_products WHERE code = 'P-002'),(SELECT id FROM tbl_packagings WHERE code = 'XLT')),
((SELECT id FROM tbl_products WHERE code = 'P-003'),(SELECT id FROM tbl_packagings WHERE code = 'XLT')),
((SELECT id FROM tbl_products WHERE code = 'P-004'),(SELECT id FROM tbl_packagings WHERE code = 'XLT')),
((SELECT id FROM tbl_products WHERE code = 'P-005'),(SELECT id FROM tbl_packagings WHERE code = 'XLT'));

-- insert for products stock
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

-- procedure to fill invoices
    Delimiter //
    CREATE PROCEDURE fill_invoices()
    BEGIN
    DECLARE product_count INT;
    DECLARE invoice_count INT;
    DECLARE invoice_id CHAR(36);
    DECLARE product_id CHAR(36);

    SET invoice_count = 0;
    
    WHILE invoice_count <= 20 DO
    -- invoice data initialized
    SET product_count = 0;
    SET invoice_id = (SELECT UUID());
    INSERT  INTO `tbl_invoices` (
        `id`,
        `customer_id`,
        `sale_amount`,
        `discount`,
        `taxes`,
        `total`,
        `expedited_at`
    ) VALUES (
        invoice_id,
        (SELECT `id` FROM tbl_customers ORDER BY RAND() LIMIT 1),
        0,
        0,
        0,
        0,
        NOW()
    );
    -- selects randomly items to add to purchase
        WHILE product_count <= 5 DO

            SET product_id =
            (SELECT `id` FROM tbl_products
            ORDER BY RAND()
            LIMIT 1);

            INSERT  INTO `tbl_invoice_products` (
                `id`,
                `product_id`,
                `quantity`,
                `unit_price`,
                `amount`,
                `invoice_id`
            ) VALUES (
                (SELECT UUID()),
                product_id,
                2,
                (SELECT `price` FROM tbl_products WHERE  `id` = product_id),
                (SELECT `price` * 2 FROM tbl_products WHERE  `id` = product_id),
                invoice_id
            );
            SET product_count = product_count + 1;
        END WHILE;
    -- the invoice amount, discount and total is then updated
        UPDATE `tbl_invoices` SET `sale_amount` = (SELECT SUM(`amount`)FROM tbl_invoice_products WHERE `invoice_id` = invoice_id) WHERE `id` = invoice_id;
        UPDATE `tbl_invoices` SET `discount` = (SELECT `sale_amount` * 0.10 WHERE `id` = invoice_id) WHERE `id` = invoice_id;
        UPDATE `tbl_invoices` SET `taxes` = (SELECT `sale_amount` * 0.16 WHERE `id` = invoice_id) WHERE `id` = invoice_id;
        UPDATE `tbl_invoices` SET `total` = (SELECT `sale_amount` - `discount` + `taxes` WHERE `id` = invoice_id) WHERE `id` = invoice_id;
        SET invoice_count = invoice_count + 1;
    END  WHILE;
    END // 
    
    DELIMITER ;

    CALL  fill_invoices();

