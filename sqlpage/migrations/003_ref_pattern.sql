--- ============ REF PATTERN STORAGE ==================
--- this table stores a unique value, used to build the reference pattern
--- cf. https://stackoverflow.com/a/33104119

CREATE TABLE ref_pattern (
    id INTEGER PRIMARY KEY CHECK (id = 0),
    pattern TEXT NOT NULL 
);

-- default value

INSERT OR IGNORE INTO ref_pattern(id, pattern) VALUES
(0, "DOC-%03d");