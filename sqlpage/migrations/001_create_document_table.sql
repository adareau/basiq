CREATE TABLE documents (
    --- manual entries / informations
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type TEXT NOT NULL,
    project TEXT NOT NULL,
    title TEXT NOT NULL,
    author_org TEXT NOT NULL,
    author_name TEXT NOT NULL,
    comment TEXT,

    --- creation tracking
    creation_date TEXT NOT NULL,
    creation_user TEXT NOT NULL,

    --- modification tracking
    last_modification_date TEXT NOT NULL,
    last_modification_user TEXT NOT NULL,

    -- file upload and versionning
    current_version TEXT,
    current_version_filepath TEXT,
    current_version_date TEXT,
    current_version_upload_date TEXT,
    current_version_user TEXT,
    upload_history TEXT,

    -- review and validation
    review_date TEXT,
    review_author TEXT,
    review_version TEXT,
    review_history TEXT,

    validation_date TEXT,
    validation_author TEXT,
    validation_version TEXT,
    validation_history TEXT,

    -- log
    action_log TEXT,

    -- flags
    archived BOOLEAN DEFAULT FALSE
);