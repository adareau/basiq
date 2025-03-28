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
    'alert'                    as component,
    'Success !!'       as title,
    'rosette-discount-check'                  as icon,
    'teal'                     as color,
    False                       as dismissible,
    'New user successfully created.' as description;
select 
    'admin.index.sql'       as link,
    'Back to admin panel' as title;
select 
    'index.sql'    as link,
    'Back to home' as title,
    'secondary'    as color;

/*
select 'list' as component, 'POST variables' as title,
 'Here is the list of POST variables sent to this page.
 Post variables are accessible with `:variable_name`.' as description_md,
 'No POST variable.' as empty_title;
select key as title, ':' || key || ' = ' || "value" as description
from json_each(sqlpage.variables('post'));

select 'list' as component, 'GET variables' as title,
 'Here is the list of GET variables sent to this page.
 Get variables are accessible with `$variable_name`.' as description_md,
 'No GET variable.' as empty_title;
select key as title, '$' || key || ' = ' || "value" as description
from json_each(sqlpage.variables('get'));

*/