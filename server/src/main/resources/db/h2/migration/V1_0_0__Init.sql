--
-- Structure de la table Company
--

CREATE TABLE Company (
  id   BIGINT(20) NOT NULL,
  name VARCHAR(255) DEFAULT NULL
);


-- --------------------------------------------------------

--
-- Structure de la table Domain
--

CREATE TABLE Domain (
  id         BIGINT(20) NOT NULL,
  name       VARCHAR(255) DEFAULT NULL,
  company_id BIGINT(20)   DEFAULT NULL
);


-- --------------------------------------------------------

--
-- Structure de la table Role
--

CREATE TABLE Role (
  id         BIGINT(20) NOT NULL,
  name       VARCHAR(255) DEFAULT NULL,
  company_id BIGINT(20)   DEFAULT NULL
);


-- --------------------------------------------------------

--
-- Structure de la table Skill
--

CREATE TABLE Skill (
  id         BIGINT(20) NOT NULL,
  name       VARCHAR(255) DEFAULT NULL,
  company_id BIGINT(20)   DEFAULT NULL,
  domain_id  BIGINT(20)   DEFAULT NULL
);


-- --------------------------------------------------------

--
-- Structure de la table User
--

CREATE TABLE User (
  id         BIGINT(20) NOT NULL,
  diploma    DATETIME     DEFAULT NULL,
  email      VARCHAR(255) DEFAULT NULL,
  lastLogin  DATETIME     DEFAULT NULL,
  name       VARCHAR(255) DEFAULT NULL,
  company_id BIGINT(20)   DEFAULT NULL,
  manager_id BIGINT(20)   DEFAULT NULL
);


-- --------------------------------------------------------

--
-- Structure de la table UserSkill
--

CREATE TABLE UserSkill (
  id         BIGINT(20) NOT NULL,
  interested BIT(1)     NOT NULL,
  level      INT(11)    DEFAULT NULL,
  updatedAt  DATETIME   DEFAULT NULL,
  skill_id   BIGINT(20) DEFAULT NULL,
  user_id    BIGINT(20) DEFAULT NULL
);


-- --------------------------------------------------------

--
-- Structure de la table User_Role
--

CREATE TABLE User_Role (
  User_id  BIGINT(20) NOT NULL,
  roles_id BIGINT(20) NOT NULL
);


-- --------------------------------------------------------

--
-- Structure de la table User_UserSkill
--

CREATE TABLE User_UserSkill (
  User_id   BIGINT(20) NOT NULL,
  skills_id BIGINT(20) NOT NULL
);


--
-- Index pour les tables exportées
--

--
-- Index pour la table Company
--
ALTER TABLE Company
ADD PRIMARY KEY (id);

--
-- Index pour la table Domain
--
ALTER TABLE Domain
ADD PRIMARY KEY (id);

--
-- Index pour la table Role
--
ALTER TABLE Role
ADD PRIMARY KEY (id);

--
-- Index pour la table Skill
--
ALTER TABLE Skill
ADD PRIMARY KEY (id);

--
-- Index pour la table User
--
ALTER TABLE User
ADD PRIMARY KEY (id);

--
-- Index pour la table UserSkill
--
ALTER TABLE UserSkill
ADD PRIMARY KEY (id);

--
-- Index pour la table User_Role
--
ALTER TABLE User_Role
ADD UNIQUE KEY UK_tc5k40i3kit8944syrd366vy1 (roles_id);

--
-- Index pour la table User_UserSkill
--
ALTER TABLE User_UserSkill
ADD UNIQUE KEY UK_c79slw7f7nh0n8hlahneeboat (skills_id);

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table Role
--
ALTER TABLE Role
ADD FOREIGN KEY (company_id) REFERENCES Company (id);

--
-- Contraintes pour la table Skill
--
ALTER TABLE Skill ADD FOREIGN KEY (domain_id) REFERENCES Domain (id);
ALTER TABLE Skill ADD FOREIGN KEY (company_id) REFERENCES Company (id);

--
-- Contraintes pour la table User
--
ALTER TABLE User ADD FOREIGN KEY (manager_id) REFERENCES User (id);
ALTER TABLE User ADD FOREIGN KEY (company_id) REFERENCES Company (id);

--
-- Contraintes pour la table UserSkill
--
ALTER TABLE UserSkill ADD FOREIGN KEY (user_id) REFERENCES User (id);
ALTER TABLE UserSkill ADD FOREIGN KEY (skill_id) REFERENCES Skill (id);

--
-- Contraintes pour la table User_Role
--
ALTER TABLE User_Role ADD FOREIGN KEY (User_id) REFERENCES User (id);
ALTER TABLE User_Role ADD FOREIGN KEY (roles_id) REFERENCES Role (id);

--
-- Contraintes pour la table User_UserSkill
--
ALTER TABLE User_UserSkill ADD FOREIGN KEY (User_id) REFERENCES User (id);
ALTER TABLE User_UserSkill ADD FOREIGN KEY (skills_id) REFERENCES UserSkill (id);

ALTER TABLE Company ALTER COLUMN id BIGINT(20) NOT NULL AUTO_INCREMENT;
ALTER TABLE Domain ALTER COLUMN id BIGINT(20) NOT NULL AUTO_INCREMENT;
ALTER TABLE Role ALTER COLUMN id BIGINT(20) NOT NULL AUTO_INCREMENT;
ALTER TABLE Skill ALTER COLUMN id BIGINT(20) NOT NULL AUTO_INCREMENT;
ALTER TABLE User ALTER COLUMN id BIGINT(20) NOT NULL AUTO_INCREMENT;
ALTER TABLE UserSkill ALTER COLUMN id BIGINT(20) NOT NULL AUTO_INCREMENT;
