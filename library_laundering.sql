DROP DATABASE IF EXISTS LibraryDB;
CREATE DATABASE LibraryDB;
USE LibraryDB;

-- =========================================
-- 1. BOOK TABLE
-- =========================================

CREATE TABLE Book (
    ISBN VARCHAR(20) PRIMARY KEY,
    Title VARCHAR(150) NOT NULL,
    Author VARCHAR(100) NOT NULL,
    Publisher VARCHAR(100),
    Year INT,
    Category VARCHAR(50)
);

-- =========================================
-- 2. BOOK COPY TABLE
-- =========================================

CREATE TABLE BookCopy (
    CopyID INT PRIMARY KEY AUTO_INCREMENT,
    ISBN VARCHAR(20) NOT NULL,
    Available BOOLEAN DEFAULT TRUE,
    Shelf VARCHAR(50),
    Section VARCHAR(50),
    FOREIGN KEY (ISBN) REFERENCES Book(ISBN)
);

-- =========================================
-- 3. MEMBER TABLE
-- =========================================

CREATE TABLE Member (
    MemberID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Address VARCHAR(200),
    Phone VARCHAR(20),
    Email VARCHAR(100) UNIQUE,
    MembershipDate DATE NOT NULL
);

-- =========================================
-- 4. LIBRARIAN TABLE
-- =========================================

CREATE TABLE Librarian (
    LibrarianID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    HireDate DATE NOT NULL
);

-- =========================================
-- 5. LOAN TABLE
-- =========================================

CREATE TABLE Loan (
    LoanID INT PRIMARY KEY AUTO_INCREMENT,
    CopyID INT NOT NULL,
    MemberID INT NOT NULL,
    LibrarianID INT NOT NULL,
    BorrowDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    ReturnDate DATE,
    Status VARCHAR(20) DEFAULT 'borrowed',

    FOREIGN KEY (CopyID) REFERENCES BookCopy(CopyID),
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID),
    FOREIGN KEY (LibrarianID) REFERENCES Librarian(LibrarianID),

    CHECK (DueDate >= BorrowDate),
    CHECK (ReturnDate IS NULL OR ReturnDate >= BorrowDate),
    CHECK (Status IN ('borrowed', 'returned', 'overdue'))
);

-- =========================================
-- INSERT BOOK DATA
-- =========================================

INSERT INTO Book
(ISBN, Title, Author, Publisher, Year, Category)
VALUES
('9780131103627', 'The C Programming Language',
 'Brian Kernighan', 'Prentice Hall', 1988, 'Programming'),

('9780132350884', 'Clean Code',
 'Robert Martin', 'Prentice Hall', 2008, 'Programming'),

('9780262033848', 'Introduction to Algorithms',
 'Thomas Cormen', 'MIT Press', 2009, 'Algorithms'),

('9780134685991', 'Effective Java',
 'Joshua Bloch', 'Addison-Wesley', 2018, 'Java'),

('9780596007126', 'Head First Design Patterns',
 'Eric Freeman', 'O Reilly', 2004, 'Programming'),

('9781491950357', 'Designing Data-Intensive Applications',
 'Martin Kleppmann', 'O Reilly', 2017, 'Database'),

('9780321573513', 'Database System Concepts',
 'Abraham Silberschatz', 'McGraw Hill', 2019, 'Database'),

('9780134494166', 'Operating System Concepts',
 'Abraham Silberschatz', 'Wiley', 2018, 'Operating Systems'),

('9780135166307', 'Computer Networks',
 'Andrew Tanenbaum', 'Pearson', 2019, 'Networking'),

('9780131101630', 'Python Programming',
 'Mark Lutz', 'O Reilly', 2013, 'Python');

-- =========================================
-- INSERT BOOK COPY DATA
-- =========================================

INSERT INTO BookCopy
(ISBN, Available, Shelf, Section)
VALUES
('9780131103627', TRUE, 'A1', 'Programming'),
('9780131103627', TRUE, 'A2', 'Programming'),

('9780132350884', TRUE, 'B1', 'Programming'),
('9780132350884', TRUE, 'B2', 'Programming'),

('9780262033848', TRUE, 'C1', 'Algorithms'),
('9780262033848', TRUE, 'C2', 'Algorithms'),

('9780134685991', TRUE, 'D1', 'Java'),
('9780134685991', TRUE, 'D2', 'Java'),

('9780596007126', TRUE, 'E1', 'Programming'),

('9781491950357', TRUE, 'F1', 'Database'),

('9780321573513', TRUE, 'G1', 'Database'),
('9780321573513', TRUE, 'G2', 'Database'),

('9780134494166', TRUE, 'H1', 'Operating Systems'),

('9780135166307', TRUE, 'I1', 'Networking'),

('9780131101630', TRUE, 'J1', 'Python');

-- =========================================
-- INSERT MEMBER DATA
-- =========================================

INSERT INTO Member
(FirstName, LastName, Address, Phone, Email, MembershipDate)
VALUES
('Rahul', 'Kumar', 'Mangalagiri', '9876543210',
 'rahul@gmail.com', '2026-01-10'),

('Arun', 'Reddy', 'Vijayawada', '9876501234',
 'arun@gmail.com', '2026-02-15'),

('Priya', 'Sharma', 'Guntur', '9876512345',
 'priya@gmail.com', '2026-03-05'),

('Kiran', 'Rao', 'Amaravati', '9876523456',
 'kiran@gmail.com', '2026-03-12'),

('Anjali', 'Patel', 'Tenali', '9876534567',
 'anjali@gmail.com', '2026-04-01'),

('Vikram', 'Singh', 'Hyderabad', '9876545678',
 'vikram@gmail.com', '2026-04-10'),

('Sneha', 'Reddy', 'Guntur', '9876556789',
 'sneha@gmail.com', '2026-05-02'),

('Ravi', 'Kumar', 'Vijayawada', '9876567890',
 'ravi@gmail.com', '2026-05-15');

-- =========================================
-- INSERT LIBRARIAN DATA
-- =========================================

INSERT INTO Librarian
(Name, Email, HireDate)
VALUES
('Suresh', 'suresh@library.com', '2024-06-01'),

('Priya', 'priya@library.com', '2025-01-15'),

('Ramesh', 'ramesh@library.com', '2024-08-10'),

('Divya', 'divya@library.com', '2025-03-20');

-- =========================================
-- INSERT LOAN DATA
-- =========================================

INSERT INTO Loan
(CopyID, MemberID, LibrarianID, BorrowDate, DueDate, ReturnDate, Status)
VALUES
(1, 1, 1, '2026-08-20', '2026-09-03', NULL, 'overdue'),

(3, 2, 2, '2026-09-01', '2026-09-15', NULL, 'borrowed'),

(5, 3, 1, '2026-08-25', '2026-09-08', '2026-09-05', 'returned'),

(7, 4, 3, '2026-08-28', '2026-09-11', NULL, 'borrowed'),

(9, 5, 2, '2026-08-15', '2026-08-29', '2026-08-27', 'returned'),

(10, 6, 4, '2026-09-02', '2026-09-16', NULL, 'borrowed'),

(11, 7, 1, '2026-08-10', '2026-08-24', '2026-08-22', 'returned'),

(13, 8, 3, '2026-08-30', '2026-09-13', NULL, 'borrowed');

-- =========================================
-- UPDATE BOOK COPY AVAILABILITY
-- =========================================

UPDATE BookCopy
SET Available = FALSE
WHERE CopyID IN (1, 3, 7, 10, 13);

-- =========================================
-- QUERY 1: DISPLAY ALL BOOKS
-- =========================================

SELECT *
FROM Book;

-- =========================================
-- QUERY 2: DISPLAY ALL BOOK COPIES
-- =========================================

SELECT *
FROM BookCopy;

-- =========================================
-- QUERY 3: DISPLAY ALL MEMBERS
-- =========================================

SELECT *
FROM Member;

-- =========================================
-- QUERY 4: DISPLAY ALL LIBRARIANS
-- =========================================

SELECT *
FROM Librarian;

-- =========================================
-- QUERY 5: DISPLAY ALL LOANS
-- =========================================

SELECT *
FROM Loan;

-- =========================================
-- QUERY 6: FIND OVERDUE BOOKS
-- =========================================

SELECT
    Loan.LoanID,
    Book.Title,
    Member.FirstName,
    Member.LastName,
    Loan.BorrowDate,
    Loan.DueDate,
    Loan.Status
FROM Loan
JOIN BookCopy
ON Loan.CopyID = BookCopy.CopyID
JOIN Book
ON BookCopy.ISBN = Book.ISBN
JOIN Member
ON Loan.MemberID = Member.MemberID
WHERE Loan.ReturnDate IS NULL
AND Loan.DueDate < CURDATE();

-- =========================================
-- QUERY 7: DISPLAY AVAILABLE BOOKS
-- =========================================

SELECT
    Book.ISBN,
    Book.Title,
    Book.Author,
    BookCopy.CopyID,
    BookCopy.Shelf,
    BookCopy.Section
FROM Book
JOIN BookCopy
ON Book.ISBN = BookCopy.ISBN
WHERE BookCopy.Available = TRUE;

-- =========================================
-- QUERY 8: MEMBER LOAN HISTORY
-- =========================================

SELECT
    Member.MemberID,
    Member.FirstName,
    Member.LastName,
    Book.Title,
    Loan.BorrowDate,
    Loan.DueDate,
    Loan.ReturnDate,
    Loan.Status
FROM Loan
JOIN Member
ON Loan.MemberID = Member.MemberID
JOIN BookCopy
ON Loan.CopyID = BookCopy.CopyID
JOIN Book
ON BookCopy.ISBN = Book.ISBN
ORDER BY Member.MemberID, Loan.BorrowDate DESC;

-- =========================================
-- QUERY 9: COUNT BOOKS BY CATEGORY
-- =========================================

SELECT
    Category,
    COUNT(*) AS TotalBooks
FROM Book
GROUP BY Category;

-- =========================================
-- QUERY 10: COUNT MEMBERS
-- =========================================

SELECT COUNT(*) AS TotalMembers
FROM Member;

-- =========================================
-- QUERY 11: COUNT AVAILABLE COPIES
-- =========================================

SELECT COUNT(*) AS AvailableCopies
FROM BookCopy
WHERE Available = TRUE;