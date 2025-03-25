CREATE TABLE documents (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    author TEXT NOT NULL,
    date TEXT NOT NULL,
    is_reviewed BOOLEAN NOT NULL DEFAULT FALSE,
    filepath TEXT
);