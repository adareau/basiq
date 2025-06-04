-- ==============================  LOGIN  =======================================
-- $_curpath and $_session_required are required for header_shell_session.sql.

set _curpath = sqlpage.path();
set _session_required = 1;
set _required_level = 10;

SELECT
    'dynamic' AS component,
    sqlpage.run_sql('auth.header.shell-session.sql') AS properties,
    sqlpage.run_sql('header.shell.sql') AS properties;

-- ============================== ACTIONS =======================================

-- ADD PROJECT
insert into projects (name)
select :ProjectName
where :ProjectName is not null and $action="add";

select 
    'alert'   as component,
    'Success' as title,
    format('Project `%s` successfully added', :ProjectName) as description,
    'check'   as icon,
    'green'   as color,
    True as dismissible
where :ProjectName is not null and $action="add";

-- DELETE PROJECT

set _deleted_project = select name 
                       from projects
                       where id=$id and $id is not null and $action="delete";
delete from projects
where id=$id and $id is not null and $action="delete";

select 
    'alert'   as component,
    'Success' as title,
    format('Project `%s` successfully deleted', $_deleted_project) as description,
    'check'   as icon,
    'green'   as color,
    True as dismissible
where $id is not null and $action="delete";


-- ============================== CONTENT =======================================

-- PROJECT LIST

SELECT 'title' AS component
    , 2 AS level
    , 'Projects list' AS contents;
select 
    'table' AS component,
    TRUE    as sort,
    TRUE    as search, 
    'action' AS markdown;
SELECT
    id,
    name, 
    format('[Delete](configuration.projects.sql?action=delete&id=%s)', id) AS action
FROM projects;


-- ADD PROJECT FORM

select 
    'form'                       as component,
    'add project' as validate,
    'configuration.projects.sql?action=add'    as action;

select
    'ProjectName' as name,
    'Project name' as label,
    'text' as type,
    TRUE as required;