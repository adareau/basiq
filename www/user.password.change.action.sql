-- ==============================  LOGIN  =======================================
-- $_curpath and $_session_required are required for header_shell_session.sql.

set _curpath = sqlpage.path();
set _session_required = 1;
set _required_level = 1;

select
    'dynamic' as component,
    sqlpage.run_sql('auth.header.shell-session.sql') as properties;

-- ============================== CHECK CURRENT PASSWORD ==============================

set _username = (
    select username
    from sessions
    where sqlpage.cookie('session_token') = id
      and created_at > datetime('now', '-1 day')
);

select
    'authentication' as component,
    'user.password.change.sql?wrong_password=1' AS link,
    :CurrentPassword as password,
    (select password_hash
     from accounts
     where username = $_username) as password_hash;

-- ============================== CHECK THAT PASSWORD MATCH ==============================

set password_match = (:NewPassword = :NewPasswordConf)


select
    'redirect' as component,
    'user.password.change.sql?password_mismatch=1' as link
where $password_match is not True;


-- ============================== CHANGE PASSWORD =======================================

update accounts
set password_hash = sqlpage.hash_password(:NewPassword)
where username = $_username;

select
    'redirect' as component,
    'user.password.change.sql?success=1' as link;
