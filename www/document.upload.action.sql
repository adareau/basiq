-- ==============================  LOGIN  =======================================
-- $_curpath and $_session_required are required for header_shell_session.sql.

set _curpath = sqlpage.path();
set _session_required = 1;
set _required_level = 10;

select
    'dynamic' as component,
    sqlpage.run_sql('auth.header.shell-session.sql') as properties;

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
set fname = format('%s-v%s_%s:%s.pdf', $fname_base, :Version, date(), time());
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
     
-- ============================== APPLY WATERMARK =======================================

set _ = sqlpage.exec('./scripts/post_upload');

-- ============================== CONTENT =======================================
select
    'redirect' as component,
    'document.list.sql?upload_success=1&docid=' || $id || '&fname=' || sqlpage.url_encode($fname) as link;