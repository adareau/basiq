INSERT INTO documents (
    title, 
    author,
    date,
    is_reviewed
)
VALUES(
    :Title, 
    :Author,
    :Date,
    :Reviewed is not null
);

select 
    'alert'                    as component,
    'Success !!'       as title,
    'rosette-discount-check'                  as icon,
    'teal'                     as color,
    False                       as dismissible,
    'Document sucessfully entered.' as description;
select 
    'index.sql'       as link,
    'Edit document' as title;
select 
    'index.sql'    as link,
    'Back to home' as title,
    'secondary'    as color;