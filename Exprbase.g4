grammar Exprbase;

import Anybase, Typebase;

EXPRBASE_SYMBOL_GT:                  '>';
EXPRBASE_SYMBOL_FGT:                 '>>';
EXPRBASE_SYMBOL_LT:                  '<';
EXPRBASE_SYMBOL_FLT:                 '<<';
EXPRBASE_SYMBOL_NGT:                 '<=';
EXPRBASE_SYMBOL_NLT:                 '>=';
EXPRBASE_SYMBOL_EQ:                  '==';
EXPRBASE_SYMBOL_NEQ:                 '!=';
EXPRBASE_SYMBOL_AQ:                  '~='; // Approximately Equal

EXPRBASE_SYMBOL_ADD_ASSIGN:          '+=';
EXPRBASE_SYMBOL_SUB_ASSIGN:          '-=';
EXPRBASE_SYMBOL_MUL_ASSIGN:          '*=';
EXPRBASE_SYMBOL_DIV_ASSIGN:          '/=';
EXPRBASE_SYMBOL_NOP_ASSIGN:          '=';

exprbase_comparator
  :   EXPRBASE_SYMBOL_GT
  |   EXPRBASE_SYMBOL_LT
  |   EXPRBASE_SYMBOL_FGT
  |   EXPRBASE_SYMBOL_FLT
  |   EXPRBASE_SYMBOL_NGT
  |   EXPRBASE_SYMBOL_NLT
  |   EXPRBASE_SYMBOL_EQ
  |   EXPRBASE_SYMBOL_NEQ
  |   EXPRBASE_SYMBOL_AQ
  ;

exprbase_assignop
  :   EXPRBASE_SYMBOL_ADD_ASSIGN
  |   EXPRBASE_SYMBOL_SUB_ASSIGN
  |   EXPRBASE_SYMBOL_MUL_ASSIGN
  |   EXPRBASE_SYMBOL_DIV_ASSIGN
  |   EXPRBASE_SYMBOL_NOP_ASSIGN
  ;    

exprbase_calc_expr
  :   left=exprbase_calc_expr operator=('*'|'/') right=exprbase_calc_expr
  |   left=exprbase_calc_expr operator=('+'|'-') right=exprbase_calc_expr 
  |   exprbase_calc_value                                             
  |   paren='(' exprbase_calc_expr ')'
  ;  

exprbase_calc_value
  :   anybase_value
  ;

exprbase_cmp_expr
  :   paren='(' exprbase_cmp_expr ')'
  |   comparand=anybase_identifier exprbase_comparator value=anybase_value 
  |   exprbase_cmp_expr and='and' exprbase_cmp_expr                                     
  |   exprbase_cmp_expr or='or' exprbase_cmp_expr                                      
  ;