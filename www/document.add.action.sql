-- ==============================  LOGIN  =======================================
-- $_curpath and $_session_required are required for header_shell_session.sql.

set _curpath = sqlpage.path();
set _session_required = 1;
set _required_level = 10;

SELECT
    'dynamic' AS component,
    sqlpage.run_sql('auth.header.shell-session.sql') AS properties;

-- ============================== GET DATA =======================================

set _username = (
    SELECT username
    FROM sessions
    WHERE sqlpage.cookie('session_token') = id
      AND created_at > datetime('now', '-1 day')
);

-- ============================== POST =======================================

insert into documents (
    title, 
    author_name,
    author_org,
    project,
    type,
    comment,
    creation_date,
    last_modification_date,
    creation_user,
    last_modification_user

)
values(
    :Title, 
    :AuthorName,
    :AuthorOrg,
    :Project,
    :Type,
    :Comments,
    DATE(),
    DATE(),
    $_username,
    $_username
);


-- ============================== POST EVENT IN DOC LOG ================================

-- get id from
set id = SELECT last_insert_rowid();

-- add info to log table
insert into documents_log (doc_id, action, user, details)
       values ($id, "document created", $_username, "");
     
     
select
    'redirect' as component,
    'document.list.sql?add_success=1&docid=' || $id as link;