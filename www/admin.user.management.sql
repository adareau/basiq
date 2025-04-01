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

-- NAVIGATION
select 'list' as component;
select
    'Create new user' as title
    , 'admin.user.add.form.sql' as link
    , 'user-plus' as icon
;  

-- ALERTS

-- admin deletion warning

select 
    'alert'                     as component,
    'Warning'                   as title,
    'alert-triangle'            as icon,
    'yellow'                    as color,
    True                        as dismissible,
    "Your cannot delete the 'admin' account" as description
where $delete_admin is True;

-- deletion success

select 
    'alert'                    as component,
    'Success !'                as title,
    'rosette-discount-check'   as icon,
    'teal'                     as color,
    True                       as dismissible,
    format("User '%s' sucessfully deleted", $user) as description
where $delete_success is True;

-- add success

select 
    'alert'                    as component,
    'Success !'                as title,
    'rosette-discount-check'   as icon,
    'teal'                     as color,
    True                       as dismissible,
    format("User '%s' sucessfully added", $user) as description
where $add_success is True;

-- LIST

select 
    'table' as component,
    True as search, 
    False as small,
    True as sort,
    'actions' as markdown;
select
    username,
    rights, 
    format('[Delete](admin.user.delete.confirm.sql?username=%s)', username) as actions
from accounts;