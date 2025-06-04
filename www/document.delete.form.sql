-- ==============================  LOGIN  =======================================
-- $_curpath and $_session_required are required for header_shell_session.sql.

set _curpath = sqlpage.path();
set _session_required = 1;
set _required_level = 100;

SELECT
    'dynamic' AS component,
    sqlpage.run_sql('auth.header.shell-session.sql') AS properties,
    sqlpage.run_sql('header.shell.sql') AS properties;

-- ============================== CONTENT =======================================

select 'list' as component;
select
    'Back to index'   as title
    , 'index.sql'     as link
    , 'arrow-back-up' as icon
;

---------- TITLE
SELECT 
    'title'            AS component,
    'Delete a document'   AS contents;

select 
    'text'              as component,
    'You are about to delelete the following document ' as contents;

--------- DOCUMENT 

SET _pattern = SELECT pattern from ref_pattern where id=0;

SELECT 'table' AS component, 'action' AS markdown;
SELECT
    format($_pattern, id) AS reference,
    title, 
    author_name, 
    creation_date 
FROM documents
WHERE id=$id;

--------- CONFIRM DELETION 

select 
    'alert'                    as component,
    'Confirm deletion'       as title,
    'warning'                  as icon,
    'red'                     as color,
    False                       as dismissible,
    'Do you want to delete this document ?' as description;
select 
    format('document.delete.action.sql?id=%s', $id)  as link,
    'YES' as title;
select 
    'index.sql'    as link,
    'NO' as title,
    'secondary'    as color;