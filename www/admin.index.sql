-- ==============================  LOGIN  =======================================
-- $_curpath and $_session_required are required for header_shell_session.sql.

set _curpath = sqlpage.path();
set _session_required = 1;
set _required_level = 100;

SELECT
    'dynamic' AS component,
    sqlpage.run_sql('auth.header.shell-session.sql') AS properties,
    sqlpage.run_sql('header.shell.sql') AS properties;

-- ============================== CONTENT =======================================

select 
    'hero'    as component,
    'Administration Panel' as title,
    'Here will be the admin panel' as description;