select 'list' as component;
select
    'Back to index'   as title
    , 'index.sql'     as link
    , 'arrow-back-up' as icon
;

--------- DOCUMENT 

SELECT 'table' AS component, 'action' AS markdown;
SELECT
    format('atomQTRL-DOC-%03d', id) AS reference,
    title, 
    author, 
    date 
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