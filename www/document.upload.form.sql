-- ==============================  LOGIN  =======================================
-- $_curpath and $_session_required are required for header_shell_session.sql.

set _curpath = sqlpage.path();
set _session_required = 1;
set _required_level = 10;

SELECT
    'dynamic' AS component,
    sqlpage.run_sql('auth.header.shell-session.sql') AS properties,
    sqlpage.read_file_as_text('shell.json') AS properties;

-- ============================== CONTENT =======================================

select 'list' as component;
select
    'Back to document list'   as title
    , 'document.list.sql'     as link
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

SET _pattern = SELECT pattern from ref_pattern where id=0;

SELECT 'table' AS component, 'file' AS markdown;
SELECT
    format($_pattern, id) AS reference,
    title, 
    author_name as 'author', 
    creation_date as 'created',
    current_version as 'current version',
    if(current_version_filepath is null, "No PDF", format('[PDF](%s)', current_version_filepath)) as 'file',
    current_version_date as 'date', 
    current_version_upload_date as 'uploaded on' 
FROM documents
WHERE id=$id;


select 
    'form'                          as component,
    'document.upload.action.sql'    as action;

select 
    'version' as type, 
    'Version' as name,
    'v' as prefix,
    TRUE as required;

select 
    'date' as type, 
    'Date' as name,
    DATE() as value,
    TRUE as required;

select 
    'file' as type, 
    'DocumentFile' as name,
    TRUE as required;

select 
    'textarea' as type, 
    'Version comment (opt.)' as label, 
    'Comment' as name;

select 
    'hidden'      as type,
    'id' as name,
     $id  as value;