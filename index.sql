SELECT 'list' AS component;
SELECT
    'Add a document' AS title
    , 'document.add.form.sql' AS link
    , 'file-plus' AS icon
;

SELECT 'table' AS component, 'action' AS markdown;
SELECT *,
    format('[Edit](edit.sql?id=%s)', id) AS action
FROM documents;