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
INSERT INTO User (company_id, diploma, email, name) VALUES (1, '2007-01-01', 'blacroix@xebia.fr', 'Benjamin Lacroix');

INSERT INTO Skill (name, company_id, domain_id) VALUES ('Java' ,1, 2);
INSERT INTO Skill (name, company_id, domain_id) VALUES ('Javascript' ,1, 2);
INSERT INTO Skill (name, company_id, domain_id) VALUES ('Scala' ,1, 2);

INSERT INTO Skill (name, company_id, domain_id) VALUES ('Product Management' ,3, 9);

INSERT INTO UserSkill (skill_id, user_id, level, interested) VALUES (1, 1, 3, true);
INSERT INTO UserSkill (skill_id, user_id, level, interested) VALUES (1, 2, 1, false);

INSERT INTO User_Role (user_id, roles_id) VALUES (1, 1);