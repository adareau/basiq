-- ==============================  LOGIN  =======================================
-- $_curpath and $_session_required are required for header_shell_session.sql.

set _curpath = sqlpage.path();
set _session_required = 1;
set _required_level = 1;

select
    'dynamic' as component,
    sqlpage.run_sql('auth.header.shell-session.sql') as properties,
    sqlpage.run_sql('header.shell.sql') AS properties;

-- ============================== GET DATA =======================================

set _username = (
    SELECT username
    FROM sessions
    WHERE sqlpage.cookie('session_token') = id
      AND created_at > datetime('now', '-1 day')
);


-- ============================== CONTENT =======================================

---------- INFOBOXES

select 
    'alert'                    as component,
    'Success !'                as title,
    'rosette-discount-check'   as icon,
    'teal'                     as color,
    True                       as dismissible,
    "Password sucessfully changed" as description
where $success is True;

select 
    'alert'              as component,
    'Error'              as title,
    'alert-circle'       as icon,
    'red'                as color,
    True                       as dismissible,
    'Wrong password for current user' as description
where $wrong_password is TRUE;

select 
    'alert'              as component,
    'Error'              as title,
    'alert-circle'       as icon,
    'red'                as color,
    True                       as dismissible,
    'Passwords do not match !' as description
where $password_mismatch is TRUE;

---------- TITLE

select 
    'title'            as component,
    'Change user password' as contents;

select 
    'text'              as component,
    'Here you can change the password for the currently logged user : ' || $_username as contents;


---------- FORM

select
    'form' as component,
    'Change password' as validate,
    'user.password.change.action.sql' as action;

select
    'CurrentPassword' as name,
    'Current password' as label,
    'password' as type,
    TRUE       as required;

select
    'NewPassword' as name,
    'New password' as label,
    'password' as type,
    '^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$' as pattern,
    TRUE       as required;

select
    'NewPasswordConf' as name,
    'Confirm new password' as label,
    'password' as type,
    TRUE       as required,
    '**Password Requirements:** Minimum **8 characters**, at least **one letter** & **one number**. *Tip:* Use a passphrase for better security!' as description_md;

