grammar ModelbaseExpr;

import Typebase;

MODELBASE_EXPR_OBJECT_MANUPLATE:          '{+-=}';
MODELBASE_EXPR_ARRAY_MANUPLATE:           '[+-=]';
MODELBASE_EXPR_OBJECT_READ:               '#{}';  
MODELBASE_EXPR_OBJECT_FIND:               '%[]';

modelbase_expr_host 
  :   anybase_id ('.' anybase_id)* 
  |   ANYBASE_TYPE_IPV4
  ;

modelbase_expr_port 
  :   anybase_int 
  ;

modelbase_expr_path
  :   anybase_id ('/' anybase_id)* 
  ;

modelbase_expr_query
  :   modelbase_expr_param ('&' modelbase_expr_param)* ;

modelbase_expr_param
  :   anybase_id '=' anybase_value 
  ;

modelbase_expr_url 
  :   ANYBASE_TYPE_SCHEME '://' modelbase_expr_host (':' modelbase_expr_port)? ('/' modelbase_expr_path)? ('?' modelbase_expr_query)? 
  ;

modelbase_expr_operator
  :   '+'
  |   '-'
  |   '*'
  |   '/'  
  ;

modelbase_expr_comparator
  :   '=='
  |   '!=' 
  ;   

modelbase_expr_invocation
  :   name=anybase_id '(' obj=anybase_id '.' attr=anybase_id (modelbase_expr_comparator val=anybase_id)? ')' '@' group=anybase_id
  ;

modelbase_expr_comparison
  :   obj=anybase_id '.' attr=anybase_id modelbase_expr_comparator val=anybase_id '@' group=anybase_id
  ;  

modelbase_expr_remote
  :   attr=anybase_id '@' modelbase_expr_url
  ;  

modelbase_expr_arithmetic
  :   obj=anybase_id '.' attr=anybase_id modelbase_expr_operator anybase_number
  ;    

modelbase_expr_value
  :   modelbase_expr_invocation 
  |   modelbase_expr_comparison
  |   modelbase_expr_remote
  |   modelbase_expr_arithmetic
  ;