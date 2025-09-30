-- Average final grade per university 
SELECT s.university, AVG((e.grades->>'final')::int) 
FROM students s 
JOIN enrollments e ON s.student_id = e.student_id 
WHERE e.grades ? 'final' GROUP BY s.university;

-- Best student per subject
SELECT subject_code, student_id, MAX((grades->>'final')::int) AS best 
FROM enrollments WHERE grades ? 'final' 
GROUP BY subject_code, student_id