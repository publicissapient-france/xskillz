INSERT INTO Company VALUES (1, 'Xebia');
INSERT INTO Company VALUES (2, 'WeScale');
INSERT INTO Company VALUES (3, 'Thiga');

INSERT INTO Domain VALUES (1, 'Agile', 1);
INSERT INTO Domain VALUES (2, 'Craft', 1);
INSERT INTO Domain VALUES (3, 'Mobile', 1);
INSERT INTO Domain VALUES (4, 'Back', 1);
INSERT INTO Domain VALUES (5, 'Cloud', 1);
INSERT INTO Domain VALUES (6, 'Devops', 1);
INSERT INTO Domain VALUES (7, 'Data', 1);

INSERT INTO Domain VALUES (9, 'Méthodo', 3);
INSERT INTO Domain VALUES (10, 'Métier', 3);
INSERT INTO Domain VALUES (11, 'Digital', 3);

INSERT INTO Domain VALUES (12, 'Loisirs', 1);
INSERT INTO Domain VALUES (13, 'Loisirs', 2);
INSERT INTO Domain VALUES (14, 'Loisirs', 3);


INSERT INTO Role VALUES (1, 'Manager', 1);
INSERT INTO Role VALUES (2, 'Manager', 2);
INSERT INTO Role VALUES (3, 'Manager', 3);

INSERT INTO User (company_id, diploma, email, name) VALUES (1, '2006-01-01', 'jsmadja@xebia.fr', 'Julien Smadja');