--------- DELETE 

DELETE FROM documents WHERE id=$id

--------- BACK

select 
    'alert'                    as component,
    'Success !!'       as title,
    'rosette-discount-check'                  as icon,
    'teal'                     as color,
    False                       as dismissible,
    'Document sucessfully deleted.' as description;
select 
    'index.sql'       as link,
    'Back to index' as title;