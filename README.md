# postgresql_dms
[SWEN304] Building and using relational databases in PostgreSQL

## Goal:
For this project, we will use the PostgreSQL Database Management System to manage the data that provided.

## Data file included in this project:

### banks_15.data 
lists all the bank branches in the Chicago district. The banks are specified by the name of the bank and the city where the branch is located in. The data file also includes the number of accounts held in the bank (an indicator of size) and the level of the security measures installed by the bank.

### robbers_15.data
contains the name (actually, the nickname), age, and number of years spent in prison of each gang member.

### hasaccounts_15.data
lists the banks at which the various robbers have accounts.

### hasskills_15.data
specifies the skills of the robbers. Each robber may have several skills, ranked by preference – what activity the robber prefers to be engaged in. The robbers are also graded on each skill. The file contains a line for each skill of each robber listing the robber’s nickname, the skill description, the preference rank (a number where 1 represents first preference), and the grade.

### robberies_15.data
contains the banks that have been robbed by the gang so far. For each robbery, it lists the bank branch, the date of the robbery, and the amount that was stolen. Note that some banks may have been robbed more than once.

### accomplices_15.data
lists the robbers that were involved in each robbery and their estimated share of the money.

### plans_15.data
contains information from the informant about banks that the gang is planning to rob in the future, along with the planed robbery date and number of gang members that would be needed. Note that gang may plan to rob some banks more than once.

## Tables included in this database:
### Banks
which stores general information about banks, including the number of accounts and the level of security.

Attributes: BankName, City, NoAccounts, Security

### Robberies
which stores information about robberies of banks that the gang has already performed, including how much was stolen. 

Attributes: BankName, City, Date, Amount

### Plans
which stores information about banks that the gang plans to rob.

Attributes: BankName, City, NoRobbers, PlannedDate

### Robbers
which stores information about gang members. Note that it is not possible to be in prison for more years than you have been alive! 

Attributes: RobberId, Nickname, Age, NoYears

### Skills
which stores the possible robbery skills. 

Attributes: SkillId, Description

### HasSkills
which stores information about the skills that particular gang members possess. Each skill of a robber has a preference rank, and a grade. 

Attributes: RobberId, SkillId, Preference, Grade

### HasAccounts
which stores information about the banks where individual gang members have accounts. 

Attributes: RobberId, BankName, City

### Accomplices
which stores information about which gang members participated in each bank robbery, and what share of the money they got. 

Attributes: RobberId, BankName, City, RobberyDate, Share
