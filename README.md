Tutorial : https://learnsqlpage.com

Exemple : https://codeberg.org/nanawel/zaibu

https://tabler.io/icons


### For watermark

cf. https://www.makeuseof.com/python-pdf-text-watermark-add/

1) create venv
2) pip install reportlab PyPDF2
3) chown -R sqlpage:user .
4) 

### Delete documents and reset autoincrement

https://stackoverflow.com/a/1601854

delete from documents;    
delete from documents_log;    
delete from sqlite_sequence where name='documents';

