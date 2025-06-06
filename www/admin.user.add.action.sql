-- ==============================  LOGIN  =======================================
-- $_curpath and $_session_required are required for header_shell_session.sql.

set _curpath = sqlpage.path();
set _session_required = 1;
set _required_level = 100;

SELECT
    'dynamic' AS component,
    sqlpage.run_sql('auth.header.shell-session.sql') AS properties;

-- ============================== CONTENT =======================================

set _hash_pass = sqlpage.hash_password(:Password)

INSERT INTO accounts (
    username, 
    password_hash,
    rights
)
VALUES(
    :Username, 
    $_hash_pass,
    :Rights
);

select
    'redirect' as component,
    'admin.user.management.sql?add_success=1&user=' || :Username as link;