-- ==============================  LOGIN  =======================================
-- $_curpath and $_session_required are required for header_shell_session.sql.

set _curpath = sqlpage.path();
set _session_required = 1;
set _required_level = 0;

SELECT
    'dynamic' AS component,
    sqlpage.run_sql('auth.header.shell-session.sql') AS properties,
    sqlpage.read_file_as_text('shell.json') AS properties;

-- ============================== CONTENT =======================================


SELECT 'title' AS component
    , 2 AS level
    , 'Documents' AS contents;

SELECT 'list' AS component;
SELECT
    'See all documents' AS title
    , 'document.list.sql' AS link
    , 'list' AS icon
;
SELECT
    'Add a document' AS title
    , 'document.add.form.sql' AS link
    , 'file-plus' AS icon
;

SELECT 'title' AS component
    , 2 AS level
    , 'Base configuration' AS contents;

SELECT 'list' AS component;
SELECT
    'Edit projects' AS title
    , 'configuration.projects.sql' AS link
    , 'settings' AS icon
;
SELECT
    'Edit types' AS title
    , 'configuration.types.form.sql' AS link
    , 'settings' AS icon
;

