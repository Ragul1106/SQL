CREATE DATABASE loan_db;
USE loan_db;

CREATE TABLE borrowers (
  borrower_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100),
  phone VARCHAR(20)
);

CREATE TABLE loan_types (
  loan_type_id INT PRIMARY KEY AUTO_INCREMENT,
  type_name VARCHAR(50),
  interest_rate DECIMAL(5,2)
);

CREATE TABLE loans (
  loan_id INT PRIMARY KEY AUTO_INCREMENT,
  borrower_id INT,
  loan_type_id INT,
  amount DECIMAL(10,2),
  disbursement_date DATE,
  due_date DATE,
  FOREIGN KEY (borrower_id) REFERENCES borrowers(borrower_id),
  FOREIGN KEY (loan_type_id) REFERENCES loan_types(loan_type_id)
);

CREATE TABLE repayments (
  repayment_id INT PRIMARY KEY AUTO_INCREMENT,
  loan_id INT,
  amount_paid DECIMAL(10,2),
  payment_date DATE,
  next_due_date DATE,
  FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);

INSERT INTO borrowers (name, email, phone)
VALUES
  ('Amit Sharma', 'amit@example.com', '9876543210'),
  ('Neha Rao', 'neha@example.com', '9898989898'),
  ('Ravi Kumar', 'ravi@example.com', '9797979797');
  
  INSERT INTO loan_types (type_name, interest_rate)
VALUES
  ('Home Loan', 6.5),
  ('Personal Loan', 12.0),
  ('Education Loan', 8.0);
  
  INSERT INTO loans (borrower_id, loan_type_id, amount, disbursement_date, due_date)
VALUES
  (1, 1, 500000.00, '2025-01-10', '2026-01-10'),
  (2, 2, 200000.00, '2025-03-15', '2026-03-15'),
  (3, 3, 300000.00, '2025-05-01', '2026-05-01');
  
  INSERT INTO repayments (loan_id, amount_paid, payment_date, next_due_date)
VALUES
  (1, 25000.00, '2025-02-10', '2025-03-10'),
  (1, 25000.00, '2025-03-10', '2025-04-10'),
  (2, 10000.00, '2025-04-01', '2025-05-01'),
  (3, 15000.00, '2025-06-01', '2025-07-01'),
  (3, 15000.00, '2025-07-01', '2025-08-01');
  
  SELECT 
  b.name AS borrower_name,
  SUM(r.amount_paid) AS total_repaid
FROM repayments r
JOIN loans l ON r.loan_id = l.loan_id
JOIN borrowers b ON l.borrower_id = b.borrower_id
GROUP BY b.borrower_id;

SELECT 
  b.name AS borrower_name,
  l.loan_id,
  r.next_due_date
FROM repayments r
JOIN loans l ON r.loan_id = l.loan_id
JOIN borrowers b ON l.borrower_id = b.borrower_id
WHERE r.next_due_date > CURDATE()
ORDER BY r.next_due_date;










