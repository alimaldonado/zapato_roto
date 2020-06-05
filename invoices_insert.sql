    Delimiter //
    CREATE PROCEDURE fill_invoices()
    BEGIN
    DECLARE product_count INT;
    DECLARE invoice_id CHAR(36);
    DECLARE product_id CHAR(36);

    SET product_count = 0;
    SET invoice_id = (SELECT UUID());

    -- invoice data initialized
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
    END // 
    