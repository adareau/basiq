--- ============ PROJECTS ==================
--- store a list of projects

CREATE TABLE projects (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE
);

-- insert one project

INSERT OR IGNORE INTO projects(name) VALUES
("Project #1");

--- ============ DOCUMENT TYPES ==================
--- store a list of documents types

CREATE TABLE document_types (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE
);

-- insert one document

INSERT OR IGNORE INTO document_types(name) VALUES
("Document");