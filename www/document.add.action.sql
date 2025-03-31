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

-- ============================== PREPARE DOCUMENT LOG ================================
-- prepare history update
set _log_line = json_object("date", format("%s:%s", date(), time()), 
                            "action", "document created",
                            "details", format("version %s, dated %s (file %s))", :Version, :Date, $new_filepath),
                            "user", $_username);

-- initiate a log
set _log = json_array($_log_line);

-- ============================== POST =======================================

INSERT INTO documents (
    title, 
    author_name,
    author_org,
    project,
    type,
    comment,
    creation_date,
    last_modification_date,
    creation_user,
    last_modification_user,
    action_log

)
VALUES(
    :Title, 
    :AuthorName,
    :AuthorOrg,
    :Project,
    :Type,
    :Comments,
    DATE(),
    DATE(),
    $_username,
    $_username,
    $_log
);

-- ============================== CONTENT =======================================
select 
    'alert'                    as component,
    'Success !!'       as title,
    'rosette-discount-check'                  as icon,
    'teal'                     as color,
    False                       as dismissible,
    'Document sucessfully created.' as description;
select 
    'index.sql'       as link,
    'Edit document' as title;
select 
    'document.list.sql'    as link,
    'Back to document list' as title,
    'secondary'    as color;
select 
    'index.sql'    as link,
    'Back to home' as title,
    'secondary'    as color;