SELECT 'list' AS component;
SELECT
    'Add a document' AS title
    , 'document.add.form.sql' AS link
    , 'file-plus' AS icon
;



SELECT 'table' AS component, 'action' AS markdown;
SELECT
    format('atomQTRL-DOC-%03d', id) AS reference, -- TODO put ref string in table
    title, 
    author, 
    date, 
    IF(filepath is null, "No document", format('[Go to document](%s)', filepath)) as action, 
    format('| [Edit](edit.sql?id=%s)', id) AS action,
    format('| [Upload](document.upload.form.sql?id=%s)', id) AS action,
    format('| [Delete](document.delete.form.sql?id=%s)', id) AS action
FROM documents;