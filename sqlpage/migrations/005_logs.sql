--- ============ LOGS FOR DOCUMENTS ENTRIES ==================

CREATE TABLE documents_log (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    doc_id INTEGER NOT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    action TEXT NOT NULL,
    user TEXT NOT NULL,
    details TEXT NOT NULL
);


--- ============ LOGS FOR UPLOADS ==================

CREATE TABLE uploads_log (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    doc_id INTEGER NOT NULL,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    version TEXT NOT NULL,
    date TEXT NOT NULL,
    user TEXT NOT NULL,
    file TEXT NOT NULL,
    comments TEXT NOT NULL
);