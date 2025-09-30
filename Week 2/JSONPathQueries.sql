-- Students with any grade (for anything assignment, final etc) >= 85 
SELECT enrollment_id, subject_code 
FROM enrollments 
WHERE jsonb_path_exists(grades, '$.* ? (@ >= 85)');

-- For subject ML4001, show every assignment mark stored in the grades JSON.” 
SELECT jsonb_path_query(grades, '$.assignments[*].mark') 
FROM enrollments WHERE subject_code = 'ML4001';