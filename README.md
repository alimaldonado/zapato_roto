# Base de Datos "Zapato Roto"

El repositorio cuenta con los tres queries necesarios: para crear tablas, para insertar y las consultas necesarias de facturas.

En original se encuentras los queries separados por la tabla a la que se refieren.

Para facilitar la consulta de facturas, se creó una vista que reune el contenido de la tabla invoices y la tabla invoice_products. De esa manera, para consultar por cliente, por producto o por fecha, un query simple se debe realizar cada vez.

La consulta mas compleja es para ver clientes unicos. Se realiza un subquery para conocer el conteo de facturas por cliente y se seleccionan solo aquellos que hayan hecho una venta. Con su id se procede a buscar sus facturas y el contenido de las mismas en view_invoices.
