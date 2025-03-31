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


-- ============================== PREPARE UPDATE HISTORY ================================
-- prepare history update
set _history_line = json_object("upload date", format("%s:%s", date(), time()), 
                                "version", format("v%s", :Version),
                                "date", :Date,
                                "user", $_username,
                                "file", $new_filepath,
                                "comments", :Comment);

-- get current history
set _db_upload_history = select upload_history from documents where id=:id;
set _upload_history = IFNULL($_db_upload_history, json_array())

-- append new line
-- https://stackoverflow.com/a/78424978
set _new_history = json_insert($_upload_history, '$[#]', $_history_line);

-- ============================== PREPARE DOCUMENT LOG ================================
-- prepare history update
set _log_line = json_object("date", format("%s:%s", date(), time()), 
                            "action", "upload document",
                            "details", format("version %s, dated %s (file %s))", :Version, :Date, $new_filepath),
                            "user", $_username);

-- get current history
set _db_log = select action_log from documents where id=:id;
set _log = IFNULL($_db_log, json_array())

-- append new line
-- https://stackoverflow.com/a/78424978
set _new_log = json_insert($_log, '$[#]', $_log_line);
 
-- ============================== UPDATE DATABASE =======================================
-- update document
update documents
set 
    current_version_filepath = $new_filepath,
    current_version = :Version,
    current_version_date = :Date,
    current_version_upload_date = DATE(),
    current_version_user = $_username,
    upload_history = $_new_history,
    action_log = $_new_log
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