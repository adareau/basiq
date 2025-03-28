-- ==============================  LOGIN  =======================================
-- $_curpath and $_session_required are required for header_shell_session.sql.

set _curpath = sqlpage.path();
set _session_required = 1;
set _required_level = 10;

SELECT
    'dynamic' AS component,
    sqlpage.run_sql('auth.header.shell-session.sql') AS properties,
    sqlpage.read_file_as_text('shell.json') AS properties;

-- ============================== GET DATA =======================================

set _username = (
    SELECT username
    FROM sessions
    WHERE sqlpage.cookie('session_token') = id
      AND created_at > datetime('now', '-1 day')
);

SET _pattern = SELECT pattern from ref_pattern where id=0;

-- ============================== UPLOAD =======================================

set filepath = sqlpage.persist_uploaded_file('DocumentFile', 'documents');
set fname_base = format($_pattern, :id)
set fname = format('%s_%s:%s.pdf', $fname_base, date(), time());
set new_filepath = format('/documents/%s', $fname);
set relative_path_old = format("./www/%s", $filepath);
set relative_path_new = format("./www/%s", $new_filepath);
set _ = sqlpage.exec('mv', $relative_path_old, $relative_path_new);

-- ============================== UPDATE DATABASE =======================================

update documents
set 
    current_version_filepath = $new_filepath,
    current_version_upload_date = DATE(),
    current_version_user = $_username
where id=:id

-- ============================== CONTENT =======================================
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