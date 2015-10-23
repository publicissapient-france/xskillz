create table UserConnection (
  userId varchar(255) not null,
  providerId varchar(255) not null,
  providerUserId varchar(255),
  rank int not null,
  displayName varchar(255),
  profileUrl varchar(512),
  imageUrl varchar(512),
  accessToken varchar(1024) not null,
  secret varchar(255),
  refreshToken varchar(255),
  expireTime bigint,
  primary key (userId, providerId, providerUserId));
create unique index UserConnectionRank on UserConnection(userId, providerId, rank);


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
ADD CONSTRAINT FKqbkpka79wedf5x3y3njhv7jhf FOREIGN KEY (company_id) REFERENCES Company (id);

--
-- Contraintes pour la table Skill
--
ALTER TABLE Skill
ADD CONSTRAINT FKp3u11et3dob7e60q6j2yysphn FOREIGN KEY (domain_id) REFERENCES Domain (id),
ADD CONSTRAINT FKgdr1sh4epeudbcidarw2t5po3 FOREIGN KEY (company_id) REFERENCES Company (id);

--
-- Contraintes pour la table User
--
ALTER TABLE User
ADD CONSTRAINT FKgftx0lh1vt0vrnovvcq1seprt FOREIGN KEY (manager_id) REFERENCES User (id),
ADD CONSTRAINT FK1w9rdxn4dh1ej5lkpywwbakix FOREIGN KEY (company_id) REFERENCES Company (id);

--
-- Contraintes pour la table UserSkill
--
ALTER TABLE UserSkill
ADD CONSTRAINT FKkper0hfty7ftsrgs76pc3yhtp FOREIGN KEY (user_id) REFERENCES User (id),
ADD CONSTRAINT FKoj68jqbk1jhri30wji2rflx3w FOREIGN KEY (skill_id) REFERENCES Skill (id);

--
-- Contraintes pour la table User_Role
--
ALTER TABLE User_Role
ADD CONSTRAINT FKc52d1rv3ijbpu6lo2v3rej1tx FOREIGN KEY (User_id) REFERENCES User (id),
ADD CONSTRAINT FK7qnwwe579g9frolyprat52l4d FOREIGN KEY (roles_id) REFERENCES Role (id);

--
-- Contraintes pour la table User_UserSkill
--
ALTER TABLE User_UserSkill
ADD CONSTRAINT FK8er77soogtpfnekqi0iabaogf FOREIGN KEY (User_id) REFERENCES User (id),
ADD CONSTRAINT FKo4it4b23he0o19ydls3kqfl4a FOREIGN KEY (skills_id) REFERENCES UserSkill (id);


ALTER TABLE Company CHANGE id id BIGINT(20) NOT NULL AUTO_INCREMENT;
ALTER TABLE Domain CHANGE id id BIGINT(20) NOT NULL AUTO_INCREMENT;
ALTER TABLE Role CHANGE id id BIGINT(20) NOT NULL AUTO_INCREMENT;
ALTER TABLE Skill CHANGE id id BIGINT(20) NOT NULL AUTO_INCREMENT;
ALTER TABLE User CHANGE id id BIGINT(20) NOT NULL AUTO_INCREMENT;
ALTER TABLE UserSkill CHANGE id id BIGINT(20) NOT NULL AUTO_INCREMENT;
