-- ==============================  LOGIN  =======================================
-- $_curpath and $_session_required are required for header_shell_session.sql.

set _curpath = sqlpage.path();
set _session_required = 1;
set _required_level = 100;

-- do not allow to delete admin
select
    'redirect' as component,
    'admin.user.management.sql?delete_admin=1' as link
where $username = "admin";

-- autch
select
    'dynamic' AS component,
    sqlpage.run_sql('auth.header.shell-session.sql') AS properties;
-- ============================== DELETE =======================================

delete from accounts
where username = $username;

select
    'redirect' as component,
    'admin.user.management.sql?delete_success=1&user=' || $username as link;