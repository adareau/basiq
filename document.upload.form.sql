select 'list' as component;
select
    'Back to index'   as title
    , 'index.sql'     as link
    , 'arrow-back-up' as icon
;

select 
    'form'                          as component,
    'document.upload.action.sql'    as action;

select 
    'text' as type, 
    'Title' as name, 
     title as value from documents where id = $id;