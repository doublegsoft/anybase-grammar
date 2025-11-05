grammar Guidbase;

GUIDBASE_WS:                [ \n\t\r]+ -> channel(HIDDEN);

GUIDBASE_COMMENT:           '/*' .*? '*/' -> channel(HIDDEN);

GUIDBASE_ID:                [a-zA-Z0-9_-]+;

GUIDBASE_QUOTED_STRING:     '"' (~[\r\n"])* '"';

GUIDBASE_PROCESS:           '{' (~('{' | '}'))* '}';

GUIDBASE_PLATFORM
  :   'desktop'
  |   'browser'
  |   'android'
  |   'ios'
  |   'mobile'
  ;

guidbase_id
  :   GUIDBASE_ID ('/' GUIDBASE_ID)*
  |   guidbase_container
  |   guidbase_widget
  ;

guidbase_container
  :   GUIDBASE_ID
  ;

guidbase_widget
  :   GUIDBASE_ID
  ;

guidbase_attr
  :   action='@'? guidbase_id ':' GUIDBASE_QUOTED_STRING
  ;

guidbase_attrs
  :   guidbase_attr (',' guidbase_attr)*
  ;

guidbase_attrs_decl
  :   '(' guidbase_attrs ')'
  ;

guidbase_widget_decl
  :   (guidbase_id (identifier='!!' | required='!')? ':')? guidbase_widget? guidbase_attrs_decl? process=GUIDBASE_PROCESS?
  ;

guidbase_container_decl
  :    (guidbase_id ':')? guidbase_container guidbase_attrs_decl?  process=GUIDBASE_PROCESS? ('<' guidbase_view (',' guidbase_view)* '>')?
  ;

guidbase_view
  :   guidbase_container_decl
  |   guidbase_widget_decl
  ;
    
guidbase_pages
  :   guidbase_container_decl+
  ;
