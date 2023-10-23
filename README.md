# Library-Database-Project

                                                INTRODUCTION


This project was based on a library inventory of items of which there are different types, like books, magazines, journals, and DVDs that may be accessible to the public. The library members or users are registered members of the library and are able to access all items in the form of loans by following the library loan system. The aim of this project is to create a database system to monitor the library item loan process and the registered members of the library.

I provided information, including names, addresses, usernames, a phone number, and an email address, to become a new member of the library. At any time, a member decides that they will no longer renew their library membership at all, even if it is possible to maintain the details of such members to mark them.

If the item you wish to borrow is available in the library’s catalog, you may be granted a loan for that item under your registered library membership. Like any other library system, items borrowed out of the library will have an automatic due date. A fine of 10 pounds per day, 24 hours a day, shall be charged for each item borrowed from the library that has not been returned on the due date.

I also assumed that a payment system will be made available, with functionality to keep track of the library's total fines, amount paid and outstanding balance for each member, which may be used for any loan item using different payment methods. Furthermore, in addition to several other functionalities associated with the 3NF database design process, each item loan return will have an automatic update functionality that is available at any time.

                                              
LIBRARY DATABASE PROJECT TABLES.		

Based on my ER diagram in fig 1.0, I was able to come up with a total number of nine tables, bearing in mind the designing of my proposed database in 3NF according to the library’s design requirement. The tables include:


•	Members Table: The member’s table includes, date of birth, email, full name, the ID, the membership starts date and membership end date, the password with email and phone number which are optional information according to requirements.

•	Member’s address table: This is a table containing the table’s ID, member’s address details, which includes the street number, street address, postcode, state, city and member’s ID.

•	Authors Table: The author’s table record item’s author information which includes, the ID, date of birth, email, phone number, first name, last name.

•	Author’s address table: This is a table containing the table’s ID, member’s address details, which includes the street number, street address, postcode, state, city and member’s ID.

•	Catalog Table: This consist of the library items which are available to the members, the catalogue consists of the ID, the ISBN and ISSN, status, status date, the title and type, along with the year of publication, date added and author’s ID.

•	Loan Table: This table keep track of the library loan item, the loan table keep track of information like, due back, returned, taken out dates, with ID, item ID, member ID and status.

•	Loan fine Table: This table consist of the ID, loan ID, member’s ID and total fines.

•	Member total fine Table: This records the member’s library total loan fine, the table contains the ID member’s ID, amount repaid, outstanding balance, total fine.

•	Fine payment Table: This table consist of the amount paid, the ID, the loan fine ID, fine payment method and member ID.
The Member's table had a one-to-one relationship with the member’s address table, and this meant that an address could be exclusively for each of its members, as well as it was also capable of having no more than one address. A member’s table also shares a one-to-many relationship with a member’s loan fine table.

A member's relationship with the member's total fine table is one-to-one, and vice versa. A member shares a one-to-many relationship with the loan table, and a loan in return can only belong to a single member, which carries the member’s ID. The relationship between a loan and a fine payment table is one-to-one, and the relationship between member and fine payment table is one-to-many

The Author’s address table shares a one-one relationship with the author and vice versa.

     
                                         ADVICE AND GUIDANCE AS A DATABASE CONSULTANT


Database integrity and concurrency:  The integrity of data refers to the general accuracy, completeness and consistency with which it is presented. Data integrity is also related to the safety of data in relation to compliance with regulatory standards, such as General Data Protection Regulation and Security. It is maintained by a collection of processes, rules, and standards implemented during the design phase. The data stored in the database will continue to be complete, accurate and reliable at any time whether it has been retained for a long period of time or accessed on a regular basis when its integrity is guaranteed.

The type of database data integrity includes, physical and logical integrity, physical integrity protects data accuracy. Logical accuracy makes sure the data remains unchanged and its often used in different ways in relational database.

Types of logical integrity includes:

Entity integrity which was achieved in this project through creation of primary keys, unique identifier for each table, this is to make sure data isn’t repeated more than the number of times which is expected.

User-defined integrity which also involves the use of rules and constraints to fit each table needs and client’s need was also put into consideration during the design process

Please note, data integrity shouldn’t be identified as data security.

Concurrency: This is the ability of a database to allow multiple users to interact with it at the same time. Concurrency control protocols which should be adopted for the library database project could include, Lock-Based Protocols, Two Phase Locking Protocol, Timestamp-Based Protocols, Validation-Based Protocols.

Database security: Data protection in the event of unauthorised, deliberate loss, destruction or misuse, to prevent this in our database project appropriate measures are supposed to be put in place, which includes, authorisation, authentication, encryption, granting privileges and by putting in necessary backup and recovery in place.



Database backup and recovery: This is the process of restoring the database back to its initial state in the event of failure. The use of appropriate different backup strategies can be adopted for our library database project, by following the backup and restore of SQL server databases on Microsoft documentation page, and the use of transactions and log files to track commits and changes


  

