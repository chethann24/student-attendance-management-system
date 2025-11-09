

DROP TABLE IF EXISTS Attendance;
DROP TABLE IF EXISTS Subjects;
DROP TABLE IF EXISTS Students;

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    branch VARCHAR(50)
);

CREATE TABLE Subjects (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(50)
);

CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    subject_id INT,
    date DATE,
    status ENUM('Present','Absent'),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);

INSERT INTO Students VALUES
(1, 'Ravi', 'CSE'),
(2, 'Divya', 'CSE'),
(3, 'Akash', 'IT');

INSERT INTO Subjects VALUES
(101, 'DBMS'),
(102, 'Java');

INSERT INTO Attendance (student_id, subject_id, date, status) VALUES
(1, 101, '2025-11-09', 'Present'),
(2, 101, '2025-11-09', 'Absent'),
(3, 101, '2025-11-09', 'Present'),
(1, 102, '2025-11-09', 'Present'),
(2, 102, '2025-11-09', 'Present');

-- SHOW TABLES DATA
SELECT * FROM Students;
SELECT * FROM Subjects;
SELECT * FROM Attendance;

-- ATTENDANCE REPORT
SELECT s.name, sub.subject_name, a.date, a.status
FROM Attendance a
JOIN Students s ON a.student_id = s.student_id
JOIN Subjects sub ON a.subject_id = sub.subject_id;

-- ATTENDANCE PERCENTAGE
SELECT s.name,
       COUNT(CASE WHEN a.status='Present' THEN 1 END) * 100 / COUNT(*) AS attendance_percentage
FROM Students s
JOIN Attendance a ON s.student_id = a.student_id
GROUP BY s.student_id;
