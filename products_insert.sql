USE zapatos_rotos;

INSERT INTO tbl_products(id, code, name, price, created_at, updated_at) VALUES
((SELECT UUID()),'P-001','Sneakers', 28.00, NOW(), NOW()),
((SELECT UUID()),'P-002','BoatShoes', 37.95, NOW(), NOW()),
((SELECT UUID()),'P-003','Loafers', 48.50, NOW(), NOW()),
((SELECT UUID()),'P-004','ArmyBoots', 58.75, NOW(), NOW()),
((SELECT UUID()),'P-005','TexasBoots', 99.95, NOW(), NOW());

-- official codes for meassurements in mx
INSERT INTO tbl_packagings(id, type, code, name, created_at, updated_at) VALUES
((SELECT UUID()),'Múltiplos/Fracciones/Decimales',	'H87',	'Pieza', NOW(), NOW()),
((SELECT UUID()),'Unidades de venta', 'DPC', 'Docena de piezas', NOW(), NOW()),
((SELECT UUID()),'Unidades de empaque',	'XLT',	'Lote', NOW(), NOW());

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