-- ==============================  LOGIN  =======================================
-- $_curpath and $_session_required are required for header_shell_session.sql.

set _curpath = sqlpage.path();
set _session_required = 1;
set _required_level = 100;

SELECT
    'dynamic' AS component,
    sqlpage.run_sql('auth.header.shell-session.sql') AS properties,
    sqlpage.read_file_as_text('shell.json') AS properties;

-- ============================== CONTENT =======================================

select 
    'form'                       as component,
    'New User' as title,
    'Create new user' as validate,
    'admin.user.add.action.sql'    as action;

select
    'Username' as name,
    'User name' as label,
    'text' as type,
    TRUE as required;

select
    'Password' as name,
    'Password' as label,
    'password' as type,
    '^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$' as pattern,
    TRUE       as required,
    '**Password Requirements:** Minimum **8 characters**, at least **one letter** & **one number**. *Tip:* Use a passphrase for better security!' as description_md;

select 
    'Rights'             as name,
    'select'            as type,
    '[{"label": "Read only", "value": 0}, {"label": "Edit", "value": 10}, {"label": "Admin", "value": 100}]' as options;