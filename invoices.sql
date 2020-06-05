USE `zapatos_rotos`;

CREATE TABLE tbl_invoices(
    `id` CHAR(36) NOT NULL PRIMARY KEY,
    `customer_id` CHAR (36) NOT NULL,
    `sale_amount` DECIMAL(8,2) DEFAULT NULL,
    `discount` DECIMAL (8,2) NOT NULL,
    `taxes` DECIMAL (8,2),
    `total` DECIMAL (8,2) NOT NULL,
    `expedited_at` DATETIME NOT NULL,
    CONSTRAINT fk_invoice_customer_id FOREIGN KEY (`customer_id`) REFERENCES `tbl_customers`(`id`)
    ON UPDATE CASCADE ON DELETE CASCADE
)
DEFAULT CHARACTER SET utf8mb4
            COLLATE utf8mb4_general_ci
            engine = innodb;

/*
    ENG
    The unit price will be selected from products table.
    If the product is updated the sale price will stay
    the same

    ES
    El precio unitario sera seleccionado de la tabla productos.
    si el producto es actualizado, el precio de venta permanecera
    el mismo.
*/
CREATE  TABLE `tbl_invoice_products` (
    `id` CHAR(36) NOT NULL PRIMARY KEY,
    `product_id` CHAR(36) NOT NULL,
    `quantity` INT(6) NOT NULL,
    `unit_price` DECIMAL(8,2) NOT NULL,
    `amount` DECIMAL(8,2) NOT NULL,
    `invoice_id` CHAR(36) NOT NULL,
    CONSTRAINT fk_invoice_product_id FOREIGN KEY (`product_id`) REFERENCES `tbl_products`(`id`)
    ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_invoice_products_invoice_id FOREIGN KEY (`invoice_id`)
    REFERENCES `tbl_invoices` (`id`) ON UPDATE CASCADE ON DELETE RESTRICT
)DEFAULT CHARACTER SET utf8mb4
            COLLATE utf8mb4_general_ci
            engine = innodb;