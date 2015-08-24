CREATE TABLE BANKS (
       BankName CHAR(50) NOT NULL,
       City CHAR(50) NOT NULL,
       NoAccounts INT NOT NULL DEFAULT 0 CONSTRAINT atleastzero CHECK (NoAccounts >= 0),
       Security CHAR(15) NOT NULL CONSTRAINT checksecurity CHECK (Security IN ('excellent', 'very good', 'good', 'weak')),
       CONSTRAINT bpk PRIMARY KEY (BankName, City)
);