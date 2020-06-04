USE zapatos_rotos;

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