CREATE DATABASE library_db;
USE library_db;

CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author VARCHAR(100),
    total_copies INT DEFAULT 1,
    available_copies INT DEFAULT 1
);

CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE borrowings (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    book_id INT,
    borrow_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

INSERT INTO members (name, email) VALUES
('Alice', 'alice@example.com'),
('Bob', 'bob@example.com'),
('Cathy', 'cathy@example.com'),
('David', 'david@example.com'),
('Eva', 'eva@example.com'),
('Frank', 'frank@example.com'),
('Grace', 'grace@example.com'),
('Henry', 'henry@example.com'),
('Ivy', 'ivy@example.com'),
('Jake', 'jake@example.com');

INSERT INTO books (title, author, total_copies, available_copies) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 5, 3),
('1984', 'George Orwell', 4, 2),
('To Kill a Mockingbird', 'Harper Lee', 6, 5),
('The Catcher in the Rye', 'J.D. Salinger', 3, 2),
('Pride and Prejudice', 'Jane Austen', 4, 4),
('Moby-Dick', 'Herman Melville', 2, 1),
('The Hobbit', 'J.R.R. Tolkien', 5, 4),
('Harry Potter', 'J.K. Rowling', 6, 5),
('The Alchemist', 'Paulo Coelho', 3, 2),
('The Book Thief', 'Markus Zusak', 2, 2);

INSERT INTO borrowings (member_id, book_id, borrow_date, due_date, return_date) VALUES
(1, 1, '2025-07-01', '2025-07-10', NULL), 
(2, 2, '2025-07-05', '2025-07-15', '2025-07-13'), 
(3, 3, '2025-07-08', '2025-07-18', NULL), 
(1, 4, '2025-07-12', '2025-07-22', NULL), 
(4, 5, '2025-07-10', '2025-07-20', '2025-07-18'); 

SELECT b.title, br.borrow_date, br.due_date
FROM borrowings br
JOIN books b ON br.book_id = b.book_id
JOIN members m ON br.member_id = m.member_id
WHERE m.name = 'Alice';

SELECT b.title, COUNT(br.borrow_id) AS borrow_count
FROM borrowings br
JOIN books b ON br.book_id = b.book_id
GROUP BY b.title
ORDER BY borrow_count DESC
LIMIT 5;