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

select
    'dynamic' as component,
    sqlpage.run_sql('auth.header.shell-session.sql') as properties,
    sqlpage.run_sql('header.shell.sql') AS properties;


-- ============================== CONTENT =======================================


---------- NAVIGATION

select 'list' as component;
select
    'Back to document list'   as title
    , 'document.list.sql'     as link
    , 'arrow-back-up' as icon
;

---------- TITLE
select 
    'title'            as component,
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
    (select json_group_array(json_object('label', name, 'value', name)) from (
        select name from projects
        order by name collate NOCASE
      )) as options;

select
    'Type' as name, 
    'Type' as label,
    'select' as type,
    (select type from documents where id=$id) as value,
    (select json_group_array(json_object('label', name, 'value', name)) from (
        select name from document_types
        order by name collate NOCASE
      )) as options;


select 
    'Comments'   as name,
    'Comments'   as label,
    (select comment from documents where id=$id) as value,
    'textarea' as type;