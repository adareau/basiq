-- ============================== REDIRECT IF WRONG ID =======================================
-- in case user asks to edit a document that does not exist

set _title = select title from documents where id=$id;
select 'redirect' as component, 
        'document.list.sql' as link
        where $_title is null and $id is not null;


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
    'Edit a document'   AS contents;

select 
    'text'              as component,
    'You are about to modify the following document ' as contents;

--------- OLD DOCUMENT

SET _pattern = SELECT pattern from ref_pattern where id=0;

SELECT 'table' AS component, 'action' AS markdown;
SELECT
    format($_pattern, id) AS reference,
    title as "title", 
    project, 
    author_name as "author",
    author_org as "organization",
    type,
    comment
FROM documents
WHERE id=$id;

--------- NEW
select 
    'text'              as component,
    'With the following information ' as contents;

SELECT 'table' AS component, 'action' AS markdown;
SELECT
    format($_pattern, $id) AS reference,
    :Title as "title", 
    :Project as "Project", 
    :AuthorName as "author",
    :AuthorOrg as "organization",
    :Type as "Type",
    :Comments as "Comment";

--------- CONFIRM MODIF 

set link = format("document.edit.action.sql?id=%s", $id);
set link = $link || "&Project=" || sqlpage.url_encode(:Project);
set link = $link || "&Title=" || sqlpage.url_encode(:Title);
set link = $link || "&AuthorName=" || sqlpage.url_encode(:AuthorName);
set link = $link || "&AuthorOrg=" || sqlpage.url_encode(:AuthorOrg);
set link = $link || "&Type=" || sqlpage.url_encode(:Type);
set link = $link || "&Comments=" || sqlpage.url_encode(:Comments);


select 
    'alert'                    as component,
    'Confirm modification'       as title,
    'warning'                  as icon,
    'red'                     as color,
    False                       as dismissible,
    'Do you want to modify this document ?' as description;
select 
    $link  as link,
    'YES' as title;
select 
    format('document.view.sql?id=%s', $id)    as link,
    'NO' as title,
    'secondary'    as color;