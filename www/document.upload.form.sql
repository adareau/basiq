select 'list' as component;
select
    'Back to index'   as title
    , 'index.sql'     as link
    , 'arrow-back-up' as icon
;

---------- TITLE
SELECT 
    'title'            AS component,
    'Upload a document file'   AS contents;

select 
    'text'              as component,
    'Upload a file for the following document' as contents;

--------- DOCUMENT 

SELECT 'table' AS component, 'action' AS markdown;
SELECT
    format('atomQTRL-DOC-%03d', id) AS reference,
    title, 
    author, 
    date 
FROM documents
WHERE id=$id;


select 
    'form'                          as component,
    'document.upload.action.sql'    as action;

select 
    'file' as type, 
    'DocumentFile' as name,
    TRUE as required;

select 
    'hidden'      as type,
    'id' as name,
     $id  as value;