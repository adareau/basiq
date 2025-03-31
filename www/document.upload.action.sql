-- ==============================  LOGIN  =======================================
-- $_curpath and $_session_required are required for header_shell_session.sql.

set _curpath = sqlpage.path();
set _session_required = 1;
set _required_level = 10;

select
    'dynamic' as component,
    sqlpage.run_sql('auth.header.shell-session.sql') as properties,
    sqlpage.read_file_as_text('shell.json') as properties;

-- ============================== GET DATA =======================================

set _username = (
    select username
    from sessions
    where sqlpage.cookie('session_token') = id
      and created_at > datetime('now', '-1 day')
);

SET _pattern = select pattern from ref_pattern where id=0;

-- ============================== UPLOAD =======================================

set filepath = sqlpage.persist_uploaded_file('DocumentFile', 'documents');
set fname_base = format($_pattern, :id)
set fname = format('%s_%s:%s.pdf', $fname_base, date(), time());
set new_filepath = format('/documents/%s', $fname);
set relative_path_old = format("./www/%s", $filepath);
set relative_path_new = format("./www/%s", $new_filepath);
set _ = sqlpage.exec('mv', $relative_path_old, $relative_path_new);


-- ============================== UPDATE DATABASE =======================================
-- update document
update documents
set 
    current_version_filepath = $new_filepath,
    current_version = :Version,
    current_version_date = :Date,
    current_version_upload_date = DATE(),
    current_version_user = $_username
where id=:id

-- ============================== POST EVENT IN DOC LOG ================================

-- add info to log table
insert into documents_log (
    doc_id, 
    action, 
    user, 
    details
) values (
    $id, 
    "pdf uploaded", 
    $_username, 
    format("version %s, dated %s, file: %s", :Version, :Date, $new_filepath)
);
     
-- ============================== ADD TO UPLOAD LOG ================================

-- add info to log table
insert into uploads_log (
    doc_id, 
    version,
    date, 
    user,
    file, 
    comments
) values (
    $id, 
    :Version,
    :Date,
    $_username, 
    $new_filepath,
    :Comment
);
     

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