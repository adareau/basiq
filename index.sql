SELECT 'list' AS component;
SELECT
    'Add a document' AS title
    , 'document.add.form.sql' AS link
    , 'file-plus' AS icon
;



SELECT 'table' AS component, 'action' AS markdown;
SELECT
    format('atomQTRL-DOC-%03d', id) AS reference,
    title, 
    author, 
    date, 
    format('[Edit](edit.sql?id=%s) | [Upload](document.upload.form.sql?id=%s) | [Delete](document.delete.form.sql?id=%s)', id, id, id) AS action
FROM documents;