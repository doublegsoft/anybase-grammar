grammar Valuebase;     

import Anybase;

valuebase_code_date
  :   year=ANYBASE_CODE_YEAR
  |   month=ANYBASE_CODE_MONTH
  |   day=ANYBASE_CODE_DAY
  |   hour=ANYBASE_CODE_HOUR
  |   minute=ANYBASE_CODE_MINUTE
  |   second=ANYBASE_CODE_SECOND
  ;
  
VALUEBASE_CODE_ANSI
  :   ANYBASE_SYMBOL_ASCII ANYBASE_SYMBOL_ASCII+
  ;
  
VALUEBASE_CODE_NUMBERS
  :   ANYBASE_SYMBOL_NUMBER ANYBASE_SYMBOL_NUMBER+
  ;
  

valuebase_code_ansi
  :   'A'
  |   'AA'
  |   'AAA'
  |   'AAAA'
  |   'AAAAA'
  |   'AAAAAA'
  |   'AAAAAAA'
  |   'AAAAAAAA'
  |   'AAAAAAAAA'
  |   'AAAAAAAAAA'
  |   'AAAAAAAAAAA'
  |   'AAAAAAAAAAAA'
  ;
  
valuebase_code_numbers
  :   'N'
  |   'NN'
  |   'NNN'
  |   'NNNN'
  |   'NNNNN'
  |   'NNNNNN'
  |   'NNNNNNN'
  |   'NNNNNNNN'
  |   'NNNNNNNNN'
  |   'NNNNNNNNNN'
  |   'NNNNNNNNNNN'
  |   'NNNNNNNNNNNN'
  ;
  
valuebase_code_part
  :  ansi=valuebase_code_ansi
  |  date=valuebase_code_date
  |  number=valuebase_code_numbers
  ;
  
valuebase_code
  :  (valuebase_code_part '|')* number=valuebase_code_numbers treelike='*'?
  ;

  
valuebase_bytes
  :   datatype=('A..' | 'N..' | 'AN..') length=anybase_int
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
  :   valuebase_uri
  |   ANYBASE_ID
  |   ANYBASE_QUOTED_STRING
  ;

// list
valuebase_list
  :   '[' valuebase_list_item (',' valuebase_list_item)* ']'
  ;

valuebase_anyvalue
  :   valuebase_uri
  |   valuebase_bytes
  |   valuebase_position
  |   valuebase_list
  ;


