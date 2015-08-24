CREATE TABLE ROBBERIES (
       BankName CHAR(50) NOT NULL,
       City CHAR(50) NOT NULL,
       Date DATE NOT NULL,
       Amount DECIMAL(15,2) NOT NULL CONSTRAINT atleastzero CHECK (Amount >= 0),
       CONSTRAINT rbpk PRIMARY KEY (BankName, City, Date),
       CONSTRAINT rbfk FOREIGN KEY (BankName, City) REFERENCES BANKS (BankName, City) ON DELETE CASCADE
); 