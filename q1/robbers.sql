CREATE TABLE ROBBERS (
       RobberId SERIAL PRIMARY KEY,
       Nickname CHAR(50) NOT NULL,
       Age INT NOT NULL CONSTRAINT atleastzero CHECK (Age >= 0),
       NoYears INT NOT NULL CONSTRAINT prisonyears CHECK (NoYears <= Age AND NoYears >= 0)
); 