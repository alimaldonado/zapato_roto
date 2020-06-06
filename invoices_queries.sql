/*
    View for reading general data from invoices

    Vista para leer datos generales de las facturas
*/
CREATE  VIEW view_invoices AS
SELECT  tbl_invoices.id AS invoice_id,
        tbl_customers.name AS customer_name, 
        tbl_customers.personal_id, 
        tbl_invoices.sale_amount, 
        tbl_invoices.discount, 
        tbl_invoices.taxes, 
        tbl_invoices.total, 
        tbl_products.name AS item,
        tbl_products.code AS product_code, 
        tbl_invoice_products.quantity, 
        tbl_invoice_products.unit_price, 
        tbl_invoice_products.amount AS item_amount,
        tbl_invoices.expedited_at AS invoice_date
FROM tbl_invoice_products, tbl_products, tbl_invoices, tbl_customers
WHERE tbl_invoices.id = tbl_invoice_products.invoice_id AND 
    tbl_products.id = tbl_invoice_products.product_id AND 
    tbl_invoices.customer_id = tbl_customers.id
ORDER BY tbl_invoices.id ASC;

/*
    Query for invoices from a single customer.
    It searches by personal id and not db primary key

    Consulta para facturas de un solo cliente. 
    Busca por identificacion personal y no por clave primaria
*/
SELECT * FROM view_invoices WHERE personal_id = '16180606 0545';

/*
    Query for invoices from a single product.
    It searches by product code and not db primary key

    Consulta para facturas de un solo producto.
    Busca por codigo de producto y no por clave primaria
*/
SELECT * FROM view_invoices WHERE product_code = 'P-001';

/*
    Query for search from a date range

    Query para busqueda de un rango de fechas
*/
SELECT * FROM view_invoices WHERE invoice_date BETWEEN '2020-01-01 00:00:00' AND NOW();

/*
    Query for invoices from single time customer

    Consulta para facturas de clientes unicos
*/
SELECT  * FROM view_invoices WHERE personal_id IN
(SELECT personal_id FROM tbl_customers
    WHERE id IN
    (SELECT customer_id FROM 
        (SELECT customer_id, COUNT(*) AS total 
        FROM tbl_invoices
        GROUP BY customer_id
        HAVING total = 1) as customer_id)); 