grammar Modelbase;

import Typebase;

// '{' ( ~('{' | '}') | ('\\{' | '\\}') )* '}';

fragment
DOUBLE_BRACES_OPEN:  '{{';

fragment
DOUBLE_BRACES_CLOSE:  '}}';

// MODELBASE_BODY
//   : DOUBLE_BRACES_OPEN .*? DOUBLE_BRACES_CLOSE
//   | '{' ~('{' | '}')* '}'
//   ;

modelbase_required:         '!';
modelbase_identifiable:     '!!';
modelbase_unique:           '+';

modelbase_option
  :   modelbase_name '=' anybase_string
  ;
    
modelbase_name
  :   anybase_id
  |   'lmt'
  |   'enum'
  |   'protocol'
  ;
    
modelbase_alias
  :   anybase_identifier
  |   modelbase_name
  ;

modelbase_label
  :   '@' name=modelbase_name ('#' id=modelbase_name)? ('(' modelbase_option (',' modelbase_option)* ')')?
  ;

modelbase_labels
    :   modelbase_label*
    ;

modelbase_attrs
    :   modelbase_attr (',' modelbase_attr)*
    ;

modelbase_attr
    :   modelbase_labels? name=modelbase_name (required=modelbase_required | identifiable=modelbase_identifiable)? unique=modelbase_unique?
        ('(' descr=anybase_string ')')? ('=' dflt=anybase_value)? decorator=(TYPEBASE_REQUIRED | '!')? 
        ('as' alias=modelbase_alias)? ( ':' ( typebase_anytype | ( innerType=modelbase_type innerArray='[]'? ) ) )?
    ;
    
modelbase_behavior
    :   modelbase_labels? name=anybase_id '(' params=modelbase_attrs? ')' (':' ret=typebase_anytype)? 
        body=modelbase_body?
    ;
    
modelbase_behaviors
    :   modelbase_behavior (',' modelbase_behavior)*
    ;
    
modelbase_type
    :   modelbase_labels? name=modelbase_name ('(' descr=anybase_string ')')? ('as' alias=anybase_identifier)? '<' modelbase_attrs? (','? modelbase_behaviors)? '>'
    ;

modelbase_types
    :   (modelbase_type)+
    ;

modelbase_body
  :   '{' modelbase_body_statements '}'
  ;

modelbase_body_url
  : scheme=anybase_id '://' anybase_id ('/' anybase_id)*
  ;  

modelbase_body_comparators
  :   '=='
  |   '>='
  |   '!='
  |   '<='
  |   '<'
  |   '>' 
  ;  

modelbase_body_operators
  :   '+='
  |   '/='
  |   '*='
  |   '-='
  |   '='
  ;    

modelbase_body_statements
  :   modelbase_body_statement*
  ;  

modelbase_body_statement
  :   modelbase_body_if
  |   modelbase_body_loop
  |   modelbase_body_assignment
  |   modelbase_body_invocation
  |   modelbase_body_validation
  ; 

modelbase_body_validation
  :   anybase_identifier modelbase_required? modelbase_unique? ('#' format=anybase_string)?  comment=anybase_string
  ;    

modelbase_body_assignment
  :   assignee=anybase_identifier modelbase_body_operators (operand=anybase_identifier | anybase_value | modelbase_body_invocation)
  ;  

modelbase_body_invocation
  :   action=anybase_id '@' (constant=anybase_string | variable=anybase_identifier) ('?' modelbase_body_arguments)?  ('#' format=anybase_id)?
  ;   

modelbase_body_argument
  :   name=anybase_identifier ('=' anybase_value)?
  ;  

modelbase_body_arguments
  :   modelbase_body_argument ('&' modelbase_body_argument)*
  ;   

modelbase_body_comparison
  :   anybase_identifier (modelbase_body_comparators anybase_value)
  ;  

modelbase_body_if
  :   '(' if_cmp=modelbase_body_comparison ')' if_stmt=modelbase_body 
      (':' else_stmt=modelbase_body)?
  ;   

modelbase_body_loop
  :   '[' lower=anybase_value? '..' upper=anybase_value ']' modelbase_body
  ;    