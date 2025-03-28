-- ==============================  LOGIN  =======================================
-- $_curpath and $_session_required are required for header_shell_session.sql.

set _curpath = sqlpage.path();
set _session_required = 1;
set _required_level = 10;

SELECT
    'dynamic' AS component,
    sqlpage.run_sql('auth.header.shell-session.sql') AS properties,
    sqlpage.read_file_as_text('shell.json') AS properties;

-- ============================== ACTIONS =======================================

-- ADD PROJECT
insert into document_types (name)
select :DocumentTypeName
where :DocumentTypeName is not null and $action="add";

select 
    'alert'   as component,
    'Success' as title,
    format('DocumentType `%s` successfully added', :DocumentTypeName) as description,
    'check'   as icon,
    'green'   as color,
    True as dismissible
where :DocumentTypeName is not null and $action="add";

-- DELETE PROJECT

set _deleted_doctype = select name 
                       from document_types
                       where id=$id and $id is not null and $action="delete";
delete from document_types
where id=$id and $id is not null and $action="delete";

select 
    'alert'   as component,
    'Success' as title,
    format('Document type `%s` successfully deleted', $_deleted_doctype) as description,
    'check'   as icon,
    'green'   as color,
    True as dismissible
where $id is not null and $action="delete";


-- ============================== CONTENT =======================================

-- PROJECT LIST

SELECT 'title' AS component
    , 2 AS level
    , 'Document types list' AS contents;
select 
    'table' AS component,
    TRUE    as sort,
    TRUE    as search, 
    'action' AS markdown;
SELECT
    id,
    name, 
    format('[Delete](configuration.document-types.sql?action=delete&id=%s)', id) AS action
FROM document_types;


-- ADD PROJECT FORM

select 
    'form'                       as component,
    'add project' as validate,
    'configuration.document-types.sql?action=add'    as action;

select
    'DocumentTypeName' as name,
    'Document type name' as label,
    'text' as type,
    TRUE as required;