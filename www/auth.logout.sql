SELECT
    'cookie' AS component,
    'session_token' AS name,
    TRUE AS remove;

SELECT
    'redirect' AS component,
    ifnull($path, '/auth.login.sql') AS link    -- redirect to the login page after the user logs out