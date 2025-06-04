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
    'alert'                     as component,
    'Warning: danger zone'                   as title,
    'Do not modify unless you know what you are doing' as description,
    'alert-triangle'            as icon,
    'yellow'                    as color;

select 
    'form'                       as component,
    'Database settings' as title,
    'Update settings' as validate,
    'admin.settings.confirmation.sql'    as action;

select
    'RefPattern' as name,
    'Ref pattern' as label,
    'text' as type,
    (select pattern from ref_pattern where id=0) as value,
    TRUE as required,
    'Format of the reference. Must contain a placeholder for a int to include the document key (for instance, "%i" or "%03d").' as description_md;
