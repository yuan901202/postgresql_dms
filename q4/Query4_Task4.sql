SELECT BankName, City FROM Robberies WHERE Date = (SELECT MIN(Date) From Robberies);