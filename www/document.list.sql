-- ==============================  LOGIN  =======================================
-- $_curpath and $_session_required are required for header_shell_session.sql.

set _curpath = sqlpage.path();
set _session_required = 1;
set _required_level = 1;

select
    'dynamic' AS component,
    sqlpage.run_sql('auth.header.shell-session.sql') AS properties,
    sqlpage.read_file_as_text('shell.json') AS properties;

-- ============================== CONTENT =======================================

select 'list' AS component;
select
    'Add a document' AS title
    , 'document.add.form.sql' AS link
    , 'file-plus' AS icon
;   

set _pattern = select pattern from ref_pattern where id=0;

select 
    'table' AS component,
    'PDF' AS markdown, 
    'actions' AS markdown;
select
    format($_pattern, id) as reference, -- TODO put ref string in table
    title, 
    author_name, 
    creation_date, 
    if(current_version_filepath is null, "No PDF", format('[PDF](%s)', current_version_filepath)) as pdf, 
    format('[Edit](edit.sql?id=%s)', id) AS actions,
    format('| [Upload](document.upload.form.sql?id=%s)', id) as actions,
    format('| [Delete](document.delete.form.sql?id=%s)', id) as actions
from documents;