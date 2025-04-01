# Database description

## Document database

name : database
fields :

**Initial entry / manual**  
  * id (int) > primary key
  * type (text) > document type, from 'document_types' database
  * project (text) > project, from 'projects' database
  * title (text) > title
  * author_org (text) > organisation of author
  * author_name (text)
  * comment (long text)

**Initial entry / auto**
  * creation_date (date)
  * creation_user (text)

**modification tracking**
  * last_modification_date (date)
  * last_modification_user (text)
   
**file upload and version**
  * current_version (text) > filled with 'upload'
  * current_version_filepath (text) > path to las version
  * current_version_date (date) > date of last version (user)
  * current_version_upload_date (date) > automatic
  * current version_user (text) > user who uploaded the current version

  * upload_history (text) > json with 'date', 'upload_date', 'version', 'path', 'user' 

**review and validation**
 * review_date
 * review_author
 * review_version (auto)
 * review_history > json 'date', 'version', 'user'

 * validation_date
 * validation_author
 * validation_version
 * validation_history

**log**
 * action log : text

**archive**
 * archived : Bool > only admin can delete !!!


## User database (accounts)
name : accounts
fields :

 * username (text) > primary key
 * passwor_hash
 * rights (int) > 1 read only, 10 edit, 100 admin

## Projects
name : projects
fields :
 * id (int, key)
 * name (text, unique)

## Document types:
name : document_types
fields :
  * id (int, key)
  * name (text, unique)

## Reference pattern
name : ref_pattern
fields : 
    * id (1) : only one entry
    * pattern : text, the pattern

  
