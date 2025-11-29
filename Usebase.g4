grammar Usebase;     

import Anybase, Typebase;


USEBASE_SYMBOL_START:               '|';
USEBASE_SYMBOL_CHECK:               '~|';
USEBASE_SYMBOL_FIND:                '&|';
USEBASE_SYMBOL_UPDATE:              ':|';
USEBASE_SYMBOL_SAVE:                '+|';
USEBASE_SYMBOL_ASSIGN:              '=|';
USEBASE_SYMBOL_DELETE:              '-|';
USEBASE_SYMBOL_CALL:                '@|';
USEBASE_SYMBOL_CASE:                '?|';
USEBASE_SYMBOL_LOOP:                '*|';
USEBASE_SYMBOL_RETURN:              '.|';

USEBASE_SYMBOL_GT:                  '>';
USEBASE_SYMBOL_FGT:                 '>>';
USEBASE_SYMBOL_LT:                  '<';
USEBASE_SYMBOL_FLT:                 '<<';
USEBASE_SYMBOL_NGT:                 '<=';
USEBASE_SYMBOL_NLT:                 '>=';
USEBASE_SYMBOL_EQ:                  '==';
USEBASE_SYMBOL_NEQ:                 '!=';
USEBASE_SYMBOL_AQ:                  '~='; // Approximately Equal

USEBASE_SYMBOL_ADD_ASSIGN:          '+=';
USEBASE_SYMBOL_SUB_ASSIGN:          '-=';
USEBASE_SYMBOL_MUL_ASSIGN:          '*=';
USEBASE_SYMBOL_DIV_ASSIGN:          '/=';
USEBASE_SYMBOL_NOP_ASSIGN:          '=';

USEBASE_SYMBOL_HASH:                '#';

usebase_program
  :   usebase_usecase*
  ;

usebase_usecase
  :   '@' name=ANYBASE_ID ('(' usebase_arguments ')')? usebase_return? usebase_remote?
      usebase_statement*
  ;  

usebase_operator_hash
  :   USEBASE_SYMBOL_HASH
  ;

usebase_operator_part
  :   USEBASE_SYMBOL_CHECK
  |   USEBASE_SYMBOL_FIND
  |   USEBASE_SYMBOL_ASSIGN
  |   USEBASE_SYMBOL_SAVE
  |   USEBASE_SYMBOL_UPDATE
  |   USEBASE_SYMBOL_DELETE
  |   USEBASE_SYMBOL_CALL
  |   USEBASE_SYMBOL_CASE
  |   USEBASE_SYMBOL_LOOP
  |   USEBASE_SYMBOL_RETURN
  ;

usebase_operator
  :   USEBASE_SYMBOL_START usebase_operator_part+
  ;  

usebase_comparator
  :   USEBASE_SYMBOL_GT
  |   USEBASE_SYMBOL_LT
  |   USEBASE_SYMBOL_FGT
  |   USEBASE_SYMBOL_FLT
  |   USEBASE_SYMBOL_NGT
  |   USEBASE_SYMBOL_NLT
  |   USEBASE_SYMBOL_EQ
  |   USEBASE_SYMBOL_NEQ
  |   USEBASE_SYMBOL_AQ
  ;

usebase_assignop
  :   USEBASE_SYMBOL_ADD_ASSIGN
  |   USEBASE_SYMBOL_SUB_ASSIGN
  |   USEBASE_SYMBOL_MUL_ASSIGN
  |   USEBASE_SYMBOL_DIV_ASSIGN
  |   USEBASE_SYMBOL_NOP_ASSIGN
  ;  

usebase_expression
  :   usebase_invoke
  |   usebase_object
  |   usebase_array
  |   usebase_comparison msg=anybase_string? 
  |   usebase_assignment
  |   item=anybase_id 'in' array=anybase_id
  |   var=anybase_identifier
  ; 

usebase_statement
  :   usebase_operator usebase_expression usebase_remote?
  ;

usebase_comparison_part
  :   comparand=anybase_identifier usebase_comparator value=usebase_value
  ;  

usebase_comparison_conj
  :   'and'
  |   'or'
  ;  

usebase_comparison
  :   usebase_comparison_part (usebase_comparison_conj usebase_comparison_part)*  (otherwise='!' msg=anybase_string)?
  ;  

usebase_assignment 
  :   variable=anybase_identifier usebase_assignop usebase_value 
  ;

usebase_validation
  :   required='!' ('%' usebase_comparison '%')?
  ;  

usebase_argument
  :   anybase_identifier ('as' attr=anybase_id)? ('=' value=anybase_value)? usebase_validation?
  |   usebase_aggregate
  |   usebase_sysobj
  |   anybase_value
  ;  

usebase_arguments
  :   usebase_argument (',' usebase_argument)*
  ;

usebase_object
  :   alias=anybase_id? '{' name=anybase_id (':' usebase_attributes)? '}' 
      (usebase_source | usebase_invoke | 
      (usebase_operator_hash '(' usebase_arguments ')' (existing='!' msg=anybase_string)?))? 
  ;

usebase_array
  :   alias=anybase_id? '[' (usebase_aggregate | name=anybase_id) ']' 
      (usebase_source | usebase_invoke | (usebase_operator_hash '(' usebase_arguments ')'))?
  ;

usebase_data
  :   usebase_object
  |   usebase_array
  |   usebase_derivative
  ;

usebase_value
  :   anybase_string
  |   anybase_value
  |   anybase_identifier
  |   usebase_aggregate
  |   usebase_invoke
  |   usebase_sysobj
  ;  

usebase_aggregate
  :   usebase_data ('<' usebase_conditions? '>' usebase_data)*
  ;

//
// :average_player_rating%average[team_player <player> player:rating]%
//
usebase_derivative
  :   ':' name=anybase_id usebase_calculate?
  ;  

usebase_attribute
  :   name=anybase_id ('=' value=anybase_value)? usebase_validation?
  |   usebase_derivative
  ;  

usebase_attributes
  :   usebase_attribute (',' usebase_attribute)*
  ;  

usebase_remote
  :   '@' url=anybase_url
  ;  

usebase_return
  :   ':' usebase_aggregate
  ;  

usebase_source
  :   '&' anybase_identifier
  ;

usebase_invoke
  :   '@' anybase_identifier '(' usebase_arguments ')' (existing='!' msg=anybase_string)?
  ;  

usebase_sysobj
  :   '#' anybase_identifier
  ;    

usebase_condition
  :   anybase_identifier ('=' anybase_value)?
  ;  

usebase_conditions
  :   usebase_condition ('+' usebase_condition)*
  ;  

usebase_calculate
  :   '%' name=anybase_id usebase_array ('(' groups=usebase_arguments ')')? '%'
  ;  
