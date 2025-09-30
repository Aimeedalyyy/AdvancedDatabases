-- Expand assignments into rows to get the grades for each assignment for subject ML4001 
SELECT e.subject_code, a->>'name' AS assignment, (a->>'mark')::int AS mark FROM enrollments e CROSS JOIN LATERAL jsonb_array_elements(e.grades->'assignments') a WHERE subject_code = 'ML4001';

-- Extract project marks 
SELECT subject_code, grades#>>'{project,title}' AS project_title, (grades#>>'{project,mark}')::int AS mark FROM enrollments WHERE grades ? 'project';

-- Add exchange flag for all UCD students 
UPDATE students SET profile = profile || '{"exchange": false}' WHERE university = 'UCD';

-- Update a nested grade

-- For student 2 in DB4003, set their final grade inside the grades JSON to 90. 
UPDATE enrollments SET grades = jsonb_set(grades, '{final}', '90') WHERE subject_code = 'DB4003' AND student_id = 2;

-- Remove remarks for enrollments in subject DB4003
UPDATE enrollments SET grades = grades - 'remarks' WHERE subject_code = 'DB4003';

-- Ensure grades are JSON objects 
ALTER TABLE enrollments ADD CONSTRAINT grades_is_object CHECK (jsonb_typeof(grades) = 'object');

-- Ensure final mark between 0–100 
ALTER TABLE enrollments ADD CONSTRAINT final_between CHECK ((grades ? 'final') IS NOT TRUE OR ((grades->>'final')::int BETWEEN 0 AND 100));

