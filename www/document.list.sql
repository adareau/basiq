-- ==============================  LOGIN  =======================================
-- $_curpath and $_session_required are required for header_shell_session.sql.

set _curpath = sqlpage.path();
set _session_required = 1;
set _required_level = 1;

SELECT
    'dynamic' AS component,
    sqlpage.run_sql('auth.header.shell-session.sql') AS properties,
    sqlpage.read_file_as_text('shell.json') AS properties;

-- ============================== CONTENT =======================================

SELECT 'list' AS component;
SELECT
    'Add a document' AS title
    , 'document.add.form.sql' AS link
    , 'file-plus' AS icon
;

SET _pattern = SELECT pattern from ref_pattern where id=0;

SELECT 'table' AS component, 'action' AS markdown;
SELECT
    format($_pattern, id) AS reference, -- TODO put ref string in table
    title, 
    author, 
    date, 
    IF(filepath is null, "No document", format('[Go to document](%s)', filepath)) as action, 
    format('| [Edit](edit.sql?id=%s)', id) AS action,
    format('| [Upload](document.upload.form.sql?id=%s)', id) AS action,
    format('| [Delete](document.delete.form.sql?id=%s)', id) AS action
FROM documents;