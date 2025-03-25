
select 'list' as component;
select
    'Back to index'   as title
    , 'index.sql'     as link
    , 'arrow-back-up' as icon
;

select 
    'form'                       as component,
    'document.add.action.sql'    as action;

select
    'Title' as name,
    'Document Title' as label,
    'text' as type,
    TRUE as required;

select
    'Author' as name,
    'Document Author' as label,
    'text' as type,
    TRUE as required;

SELECT
    'Reviewed' AS name,
    'Reviewed' AS label,
    'checkbox' AS type,
    FALSE as checked;

-- DATE
select 
    'Date'       as name,
    'Last Version Date' as label,
    'date'       as type,
    DATE()       as value,
    TRUE as required;