grammar Valuebase;     

import Anybase, Typebase;

// user action
valuebase_action
    :   '@' ANYBASE_ID
    ;

// template variable
valuebase_template_variable
    :   '$' ANYBASE_ID
    ;

// position value
valuebase_position
    :   '(' ANYBASE_INT ',' ANYBASE_INT ',' ANYBASE_INT ','  ANYBASE_INT')'
    ;

// uri value
valuebase_uri
    :   '/' ANYBASE_ID ('/' ANYBASE_ID)* ('.' ext=ANYBASE_ID)?
    ;

valuebase_list_item
    :   valuebase_template_variable
    |   valuebase_action
    |   valuebase_uri
    |   ANYBASE_ID
    |   ANYBASE_QUOTED_STRING
    ;

// list
valuebase_list
    :   '[' valuebase_list_item (',' valuebase_list_item)* ']'
    ;

valuebase_anyvalue
    :   typebase_anytype
    |   anybase_value
    |   valuebase_uri
    |   valuebase_action
    |   valuebase_position
    |   valuebase_list
    ;


