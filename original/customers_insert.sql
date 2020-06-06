USE zapatos_rotos;

INSERT  INTO tbl_countries (`name`,`alpha_2_code`,`alpha_3_code`,`id`) VALUES
('Mexico', 	'MX', 	'MEX', 	484),
('Peru', 	'PE', 	'PER', 	604),
('Colombia', 	'CO', 	'COL', 	170),
('Uruguay', 	'UY', 	'URY', 	858),
('Canada', 	'CA', 	'CAN', 	124);

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