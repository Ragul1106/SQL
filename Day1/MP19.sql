CREATE DATABASE exam_db;
USE exam_db;

CREATE TABLE students (
  student_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  class VARCHAR(20) NOT NULL
);

CREATE TABLE subjects (
  subject_id INT PRIMARY KEY AUTO_INCREMENT,
  subject_name VARCHAR(100) NOT NULL,
  teacher_id INT
);

CREATE TABLE teachers (
  teacher_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  subject_specialization VARCHAR(100)
);

CREATE TABLE marks (
  mark_id INT PRIMARY KEY AUTO_INCREMENT,
  student_id INT,
  subject_id INT,
  marks_obtained INT,
  exam_date DATE,
  FOREIGN KEY (student_id) REFERENCES students(student_id),
  FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

INSERT INTO students (name, class)
VALUES
  ('Arjun R', '10A'),
  ('Meena S', '10A'),
  ('Rahul V', '10A'),
  ('Divya K', '10B');
  
  INSERT INTO teachers (name, subject_specialization)
VALUES
  ('Mr. Ravi', 'Maths'),
  ('Ms. Anu', 'Science'),
  ('Mr. Vivek', 'English');
  
  INSERT INTO subjects (subject_name, teacher_id)
VALUES
  ('Maths', 1),
  ('Science', 2),
  ('English', 3);
  
  INSERT INTO marks (student_id, subject_id, marks_obtained, exam_date)
VALUES
  (1, 1, 85, '2025-07-01'),
  (2, 1, 90, '2025-07-01'),
  (3, 1, 78, '2025-07-01'),
  (4, 1, 88, '2025-07-01'),

  (1, 2, 92, '2025-07-02'),
  (2, 2, 81, '2025-07-02'),
  (3, 2, 76, '2025-07-02'),
  (4, 2, 89, '2025-07-02'),

  (1, 3, 74, '2025-07-03'),
  (2, 3, 85, '2025-07-03'),
  (3, 3, 91, '2025-07-03'),
  (4, 3, 80, '2025-07-03');
  
  SELECT 
  s.name AS student_name,
  AVG(m.marks_obtained) AS average_marks
FROM marks m
JOIN students s ON m.student_id = s.student_id
GROUP BY m.student_id
ORDER BY average_marks DESC;

SELECT 
  sub.subject_name,
  stu.name AS student_name,
  m.marks_obtained,
  RANK() OVER (PARTITION BY m.subject_id ORDER BY m.marks_obtained DESC) AS subject_rank
FROM marks m
JOIN students stu ON m.student_id = stu.student_id
JOIN subjects sub ON m.subject_id = sub.subject_id
ORDER BY sub.subject_name, subject_rank;









