-- ============================== REDIRECT IF WRONG ID =======================================
-- in case user asks to edit a document that does not exist

set _title = select title from documents where id=$id;
select 'redirect' as component, 
        'document.list.sql' as link
        where $_title is null and $id is not null;

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


---------- NAVIGATION

select 'list' as component;
select
    'Back to document list'   as title
    , 'document.list.sql'     as link
    , 'arrow-back-up' as icon
;

---------- TITLE
SELECT 
    'title'            AS component,
    (select case when $id is not null 
          then "Update a document"
          else "Create a new document" end) as contents;

select 
    'text'              as component,
    (select case when $id is not null 
          then "Please modify document information below"
          else "Please enter document information" end) as contents;

---------- FORM

select 
    'form'                       as component,
    (select case when $id is not null 
          then "Update document information"
          else "Create new document entry" end) as validate,
    (select case when $id is not null 
          then format("document.edit.confirm.sql?id=%s", $id)
          else "document.add.action.sql" end) as action;

select
    'Title' as name,
    'Title' as label,
    'text' as type,
    (select title from documents where id=$id) as value,
    TRUE as required;

select
    'AuthorName' as name,
    'Author Name' as label,
    'text' as type,
    (select author_name from documents where id=$id) as value,
    TRUE as required;

select
    'AuthorOrg' as name,
    'Author Organization' as label,
    'text' as type,
    (select author_org from documents where id=$id) as value,
    TRUE as required;

select
    'Project' as name, 
    'Project' as label,
    'select' as type,
    (select project from documents where id=$id) as value,
    (SELECT json_group_array(json_object('label', name, 'value', name)) FROM (
        SELECT name FROM projects
        ORDER BY name COLLATE NOCASE
      )) AS options;

select
    'Type' as name, 
    'Type' as label,
    'select' as type,
    (select type from documents where id=$id) as value,
    (SELECT json_group_array(json_object('label', name, 'value', name)) FROM (
        SELECT name FROM document_types
        ORDER BY name COLLATE NOCASE
      )) AS options;


select 
    'Comments'   as name,
    'Comments'   as label,
    (select comment from documents where id=$id) as value,
    'textarea' as type;