CREATE DATABASE zapatos_rotos;

USE zapatos_rotos;

-- id type uuid
CREATE TABLE tbl_products_alt (
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
    pivot table allows one product to have
    several packagings  
*/
CREATE TABLE tbl_products_packagings (
    product_id CHAR(36) NOT NULL,
    packaging_id CHAR(36) NOT NULL,
    -- unique prevents repeating registries
    UNIQUE(product_id, packaging_id),
    CONSTRAINT fk_packaging_product_id FOREIGN KEY(product_id)
    REFERENCES tbl_products(id) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_product_packaging_id FOREIGN KEY(packaging_id)
    REFERENCES tbl_packagings(id) ON UPDATE CASCADE ON DELETE RESTRICT
) DEFAULT CHARACTER SET utf8mb4
            COLLATE utf8mb4_general_ci
            engine = innodb;

