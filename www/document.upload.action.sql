-- ==============================  LOGIN  =======================================
-- $_curpath and $_session_required are required for header_shell_session.sql.

set _curpath = sqlpage.path();
set _session_required = 1;
set _required_level = 10;

SELECT
    'dynamic' AS component,
    sqlpage.run_sql('auth.header.shell-session.sql') AS properties,
    sqlpage.read_file_as_text('shell.json') AS properties;

-- ============================== CONTENT =======================================

set filepath = sqlpage.persist_uploaded_file('DocumentFile', 'documents');
set fname = format('atomQTRL-DOC-%03d_%s:%s.pdf', :id, date(), time());
set new_filepath = format('/documents/%s', $fname);
set relative_path_old = format(".%s", $filepath);
set relative_path_new = format(".%s", $new_filepath);
set _ = sqlpage.exec('mv', $relative_path_old, $relative_path_new);

update documents
set filepath = $new_filepath
where id=:id

select 
    'alert'                    as component,
    'Success !!'       as title,
    'rosette-discount-check'                  as icon,
    'teal'                     as color,
    False                       as dismissible,
    format('Document sucessfully uploaded as %s', $fname) as description;
select 
    'index.sql'       as link,
    'Edit document' as title;
select 
    'index.sql'    as link,
    'Back to home' as title,
    'secondary'    as color;