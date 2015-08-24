need postgresql;

REVOKE CONNECT ON DATABASE robbersdb FROM PUBLIC;

CREATE TABLE BANKS (
       BankName CHAR(50) NOT NULL,
       City CHAR(50) NOT NULL,
       NoAccounts INT NOT NULL DEFAULT 0 CONSTRAINT atleastzero CHECK (NoAccounts >= 0),
       Security CHAR(15) NOT NULL CONSTRAINT checksecurity CHECK (Security IN ('excellent', 'very good', 'good', 'weak')),
       CONSTRAINT bpk PRIMARY KEY (BankName, City)
);

CREATE TABLE ROBBERIES (
       BankName CHAR(50) NOT NULL,
       City CHAR(50) NOT NULL,
       Date DATE NOT NULL,
       Amount DECIMAL(15,2) NOT NULL CONSTRAINT atleastzero CHECK (Amount >= 0),
       CONSTRAINT rbpk PRIMARY KEY (BankName, City, Date),
       CONSTRAINT rbfk FOREIGN KEY (BankName, City) REFERENCES BANKS (BankName, City) ON DELETE CASCADE
);

CREATE TABLE PLANS (
       BankName CHAR(50) NOT NULL,
       City CHAR(50) NOT NULL,
       NoRobbers INT NOT NULL CONSTRAINT atleastzero CHECK (NoRobbers >= 0),
       PlannedDate DATE NOT NULL,
       CONSTRAINT ppk PRIMARY KEY (BankName, City, PlannedDate),
       CONSTRAINT pfk FOREIGN KEY (BankName, City) REFERENCES BANKS (BankName, City) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE ROBBERS (
       RobberId SERIAL PRIMARY KEY,
       Nickname CHAR(50) NOT NULL,
       Age INT NOT NULL CONSTRAINT atleastzero CHECK (Age >= 0),
       NoYears INT NOT NULL CONSTRAINT prisonyears CHECK (NoYears <= Age AND NoYears >= 0)
);

CREATE TABLE SKILLS (
       SkillId SERIAL PRIMARY KEY,
       Description TEXT UNIQUE
);

CREATE TABLE HASSKILLS (
       RobberId INT NOT NULL,
       SkillId INT NOT NULL,
       Preference INT NOT NULL CONSTRAINT prefvalue CHECK (Preference BETWEEN 1 AND 3),
       Grade CHAR(2) NOT NULL CONSTRAINT graderange CHECK (Grade IN ('A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C')),
       CONSTRAINT hspk PRIMARY KEY (RobberId, SkillId),
       CONSTRAINT hsrifk FOREIGN KEY (RobberId) REFERENCES ROBBERS (RobberId) ON DELETE RESTRICT,
       CONSTRAINT hssifk FOREIGN KEY (SkillId) REFERENCES SKILLS (SkillId) ON DELETE RESTRICT,
       UNIQUE (RobberId, Preference)
);

CREATE TABLE HASACCOUNTS (
       RobberId INT NOT NULL,
       BankName CHAR(50) NOT NULL,
       City CHAR(50) NOT NULL,
       CONSTRAINT hapk PRIMARY KEY (RobberId, BankName, City),
       CONSTRAINT hafp FOREIGN KEY (BankName, City) REFERENCES BANKS (BankName, City) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE ACCOMPLICES (
       RobberId INT NOT NULL,
       BankName CHAR(50) NOT NULL,
       City CHAR(50) NOT NULL,
       RobberyDate DATE NOT NULL,
       Share DECIMAL(15,2) NOT NULL CONSTRAINT atleastzero CHECK (Share >= 0),
       CONSTRAINT apk PRIMARY KEY (RobberId, BankName, City, RobberyDate),
       CONSTRAINT arifk FOREIGN KEY (RobberId) REFERENCES ROBBERS (RobberId) ON UPDATE CASCADE ON DELETE RESTRICT,
       CONSTRAINT abncfk FOREIGN KEY (BankName, City) REFERENCES BANKS (BankName, City) ON UPDATE CASCADE ON DELETE RESTRICT,
       CONSTRAINT ardfk FOREIGN KEY (BankName, City, RobberyDate) REFERENCES ROBBERIES (BankName, City, Date) ON UPDATE CASCADE ON DELETE RESTRICT
);

\copy BANKS(BankName,City,NoAccounts,Security) FROM ~/Pro1/banks_15.data
\copy ROBBERIES(BankName,City,Date,Amount) FROM ~/Pro1/robberies_15.data
\copy PLANS(BankName,City,PlannedDate,NoRobbers) FROM ~/Pro1/plans_15.data

CREATE TABLE temprobbers (
       Nickname CHAR(50) NOT NULL,
       Age INT NOT NULL,
       NoYears INT NOT NULL
);

\copy temprobbers(Nickname,Age,NoYears) FROM ~/Pro1/robbers_15.data

INSERT INTO ROBBERS (
       SELECT nextval('robbers_robberid_seq'), * FROM temprobbers
);

DROP TABLE temprobbers;

CREATE TABLE temphasskills (
       Nickname CHAR(50) NOT NULL,
       Description TEXT NOT NULL,
       Preference INT NOT NULL,
       Grade CHAR(2) NOT NULL
);

\copy temphasskills(Nickname,Description,Preference,Grade) FROM ~/Pro1/hasskills_15.data

CREATE VIEW distinctskills AS SELECT DISTINCT Description From temphasskills;

INSERT INTO SKILLS (
       SELECT nextval('skills_skillid_seq'), Description FROM distinctskills
);

DROP VIEW distinctskills;

INSERT INTO HASSKILLS (
       SELECT r.RobberId, s.SkillId, t.Preference, t.Grade FROM ROBBERS r, SKILLS s, temphasskills t WHERE t.Nickname = r.Nickname AND t.Description = s.Description
)

DROP TABLE temphasskills;

CREATE TABLE temphasaccounts (
       Nickname CHAR(50) NOT NULL,
       BankName CHAR(50) NOT NULL,
       City CHAR(50) NOT NULL
);

\copy temphasaccounts(Nickname,BankName,City) FROM ~/Pro1/hasaccounts_15.data

INSERT INTO HASACCOUNTS (
       SELECT r.RobberId, t.BankName, t.City FROM ROBBERS r, temphasaccounts t WHERE t.Nickname = r.Nickname
);

DROP TABLE temphasaccounts;

CREATE TABLE tempaccmplices (
       Nickname CHAR(50) NOT NULL,
       BankName CHAR(50) NOT NULL,
       City CHAR(50) NOT NULL,
       RobberyDate DATE NOT NULL,
       Share DECIMAL(15,2) NOT NULL
);

\copy tempaccmplices(Nickname,BankName,City,RobberyDate,Share) FROM ~/Pro1/accomplices_15.data

INSERT INTO ACCOMPLICES (
       SELECT r.RobberId, t.BankName, t.City, t.RobberyDate, t.Share FROM ROBBERS r, tempaccmplices t WHERE t.Nickname = r.Nickname
);

DROP TABLE tempaccmplices;

DROP TABLE BANKS;
DROP TABLE ROBBERIES;
DROP TABLE PLANS;
DROP TABLE ROBBERS;
DROP TABLE SKILLS;
DROP TABLE HASSKILLS;
DROP TABLE HASACCOUNTS;
DROP TABLE ACCOMPLICES;
