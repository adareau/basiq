-- ==============================  LOGIN  =======================================
-- $_curpath and $_session_required are required for header_shell_session.sql.

set _curpath = sqlpage.path();
set _session_required = 1;
set _required_level = 1;

select
    'dynamic' as component,
    sqlpage.run_sql('auth.header.shell-session.sql') as properties,
    sqlpage.read_file_as_text('shell.json') as properties;


-- ============================== CONTENT =======================================

select 'list' as component;
select
    'Back to document list'   as title
    , 'document.list.sql'     as link
    , 'arrow-back-up' as icon
;

set _pattern = select pattern from ref_pattern where id=0;

--- =====  DOCUMENT INFO BLOCK  =====
select 
    'title'   as component,
    'Document info' as contents,
    2         as level;

select 
    'datagrid' as component,
    title as title
    from documents where id=$id;
select 
    'id' as title,
    $id    as description;
select 
    'Ref' as title,
    format($_pattern, $id)    as description;
select 
    'Author' as title,
    author_name     as description
    from documents where id=$id;
select 
    'Org' as title,
    author_org    as description
    from documents where id=$id;
select 
    'Type' as title,
    type    as description
    from documents where id=$id;
select 
    'Project' as title,
    project    as description
    from documents where id=$id;

--- COMMENT

select 
    'alert'     as component,
    'Comment' as title,
    comment as description,
    'black' as color
    from documents where id=$id and comment <> "";


--- ===== CURRENT FILE =====
select 
    'title'   as component,
    'File versions' as contents,
    2         as level;

select 
    'title'   as component,
    'Current' as contents,
    3         as level;

select 
    'datagrid' as component;
select 
    'Current File' as title,
    if( current_version_filepath is null, 
        "No file >> upload", 
        "Link to PDF"
        ) as description,
    if( current_version_filepath is null, 
        format("document.upload.form.sql?id=%s", $id), 
        current_version_filepath
        ) as link
    from documents where id=$id;
select 
    'Version' as title,
    current_version    as description
    from documents where id=$id;
select 
    'Dated' as title,
    current_version_date    as description
    from documents where id=$id;
select 
    'Uploaded on' as title,
    current_version_upload_date    as description
    from documents where id=$id;
select 
    'By' as title,
    current_version_user    as description
    from documents where id=$id;


--- ===== UPLOADED FILES VERSIONS =====
select 
    'title'   as component,
    'History' as contents,
    3         as level;

select 
    'timeline' as component;
select 
    format("v%s | dated %s | upload by %s", version, date, user) as title,
    file as link,
    timestamp as date,
    comments as description_md

from uploads_log where doc_id=$id
order by timestamp desc;


--- ===== DATABASE ENTRY INFO BLOCK =====

select 
    'title'   as component,
    'Database entry info' as contents,
    2         as level;


select 
    'datagrid' as component;
select 
    'Entry created on' as title,
    creation_date    as description
    from documents where id=$id;
select 
    'By' as title,
    creation_user    as description
    from documents where id=$id;
select 
    'Last modified on' as title,
    last_modification_date    as description
    from documents where id=$id;
select 
    'By' as title,
    last_modification_user    as description
    from documents where id=$id;

--- ===== LOG =====
select 
    'title'   as component,
    'Log' as contents,
    3         as level;
select 
    'list'                 as component,
    False                   as compact;
select
    format("[%s] %s > %s", timestamp, user, action) as title,
    details as description
from documents_log where doc_id=$id
order by timestamp desc;