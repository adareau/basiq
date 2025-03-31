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

select 'list' as component;
select
    'Back to document list'   as title
    , 'document.list.sql'     as link
    , 'arrow-back-up' as icon
;

select 
    'form'                       as component,
    'Create new document entry' as validate,
    'document.add.action.sql'    as action;

select
    'Title' as name,
    'Title' as label,
    'text' as type,
    TRUE as required;

select
    'AuthorName' as name,
    'Author Name' as label,
    'text' as type,
    TRUE as required;

select
    'AuthorOrg' as name,
    'Author Organization' as label,
    'text' as type,
    TRUE as required;

select
    'Project' as name, 
    'Project' as label,
    'select' as type,
    (SELECT json_group_array(json_object('label', name, 'value', name)) FROM (
        SELECT name FROM projects
        ORDER BY name COLLATE NOCASE
      )) AS options;

select
    'Type' as name, 
    'Type' as label,
    'select' as type,
    (SELECT json_group_array(json_object('label', name, 'value', name)) FROM (
        SELECT name FROM document_types
        ORDER BY name COLLATE NOCASE
      )) AS options;


select 
    'Comments'   as name,
    'Comments'   as label,
    'textarea' as type;