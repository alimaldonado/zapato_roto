USE zapatos_rotos;

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