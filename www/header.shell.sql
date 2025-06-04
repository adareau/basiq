select
    'shell' as component,
    sqlpage.read_file_as_text('menu.json') as menu_item,
     null as css,
     *
from sqlpage_shell_config where key="default";
