
CREATE DATABASE LibaryDatabaseProject


--member's table


CREATE TABLE members
(
    id INT IDENTITY(1, 1) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(255) UNIQUE NULL,
    phone_number VARCHAR(20) UNIQUE NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    [password] VARCHAR(255) NOT NULL,
    membership_end_date DATE NULL,
    membership_start_date DATE NOT NULL,
    PRIMARY KEY (id),
);



--member's address table

create Table member_address
(
    id INT IDENTITY(1, 1) NOT NULL,
    street_number INT NOT NULL,
    street_address VARCHAR(200) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    member_id INT NOT NULL,
    postcode VARCHAR(50) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (member_id) REFERENCES members(id),
);




-- author's table

CREATE TABLE authors
(
    id INT IDENTITY(1, 1) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NULL,
    phone_number VARCHAR(20) UNIQUE NULL,
    date_of_birth DATE NOT NULL,
    PRIMARY KEY (id),
);



-- author's address table

create Table author_address
(
    id INT IDENTITY(1, 1) NOT NULL,
    street_number INT NOT NULL,
    street_address VARCHAR(200) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    author_id INT NOT NULL,
    postcode VARCHAR(50) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (author_id) REFERENCES authors(id),
);


--catalog table

CREATE TABLE catalog
(
    id INT IDENTITY(1, 1) NOT NULL,
    title VARCHAR(255) NOT NULL,
    status_date DATE NULL,
    [type] VARCHAR(50) CHECK ([type] IN('Journal', 'DVD', 'Book', 'Other Media')) NOT NULL,
    year_of_publication DATE NOT NULL,
    date_added DATE NOT NULL,
    [status] VARCHAR(50) CHECK 
    (
        [status] IN('On Loan', 'Overdue', 'Available', 'Lost', 'Removed')
    )
        NOT NULL,
    isbn VARCHAR(13) NULL,
    issn VARCHAR(10) NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (author_id) REFERENCES authors(id),
);


-- loan table

CREATE TABLE loans
(
    id INT IDENTITY(1, 1) NOT NULL,
    member_id INT NOT NULL,
    item_id INT NOT NULL,
    taken_out DATE NOT NULL,
    [status] VARCHAR(20) CHECK (status IN('Returned', 'Not-Returned')),
    due_back DATE NOT NULL,
    returned DATE NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (member_id) REFERENCES members(id),
    FOREIGN KEY (item_id) REFERENCES catalog(id),
);





-- loan fine table

CREATE TABLE loan_fine
(
    id INT IDENTITY(1, 1) NOT NULL,
    member_id INT NOT NULL,
    loan_id INT NOT NULL,
    total_fines MONEY NOT NULL DEFAULT 0.00,
    PRIMARY KEY (id),
    FOREIGN KEY (member_id) REFERENCES members(id),
    FOREIGN KEY (loan_id) REFERENCES loans(id),
);
---- member's total fine table


CREATE TABLE member_total_fine
(
    id INT IDENTITY(1, 1) NOT NULL,
    member_id INT NOT NULL,
    outstanding_balance MONEY NOT NULL DEFAULT 0.00,
    total_fines MONEY NOT NULL DEFAULT 0.00,
    amount_repaid MONEY NOT NULL DEFAULT 0.00,
    PRIMARY KEY (id),
    FOREIGN KEY (member_id) REFERENCES members(id)
);

-- fine payment table

CREATE TABLE fine_payment
(
    id INT IDENTITY(1, 1) NOT NULL,
    member_id INT NOT NULL,
    loan_id INT NOT NULL,
    payment_method VARCHAR(50) CHECK (payment_method  
    IN('Internet banking','Credit cards','Transfer')) NOT NULL,
    amount_paid MONEY NOT NULL DEFAULT 0.00,
    PRIMARY KEY (id),
    FOREIGN KEY (member_id) REFERENCES members(id),
    FOREIGN KEY (loan_id) REFERENCES loans(id)
);





-- procedure to insert member

GO
CREATE PROCEDURE insertMember
    @full_name VARCHAR(100),
    @date_of_birth DATE,
    @email VARCHAR(255),
    @username VARCHAR(50),
    @password VARCHAR(255),
    @membership_start_date DATE,
    @membership_end_date DATE = NULL,
    @phone_number VARCHAR(20)
AS
BEGIN
    INSERT INTO members
        (
        full_name, date_of_birth, email,
        username, password, phone_number, membership_start_date,
        membership_end_date
        )
    VALUES
        (
            @full_name, @date_of_birth,
            @email,
            @username, @password, @phone_number,
            @membership_start_date,
            @membership_end_date
        )
END
GO


-- EXEC insertMember 'Sarah Lee', '1992-11-07', 'sarahlee@example.com', 'slee', 'password111', '2022-02-01', NULL, '555-555-5558';
-- EXEC insertMember 'David Lee', '1989-02-14', 'davidlee@example.com', 'dlee', 'password222', '2022-02-01', '2023-01-31', '555-555-5559';
-- EXEC insertMember 'Lisa Kim', '1995-06-20', 'lisakim@example.com', 'lkim', 'password333', '2022-02-01', NULL, '555-555-5560';
-- EXEC insertMember 'Mike Smith', '1980-09-30', 'mikesmith@example.com', 'msmith', 'password444', '2022-03-01', NULL, '555-555-5561';
-- EXEC insertMember 'Emily Davis', '1993-04-12', 'emilydavis@example.com', 'edavis', 'password555', '2022-03-01', NULL, '555-555-5562';
-- EXEC insertMember 'Tom Johnson', '1979-12-25', 'tjohnson@example.com', 'tjohnson', 'password666', '2022-03-01', NULL, '555-555-5563';
-- EXEC insertMember 'Amy Chen', '1997-08-08', 'amychen@example.com', 'achen', 'password777', '2022-04-01', NULL,  '555-555-5564';
-- EXEC insertMember 'John Smith', '1990-05-12', 'johnsmith@example.com', 'jsmith', 'password123', '2022-01-01', NULL, '555-555-5555';
-- EXEC insertMember 'Jane Doe', '1985-08-25', 'janedoe@example.com', 'jdoe', 'password456', '2022-01-01', '2022-12-31', '555-555-5556';
-- EXEC insertMember 'Bob Johnson', '1975-03-17', 'bjohnson@example.com', 'bjohnson', 'password789', '2022-01-01', '2023-01-31', '555-555-5557';


SELECT * FROM members;

--- insert member's address procedure

GO
CREATE PROCEDURE insertMemberAddressProcedure
    @member_id int,
    @street_number int,
    @street_address varchar(200),
    @city varchar(100),
    @state varchar(100),
    @postcode varchar(50)
AS
BEGIN
    INSERT INTO member_address
        (member_id, street_number, street_address, city, state, postcode)
    VALUES
        (@member_id, @street_number, @street_address, @city, @state, @postcode)
END
GO


-- -- Member 1 address
-- EXEC insertMemberAddressProcedure 1, 123, 'Main St', 'New York', 'NY', '10001';
-- -- Member 2 address
-- EXEC insertMemberAddressProcedure 2, 456, 'Broadway', 'New York', 'NY', '10002';
-- -- Member 3 address
-- EXEC insertMemberAddressProcedure 3, 789, 'Park Ave', 'New York', 'NY', '10003';
-- -- Member 4 address
-- EXEC insertMemberAddressProcedure 4, 321, 'Lexington Ave', 'New York', 'NY', '10004';
-- -- Member 5 address
-- EXEC insertMemberAddressProcedure 5, 654, '5th Ave', 'New York', 'NY', '10005';
-- -- Member 6 address
-- EXEC insertMemberAddressProcedure 6, 987, 'Madison Ave', 'New York', 'NY', '10006';
-- -- Member 7 address
-- EXEC insertMemberAddressProcedure 7, 741, 'Park Ave South', 'New York', 'NY', '10007';
-- -- Member 8 address
-- EXEC insertMemberAddressProcedure 8, 852, '7th Ave', 'New York', 'NY', '10008';
-- -- Member 9 address
-- EXEC insertMemberAddressProcedure 9, 369, 'Lexington Ave', 'New York', 'NY', '10009';
-- -- Member 10 address
-- EXEC insertMemberAddressProcedure 10, 159, 'Broadway', 'New York', 'NY', '10010';


-- SELECT m.full_name, m.email, a.street_number, a.street_address, a.city, a.state, a.postcode
-- FROM members m
-- JOIN member_address a ON m.id = a.member_id;



-- insert author procedure

GO
CREATE PROCEDURE insertAuthor
    @first_name VARCHAR(100),
    @last_name VARCHAR(100),
    @date_of_birth DATE,
    @email VARCHAR(255),
    @phone_number VARCHAR(20)
AS
BEGIN
    INSERT INTO authors
        (
        first_name ,
        last_name , date_of_birth,
        email,
        phone_number
        )
    VALUES
        (
            @first_name ,
            @last_name ,
            @date_of_birth,
            @email,
            @phone_number
        )
END
GO

-- EXEC insertAuthor 'Bob', 'Johnson', '1975-03-17', 'bjohnson@example.com', '555-555-5557';

---insert address author

GO
CREATE PROCEDURE insertAuthorAddressProcedure
    @author_id int,
    @street_number int,
    @street_address varchar(200),
    @city varchar(100),
    @state varchar(100),
    @postcode varchar(50)
AS
BEGIN
    INSERT INTO author_address
        (author_id, street_number, street_address, city, state, postcode)
    VALUES
        (@author_id, @street_number, @street_address, @city, @state, @postcode)
END
GO



--procedure to update member

GO
CREATE PROCEDURE updateMemberInformation
    @member_id INT,
    @full_name VARCHAR(100),
    @date_of_birth DATE,
    @email VARCHAR(255) = NULL,
    @username VARCHAR(50),
    @password VARCHAR(255),
    @membership_start_date DATE,
    @membership_end_date DATE = NULL,
    @phone_number VARCHAR(20) = NULL
AS
BEGIN
    UPDATE members
    SET    full_name = @full_name, date_of_birth = @date_of_birth, 
           email = @email,
           username = @username, password = @password,
           membership_start_date = @membership_start_date, 
           membership_end_date = @membership_end_date, phone_number = @phone_number
    WHERE id = @member_id
END
GO


--update member's procedure
--  EXEC updateMemberInformation 10, 'sharun khan', '1975-03-17', 'sharunkhan@example.com', 'bjohnson', 'password789', '2022-01-01', '2023-01-31', '555-555-4456';

-- SELECT m.full_name, m.email, a.street_number, a.street_address, a.city, a.state, a.postcode
-- FROM members m
-- JOIN member_address a ON m.id = a.member_id;

-- procedure to insert item to catalog

GO
CREATE PROCEDURE insertItemCatalog
    @title VARCHAR(255),
    @year_of_publication DATE,
    @date_added DATE,
    @author_id INT,
    @status VARCHAR(50),
    @type VARCHAR(50),
    @isbn VARCHAR(13) = NULL,
    @issn VARCHAR(10) = NULL
AS
BEGIN
    INSERT INTO catalog
        (
        title, year_of_publication, date_added, author_id,
        status, type,
        isbn, issn
        )
    VALUES
        (
            @title, @year_of_publication,
            @date_added, @author_id, @status,
            @type, @isbn, @issn
        )
END
GO



-- -- Item 1
-- EXEC insertItemCatalog 'The Great Gatsby', '1925-04-10', '2022-01-01', 1, 'Available', 'Book', '978-3-16-148410-0', NULL;

-- -- Item 2
-- EXEC insertItemCatalog 'To Kill a Mockingbird', '1960-07-11', '2022-01-01', 1, 'On Loan', 'Book', '978-0-06-112008-4', NULL;

-- -- Item 3
-- EXEC insertItemCatalog '1984', '1949-06-08', '2022-01-02', 1, 'Available', 'Book', '978-0-14-103614-4', NULL;

-- -- Item 4
-- EXEC insertItemCatalog 'The Lord of the Rings', '1954-07-29', '2022-01-03', 1, 'On Loan', 'Book', '978-0-618-57465-7', NULL;

-- -- Item 5
-- EXEC insertItemCatalog 'The Catcher in the Rye', '1951-07-16', '2022-01-03', 1, 'Available', 'Book', '978-0-316-76956-7', NULL;

-- -- Item 6
-- EXEC insertItemCatalog 'The Hobbit', '1937-09-21', '2022-01-04', 1, 'On Loan', 'Book', '978-0-618-26030-0', NULL;

-- -- Item 7
-- EXEC insertItemCatalog 'The Chronicles of Narnia', '1950-10-16', '2022-01-05', 1, 'Available', 'Book', '978-0-00-719647-3', NULL;

-- -- Item 8
-- EXEC insertItemCatalog 'The Da Vinci Code', '2003-03-18', '2022-01-06', 1, 'Available', 'Book', '978-0-385-50420-8', NULL;

-- -- Item 9
-- EXEC insertItemCatalog 'The Alchemist', '1988-01-01', '2022-01-07', 1, 'On Loan', 'Book', '978-0-06-112241-5', NULL;

-- -- Item 10
-- EXEC insertItemCatalog 'The Hitchhiker''s Guide to the Galaxy', '1979-10-12', '2022-01-08', 1, 'Available', 'Book', '978-0-330-25864-8', NULL;

-- select * from [catalog]









-- procedure to insert loan


GO
CREATE PROCEDURE insertIntoLoans
    @member_id INT,
    @item_id INT,
    @taken_out DATE,
    @due_back DATE,
    @returned DATE = NULL,
    @status VARCHAR(20)
AS
BEGIN
    INSERT INTO loans
        (
        member_id, item_id, taken_out,
        due_back, returned, status
        )
    VALUES
        (
            @member_id, @item_id, @taken_out,
            @due_back, @returned, @status
        )
END
GO


-- EXEC insertIntoLoans 1, 13, '2023-04-17', '2023-04-20', NULL, 'Not-Returned';
-- EXEC insertIntoLoans 2, 15, '2023-04-16', '2023-04-21', NULL, 'Not-Returned';
-- EXEC insertIntoLoans 3, 17, '2023-04-15', '2023-04-22', NULL, 'Not-Returned';
-- EXEC insertIntoLoans 4, 20, '2023-04-15', '2023-04-23', NULL, 'Not-Returned';

-- SELECT * FROM loans;


-- procedure to insert due payment

GO
CREATE PROCEDURE makeDuePayment
    @member_id INT,
    @loan_id INT,
    @amount_paid DECIMAL,
    @payment_method VARCHAR(50)
AS
BEGIN
    INSERT INTO  fine_payment
        (
        member_id, loan_id,
        amount_paid, payment_method
        )
    VALUES
        (
            @member_id, @loan_id,
            @amount_paid, @payment_method
        )
END
GO





---2A

GO
CREATE PROCEDURE searchCatalogItem
    @title VARCHAR(255)
AS
BEGIN
    SELECT *
    FROM catalog
    WHERE title LIKE '%' + @title + '%'
    ORDER BY year_of_publication DESC;
END;
GO

-- EXEC searchCatalogItem 'To Kill a Mockingbird';





---2B

GO
CREATE PROCEDURE loansAlmostDueIn5daysTime
AS
BEGIN
    SELECT *
    FROM loans
    WHERE status = 'Not-Returned' AND due_back <= DATEADD(day, 5, GETDATE());
END;
GO

-- EXEC loansAlmostDueIn5daysTime


---3

GO
CREATE VIEW loanHistory
AS
    SELECT
        l.id AS loan_id,
        c.title,
        l.taken_out,
        l.due_back,
        l.returned,
        lf.total_fines
    FROM
        loans as l
        INNER JOIN catalog as c ON l.item_id = c.id
        LEFT JOIN loan_fine as lf ON l.id = lf.loan_id
GO

SELECT * FROM loanHistory;



GO
CREATE PROCEDURE updateLoanStatus
    @loan_id INT,
    @returned DATE = NULL,
    @status VARCHAR(20)
AS
BEGIN
    UPDATE loans
    SET    
    returned = @returned,
    status = @status
    WHERE item_id = @loan_id
END
GO

-- EXEC updateLoanStatus 13, '2023-04-17', 'Returned'



--4
GO
CREATE TRIGGER updateCatalogStatus
ON loans
AFTER UPDATE
AS
BEGIN
    IF UPDATE(returned)
    BEGIN
        UPDATE catalog
        SET status = 'Available'
        FROM catalog
            INNER JOIN inserted ON catalog.id = inserted.item_id
        WHERE inserted.returned IS NOT NULL;
    END
END;
GO



-- Select * FROM loans;







---5

SELECT COUNT(*) AS 'number of total item loans'
FROM loans
WHERE taken_out = '2023-04-17';

