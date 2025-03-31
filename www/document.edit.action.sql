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

-- ============================== GET DATA =======================================

set _username = (
    SELECT username
    FROM sessions
    WHERE sqlpage.cookie('session_token') = id
      AND created_at > datetime('now', '-1 day')
);

-- ============================== EDIT =======================================

update documents
    set type=$Type,
        project=$Project,
        title=$Title,
        author_org=$AuthorOrg,
        author_name=$AuthorName,
        comment=$Comments,
        last_modification_date=DATE(),
        last_modification_user=$_username
where id = $id;

-- ============================== POST EVENT IN DOC LOG ================================

-- add info to log table
insert into documents_log (doc_id, action, user, details)
       values ($id, "document information edited", $_username, "");

-- ============================== CONTENT =======================================

select 
    'alert'                    as component,
    'Success !!'       as title,
    'rosette-discount-check'                  as icon,
    'teal'                     as color,
    False                       as dismissible,
    'Document sucessfully modified.' as description;
select 
    'document.list.sql'       as link,
    'Back to document list' as title;