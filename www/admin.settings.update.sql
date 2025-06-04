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
-- update
update ref_pattern
set pattern = $ref_pattern
where $ref_pattern is not null and id = 0;


-- alert 
select 
    'alert'                    as component,
    'Success !!'       as title,
    'rosette-discount-check'                  as icon,
    'teal'                     as color,
    False                       as dismissible,
    'Settings sucessfully updated.' as description;
select 
    'admin.index.sql'       as link,
    'Back to admin panel' as title;
select 
    'index.sql'    as link,
    'Back to home' as title,
    'secondary'    as color;

