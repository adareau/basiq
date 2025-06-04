CREATE TABLE sqlpage_shell_config (
    ---
    key TEXT PRIMARY KEY,
    title TEXT,
    link TEXT DEFAULT "/",
    icon TEXT DEFAULT "file-search",
    norobot BOOLEAN default True
);

INSERT OR REPLACE INTO sqlpage_shell_config
VALUES (
    'default'
    , 'Document Database'
    , '/'
    , 'database-star'
    , TRUE
);