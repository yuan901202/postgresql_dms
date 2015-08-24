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