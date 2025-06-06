-- Authentication Fence

set username = (
    SELECT username
    FROM sessions
    WHERE sqlpage.cookie('session_token') = id
      AND created_at > datetime('now', '-1 day') -- require the user to log in again after 1 day
);

SELECT
    'redirect' AS component,
    '/' AS link                                  -- redirect to the front page if the user is logged in
WHERE $username IS NOT NULL;

-- =============================================================================

SELECT
    'dynamic' AS component,
    sqlpage.read_file_as_text('shell.json') AS properties;

-- =============================================================================
-- ================================= Login =====================================
-- =============================================================================

SELECT
    'form'  AS component,
    'Login' AS title,
    'auth.create-session.sql' || ifnull('?path=' || $path, '') AS action;

-- Define form fields

SELECT
    column1 AS name, column2 AS label,
    column3 AS type, column4 AS required
FROM (VALUES
    ('username', 'Username', 'text',     TRUE),
    ('password', 'Password', 'password', TRUE)
);

-- Show alert on failed authentication.

SELECT
    'alert'                 AS component,
    'danger'                AS color,
    'You are not logged in' AS title,
    'Sorry, we could not log you in. Please try again.' AS description
WHERE $error IS NOT NULL;