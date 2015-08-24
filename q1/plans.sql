CREATE TABLE PLANS (
       BankName CHAR(50) NOT NULL,
       City CHAR(50) NOT NULL,
       NoRobbers INT NOT NULL CONSTRAINT atleastzero CHECK (NoRobbers >= 0),
       PlannedDate DATE NOT NULL,
       CONSTRAINT ppk PRIMARY KEY (BankName, City, PlannedDate),
       CONSTRAINT pfk FOREIGN KEY (BankName, City) REFERENCES BANKS (BankName, City) ON DELETE RESTRICT ON UPDATE CASCADE
);
