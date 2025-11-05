grammar Mathbase;     

import Anybase, Typebase, Valuebase;

mathbase_symbols
    :   'integral' // ∫
    |   ''
		;
		
mathbase_operation_add
    :   (valuebase_anyvalue | anybase_identifier) '+' (valuebase_anyvalue | anybase_identifier)
    ;

mathbase_operation_subtract
    :   (valuebase_anyvalue | anybase_identifier) '-' (valuebase_anyvalue | anybase_identifier)
    ;

mathbase_operation_multiply
    :   (valuebase_anyvalue | anybase_identifier) '*' (valuebase_anyvalue | anybase_identifier)
    ;

mathbase_operation_divide
    :   (valuebase_anyvalue | anybase_identifier) '/' (valuebase_anyvalue | anybase_identifier)
    ;

mathbase_operation_expr
    :   mathbase_operation_add
    |   mathbase_operation_subtract
    |   mathbase_operation_multiply
    |   mathbase_operation_divide
    ;