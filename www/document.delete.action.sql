-- ==============================  LOGIN  =======================================
-- $_curpath and $_session_required are required for header_shell_session.sql.

set _curpath = sqlpage.path();
set _session_required = 1;
set _required_level = 100;

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

-- ============================== DELETE =======================================

DELETE FROM documents WHERE id=$id

-- ============================== POST EVENT IN DOC LOG ================================

-- add info to log table
insert into documents_log (doc_id, action, user, details)
       values ($id, "document deleted", $_username, "");

-- ============================== CONTENT =======================================
select
    'redirect' as component,
    'document.list.sql?delete_success=1&docid=' || $id as link;