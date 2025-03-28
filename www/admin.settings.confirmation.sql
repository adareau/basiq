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
-- modif link
set _modif_link = format("admin.settings.update.sql?ref_pattern=%s", sqlpage.url_encode(:RefPattern))

-- alert 
select 
    'alert'                     as component,
    'Warning: danger zone'                   as title,
    'You are about to make the following changes' as description,
    'alert-triangle'            as icon,
    'yellow'                    as color;
select 
    $_modif_link  as link,
    'confirm changes' as title;
select 
    'admin.settings.sql'    as link,
    'Dismiss' as title,
    'secondary'    as color;

-- display changes
set _current_pattern = select pattern from ref_pattern where id = 0
set _current_example = format($_current_pattern, 42)
set _new_example = format(:RefPattern, 42)

set _pattern_modif_display = "
* **OLD value** : '%s' (*ex* : *'%s'*)
* **NEW value** : '%s' (*ex* : *'%s'*)
"
select 
    'list'                 as component,
    TRUE                   as compact,
    'List of modifications' as title;
select 
    'Ref pattern' as title,
    format($_pattern_modif_display, $_current_pattern, $_current_example, :RefPattern, $_new_example) as description_md;


