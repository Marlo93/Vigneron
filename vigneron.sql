INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('society_vigne', 'Vigneron', 1);

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
('society_vigne', 'Vigneron', 1);

INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
('society_vigne', 'Vigneron', 1);

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
('grape', 'Raisin', 1, 0, 1),
('wine', 'Vin rouge', -1, 0, 1);

INSERT INTO `jobs` (`name`, `label`) VALUES
('vigne', 'Vigneron');

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('vigne', 0, 'recruit', 'Recrue', 12, '{}', '{}'),
('vigne', 1, 'experimente', 'Experimente', 36, '{}', '{}'),
('vigne', 2, 'chief', 'Chef d\'équipe', 48, '{}', '{}'),
('vigne', 3, 'boss', 'Patron', 0, '{}', '{}');