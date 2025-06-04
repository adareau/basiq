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
    sqlpage.run_sql('auth.header.shell-session.sql') AS properties,
    sqlpage.run_sql('header.shell.sql') AS properties;

-- ============================== CONTENT =======================================

select 'list' as component;
select
    'Back to user list'   as title
    , 'admin.user.management.sql'     as link
    , 'arrow-back-up' as icon
;

---------- TITLE
select 
    'title'            as component,
    'Delete a user'   as contents;

select 
    'text'              as component,
    'You are about to delelete the following user ' as contents;

--------- DOCUMENT 


select 'table' as component, 'action' as markdown;
select
    username,
    rights 
from accounts
where username=$username;

--------- CONFIRM DELETION 

select 
    'alert'                    as component,
    'Confirm deletion'       as title,
    'warning'                  as icon,
    'red'                     as color,
    False                       as dismissible,
    'Do you want to delete this user ?' as description;
select 
    format('admin.user.delete.action.sql?username=%s', $username)  as link,
    'YES' as title;
select 
    'admin.user.management.sql'    as link,
    'NO' as title,
    'secondary'    as color;