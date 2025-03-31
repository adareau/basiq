-- ==============================  LOGIN  =======================================
-- $_curpath and $_session_required are required for header_shell_session.sql.

set _curpath = sqlpage.path();
set _session_required = 1;
set _required_level = 1;

select
    'dynamic' as component,
    sqlpage.run_sql('auth.header.shell-session.sql') as properties,
    sqlpage.read_file_as_text('shell.json') as properties;

-- ============================== CONTENT =======================================

select 'list' as component;
select
    'Add a document' as title
    , 'document.add.form.sql' as link
    , 'file-plus' as icon
;   

set _pattern = select pattern from ref_pattern where id=0;
set _view_pattern = "[%s](document.view.sql?id=%s)"
select 
    'table' as component,
    'PDF' as markdown,
    True as search, 
    False as small,
    True as sort,
    'Title' as markdown,
    'actions' as markdown;
select
    format($_pattern, id) as reference, -- TODO put ref string in table
    format($_view_pattern, title, id) as "Title", 
    project, 
    author_name as "Author",
    author_org as "Org.", 
    if(current_version_filepath is null, "No PDF", format('[PDF](%s)', current_version_filepath)) as pdf, 
    format('[Edit](document.edit.form.sql?id=%s)', id) as actions,
    format('| [Upload](document.upload.form.sql?id=%s)', id) as actions,
    format('| [Delete](document.delete.form.sql?id=%s)', id) as actions
from documents;