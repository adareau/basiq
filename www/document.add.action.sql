-- ==============================  LOGIN  =======================================
-- $_curpath and $_session_required are required for header_shell_session.sql.

set _curpath = sqlpage.path();
set _session_required = 1;
set _required_level = 10;

SELECT
    'dynamic' AS component,
    sqlpage.run_sql('auth.header.shell-session.sql') AS properties,
    sqlpage.read_file_as_text('shell.json') AS properties;

-- ============================== CONTENT =======================================

INSERT INTO documents (
    title, 
    author,
    date,
    is_reviewed
)
VALUES(
    :Title, 
    :Author,
    :Date,
    :Reviewed is not null
);

select 
    'alert'                    as component,
    'Success !!'       as title,
    'rosette-discount-check'                  as icon,
    'teal'                     as color,
    False                       as dismissible,
    'Document sucessfully entered.' as description;
select 
    'index.sql'       as link,
    'Edit document' as title;
select 
    'index.sql'    as link,
    'Back to home' as title,
    'secondary'    as color;