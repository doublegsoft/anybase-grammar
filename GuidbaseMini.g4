grammar GuidbaseMini;

GUIDBASE_MINI_WS:                [ \n\t\r]+ -> channel(HIDDEN);

GUIDBASE_MINI_ID:                [a-zA-Z_] [a-zA-Z0-9_]*;

GUIDBASE_MINI_DIGIT:             [0-9]+;

GUIDBASE_MINI_INT:               GUIDBASE_MINI_DIGIT+;

guidbase_mini_int
  :   GUIDBASE_MINI_DIGIT
  ;

guidbase_mini_id
  :   GUIDBASE_MINI_ID
  ;

guidbase_mini_object
  :   '(' guidbase_mini_id ')'
  ;  

guidbase_mini_widget
  :   guidbase_mini_id 
      guidbase_mini_object? 
      ('.' width=guidbase_mini_int)? 
      ('*' count=guidbase_mini_int)?
      (guidbase_mini_goto anotherId=guidbase_mini_id)?
  |   guidbase_mini_col
  ;

guidbase_mini_widgets
  :   guidbase_mini_widget ('+' guidbase_mini_widget)*
  ;  

guidbase_mini_section
  :   '[' guidbase_mini_widgets ']'
  ; 

guidbase_mini_goto
  :   '%'
  |   '$'
  |   '^'
  |   '#'
  ;   

guidbase_mini_row
  :   guidbase_mini_section
  |   guidbase_mini_widget
  ;    

guidbase_mini_rows
  :   guidbase_mini_row ('+' guidbase_mini_row)*
  ; 

guidbase_mini_col
  :   '{' guidbase_mini_rows '}' ('.' width=guidbase_mini_int)?
  ;
    
guidbase_mini_page
  :   id=guidbase_mini_id guidbase_mini_col?
  ;
