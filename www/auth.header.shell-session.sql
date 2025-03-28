-- =============================================================================
-- Checks for the availablity of an active session and redirects to the login
-- page, if necessary. Using a customized shell_ex component, shows "user" and
-- login/logout buttons appropriately in the top-right corner.
--
-- Note, any additonal "shell" component settings must also be included here in
-- the same component. It may require extending this script in a flexible way or
-- creating a page-specific copy, which is less desirable, as it would cause code
-- duplication.
--
-- ## Usage
--
-- Execute this script via
--
-- ```sql
-- SELECT
--     'dynamic' AS component,
--     sqlpage.run_sql('header_shell_session.sql') AS properties;
-- ```
--
-- at the top of the page script, but AFTER setting the required variables
--
-- ```sql
-- set _curpath = sqlpage.path();
-- set _session_required = 1;
-- set _shell_enabled = 1;
-- ```
--
-- ## Reuired SET Variables
--
-- $_curpath
--  - indicates redirect target passed to the login script
-- $_session_required
--  - 1 - require valid active session for non-public pages
--  - 0 - ignore active session for public pages
-- $_shell_enabled
--  - 1 - execute the shell component in this script (default, if not defined)
--  - 0 - do not execute the shell component in this script
--    Define this value to use page-specific shell component.
--    It id also necessary for no-GUI pages, which are called via a redirect and
--    normally redirect back after the necessary processing is completed. Such
--    pages may still require this script to check for active session, but they
--    will not be able to redirect back if this script outputs GUI buttons.

-- =============================================================================
-- ======================= Check required variables ============================
-- =============================================================================
--
-- Set default values (for now) for required variables.
-- Probably should instead show appropriate error messages and abort rendering.

set _curpath = ifnull($_curpath, '/');
set _session_required = ifnull($_session_required, 1);
set _shell_enabled = ifnull($_shell_enabled, 1);

-- =============================================================================
-- ========================= Check active session ==============================
-- =============================================================================
--
-- Check if session is available.
-- Require the user to log in again after 1 day

set _username = (
    SELECT username
    FROM sessions
    WHERE sqlpage.cookie('session_token') = id
      AND created_at > datetime('now', '-1 day')
);

-- Redirect to the login page if the user is not logged in.
-- Unprotected pages must
-- set _session_required = (SELECT FALSE);
-- before running this script

SELECT
    'redirect' AS component,
    '/auth.login.sql?path=' || $_curpath AS link
WHERE $_username IS NULL AND $_session_required;