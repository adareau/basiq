-- ==============================  LOGIN  =======================================
-- $_curpath and $_session_required are required for header_shell_session.sql.

set _curpath = sqlpage.path();
set _session_required = 1;
set _required_level = 1;

select
    'dynamic' as component,
    sqlpage.run_sql('auth.header.shell-session.sql') as properties,
    sqlpage.run_sql('header.shell.sql') AS properties;

-- ============================== CONTENT =======================================
-- NAVIGATION

select 'list' as component;
select
    'Add a document' as title
    , 'document.edit.form.sql' as link
    , 'file-plus' as icon
;   

-- GET PATTERN

set _pattern = select pattern from ref_pattern where id=0;

-- ALERTS

-- deletion success

select 
    'alert'                    as component,
    'Success !'                as title,
    'rosette-discount-check'   as icon,
    'teal'                     as color,
    True                       as dismissible,
    format("Document '%s' sucessfully deleted", format($_pattern, $docid)) as description
where $delete_success is True;


-- add success

select 
    'alert'                    as component,
    'Success !'                as title,
    'rosette-discount-check'   as icon,
    'teal'                     as color,
    True                       as dismissible,
    format("Document '%s' sucessfully created", format($_pattern, $docid)) as description
where $add_success is True;

select 
    'alert'                    as component,
    'Add a file ?'                as title,
    'upload'   as icon,
    True                       as dismissible,
    format("Click here to upload a document for '%s'", format($_pattern, $docid)) as link_text,
    "document.upload.form.sql?id=" || $docid as link
where $add_success is True;


-- edit success

select 
    'alert'                    as component,
    'Success !'                as title,
    'rosette-discount-check'   as icon,
    'teal'                     as color,
    True                       as dismissible,
    format("Document '%s' sucessfully edited", format($_pattern, $docid)) as description
where $edit_success is True;

-- upload success

select 
    'alert'                    as component,
    'Success !'                as title,
    'rosette-discount-check'   as icon,
    'teal'                     as color,
    True                       as dismissible,
    format("Document '%s' sucessfully uploaded with name '%s'", format($_pattern, $docid), $fname) as description
where $upload_success is True;


-- LIST
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