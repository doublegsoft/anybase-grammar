grammar Compobase;     

import Anybase;

compobase_invoke_param
    :   ANYBASE_ID ':' anybase_value 
    ;

compobase_invoke_params
    :   compobase_invoke_param (',' compobase_invoke_param)*
    ;

compobase_invoke
    :   ANYBASE_ID '.' ANYBASE_ID '(' compobase_invoke_params? ')'
    ;


