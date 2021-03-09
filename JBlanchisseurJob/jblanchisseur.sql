INSERT INTO `addon_account` (name, label, shared) VALUES 
	('society_blanchisseur','blanchisseur',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
	('society_blanchisseur','blanchisseur',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
	('society_blanchisseur', 'blanchisseur', 1)
;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('blanchisseur', 'Blanchisseur', 1);


INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('blanchisseur', 0, 'boss', 'Boss', 1500, '{}', '{}');