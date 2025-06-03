CREATE TABLE log (
    --- manual entries / informations
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    action TEXT,
    error BOOLEAN DEFAULT FALSE,
    details TEXT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
);
