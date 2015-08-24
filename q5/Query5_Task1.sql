SELECT RobberId, Nickname FROM Robbers NATURAL JOIN(select RobberId FROM Accomplices GROUP BY RobberId Having COUNT(RobberId)>((SELECT COUNT(RobberId) FROM Accomplices)/(SELECT COUNT(DISTINCT RobberId) FROM Accomplices))) as Actives NATURAL JOIN (SELECT RobberId, SUM(Share) AS Earning FROM Accomplices GROUP BY RobberId) As Earnings WHERE NoYears = 0 ORDER BY Earning DESC;