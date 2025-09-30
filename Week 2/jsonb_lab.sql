SET search_path = jsonb_lab;

SELECT name, profile->>'major' AS major, (profile->>'age')::int AS age FROM students;

-- Extract fields as Json and text to illustrate the operator
--no different in visual editor will matter in applications.
SELECT name, profile->'major' AS major_json, profile->>'major' AS major_text FROM students;


-- Extract fields casting age to be type integer
SELECT name, profile->>'major' AS major, (profile->>'age')::int AS age FROM students;

-- Does profile contain exchange info?
SELECT name FROM students WHERE profile ? 'exchange';

-- Subjects with final mark >= 80 where final is cast as an integer
SELECT subject_code, (grades->>'final')::int AS final FROM enrollments WHERE (grades->>'final')::int >= 80;

-- Suppose we are looking for students with languages as part of their profile. We know Alice has a profile with {"languages":["en","fr"]}
-- profile#>'{languages}' → extracts the whole array as JSON.
-- profile#>>'{languages,0}' → navigates into the array (0 = first element) and returns text.

SELECT name, profile#>'{languages}' AS langs_json, profile#>>'{languages,0}' AS first_lang
FROM students
WHERE profile ? 'languages';



