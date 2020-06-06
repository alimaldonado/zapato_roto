CREATE DATABASE zapatos_rotos;

USE zapatos_rotos;

/*
    ENG

    The table products contain the basic properties of
    a single product, name, price(value), when was created
    and when updated. Plus the field ´code´ allows to
    search by code and not by name or id (which are more complex).
    Id's type field is uuid, useful for big cuantities of data and
    to protect secret information (e.g. how many records the
    system is making in a lapse of time).

    ES

    La tabla productos contiene las propiedades básicas de
    un producto individual: nombre, precio(o valor), fecha de
    creacion y actualizacion. Ademas, se agrega el campo codigo
    que permite hacer busquedas por el codigo de producto
    y no por su nombre o id (los cuales son menos optimos para busquedas).
    El tipo de id es UUID, util para gran cantidad de datos además
    de que protege informacion sensible (p. ej. cuantos registros 
    el sistema realiza en determinado lapso de tiempo).
*/

-- id type uuid
CREATE TABLE tbl_products (
    -- for system purpose only
    id CHAR(36) NOT NULL PRIMARY KEY,
    -- for inventory purposes
    code CHAR(5) NOT NULL,
    name VARCHAR(100) NOT NULL,
    -- aka value
    price DECIMAL(8,2) NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    UNIQUE(code),
    INDEX idx_product_code(code)
) DEFAULT CHARACTER SET utf8mb4
            COLLATE utf8mb4_general_ci
            engine = innodb;

/*
    ENG

    Table packagings allows to separate the product
    from it's packagings. Table contains name, type and code. 
    Code allows to search easier just as with products table.
    Every table except pivot tables will have created and updated 
    dates.

    ES

    La tabla empaques(o presentaciones) permite separar 
    el producto de sus paquetes. La tabla contiene nombre, tipo y codigo.
    El codigo permite una busqueda mas sencilla justo como con la tabla
    productos. Todas las tablas excepto las de pivote tendran campos
    de fecha de creado y actualizado.
*/

CREATE TABLE tbl_packagings (
    id CHAR(36) NOT NULL PRIMARY KEY,
    name VARCHAR (100) NOT NULL,
    type VARCHAR (100) NOT NULL,
    code VARCHAR (5) NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    UNIQUE (code),
    INDEX idx_packaging_code(code)
) DEFAULT CHARACTER SET utf8mb4
            COLLATE utf8mb4_general_ci
            engine = innodb;
/*
    ENG
    Pivot table allows one product to have
    several packagings. It's a many to many
    relationship. This way, a product can be selled
    on several presentations not worrying about 
    repating records. Unique constraint 
    disallows the DB to repeat records by accident.

    ES
    La tabla pivote permite que un producto pueda tener 
    varias presentaciones, en una relación muchos a muchos.
    De esta manera cada producto puede venderse en las 
    diversas presentaciones sin preocuparse de repetir
    registros. El constraint unique evita que repitamos
    datos por accidente en la BD.
*/
CREATE TABLE tbl_products_packagings (
    product_id CHAR(36) NOT NULL,
    packaging_id CHAR(36) NOT NULL,
    -- unique prevents repeating records
    UNIQUE(product_id, packaging_id),
    CONSTRAINT fk_packaging_product_id FOREIGN KEY(product_id)
    REFERENCES tbl_products(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_product_packaging_id FOREIGN KEY(packaging_id)
    REFERENCES tbl_packagings(id) ON UPDATE CASCADE ON DELETE RESTRICT
) DEFAULT CHARACTER SET utf8mb4
            COLLATE utf8mb4_general_ci
            engine = innodb;

/*
    ENG 
    Table countries uses ISO standarized codes.

    ES 
    La tabla paises usa codigos ISO estandar.
*/
CREATE TABLE tbl_countries (
    -- ISO numeric code
    `id` INT(3) NOT NULL PRIMARY KEY,
    `name` VARCHAR(50) NOT NULL,
    `alpha_2_code` VARCHAR(2) NOT NULL,
    `alpha_3_code` VARCHAR(3) NOT NULL,
    UNIQUE(`name`,`alpha_2_code`, `alpha_3_code`)
)
DEFAULT CHARACTER SET utf8mb4
            COLLATE utf8mb4_general_ci
            engine = innodb;

/*
    ENG 
    Table customers saves every customer that has
    made a purchase. It has a `personal_id` which allows to
    invoice the customer using his/her official identification.

    ES
    La tabla clientes guarda cada cliente que haya hecho
    alguna compra. El `pesonal_id` permite facturar al
    cliente usando la identificacion oficial segun su
    origen
*/
CREATE TABLE tbl_customers (
    `id` CHAR(36) NOT NULL PRIMARY KEY,
    `name` VARCHAR(150) NOT NULL,
    -- e.g. if you are mexican your id is your RFC
    `personal_id` VARCHAR(30) NOT NULL,
    `country_id` INT(3) NOT NULL,
    `created_at` DATETIME NOT NULL,
    `updated_at` DATETIME NOT NULL,
    UNIQUE(`personal_id`),
    CONSTRAINT fk_customers_country_id FOREIGN KEY (`country_id`) 
    REFERENCES tbl_countries(id) ON UPDATE CASCADE ON DELETE RESTRICT
)
DEFAULT CHARACTER SET utf8mb4
            COLLATE utf8mb4_general_ci
            engine = innodb;

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

/*
    ENG 
    The table for stock movements records
    every ins and outs from the warehouse.
    An In will be registered with positive sign
    while an Out will be registered with a negative
    sign.

    ES 
    La tabla de movimientos de inventario
    guarda cada entrada y salida de almacen.
    Una entrada sera registrada con signo positivo
    mientras que una salida sera registrada con
    un signo negativo.
*/
CREATE  TABLE tbl_stock_movements(
    id CHAR(36) NOT NULL PRIMARY KEY,
    quantity DECIMAL (8,2) NOT NULL,
    product_id CHAR(36) NOT NULL,
    entry_date DATETIME NOT NULL,
    CONSTRAINT fk_stock_product_id FOREIGN KEY (product_id) 
    REFERENCES tbl_products (id) ON UPDATE CASCADE ON DELETE RESTRICT
)
DEFAULT CHARACTER SET utf8mb4
            COLLATE utf8mb4_general_ci
            engine = innodb;