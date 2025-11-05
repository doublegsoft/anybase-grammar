grammar Typebase;     

import Anybase, Valuebase;

TYPEBASE_PROTOCOL:          'protocol';
TYPEBASE_ENUM:              'enum';

TYPEBASE_PERCENTAGE:        '%';
TYPEBASE_REQUIRED:          '!';

typebase_attrdecl
  :   typebase_anybase_id TYPEBASE_REQUIRED? ':' (typebase_anytype | typebase_anybase_id)
  ;

typebase_keytext
  :   (key1=(ANYBASE_ID | 'D' | 'M' | 'Y' | 'N') | key2=anybase_int) ':' text=ANYBASE_ID
  ;
  
typebase_keystring
  :   key=ANYBASE_ID ':' str=anybase_string
  ;

typebase_keylen
  :   key=ANYBASE_ID ':' len=anybase_int
  ;

typebase_unit
  :   '%' anybase_string
  ;
    
typebase_value
  :   typebase_id | anybase_value
  ;
    
// pair type
typebase_pair
  :   '<' typebase_value ',' typebase_value '>'
  ;

// hash type
typebase_hash
  :   '#' (typebase_pair | '<' typebase_value '>')
  ;

// tuple type
typebase_tuple
  :   '(' typebase_value ',' typebase_value (',' typebase_value)* ')'
  ;

// list type
typebase_list
  :   '[' (size=ANYBASE_INT | implicitObject=anybase_identifier | customObject=typebase_custom_object)? ']'
  ;

// matrix type
typebase_matrix
  :   '[' ANYBASE_INT? ']' '[' ANYBASE_INT? ']'
  ;

// range type
typebase_range
  :   (lower_nlt='[' | lower_gt='(') lower=typebase_range_value ',' upper=typebase_range_value? (upper_ngt=']' | upper_lt=')')
  ;
  
typebase_range_value
  :   number=anybase_number
  |   date=anybase_date
  ;

// enum type
typebase_enum
  :   TYPEBASE_ENUM '[' typebase_keytext (',' typebase_keytext)* ']'
  ;
    
typebase_state
  :   ANYBASE_KEYWORD_STATE
  ;
  
typebase_bool
  :   ANYBASE_KEYWORD_BOOL
  ;

// string type
typebase_string
  :   ANYBASE_KEYWORD_STRING ('(' length=anybase_int ')')?
  ;

// number type
typebase_number
  :   ANYBASE_KEYWORD_NUMBER ('(' precision=anybase_int (',' scale=anybase_int)?')')? unit=typebase_unit?
  ;

// custom object type
typebase_anonymous_object
  :   '<' typebase_attrdecl (',' typebase_attrdecl)* '>'
  ;

typebase_custom_object
  :   name=anybase_id '(' typebase_keystring (',' typebase_keystring)* ')' typebase_anonymous_object?
  ;

typebase_protocol
  :   '<' typebase_keylen (',' typebase_keylen)* '>'
  ;

typebase_int
  :   (ANYBASE_KEYWORD_INT | ANYBASE_KEYWORD_INTEGER) ( '(' length=anybase_int ')' )?
  ;

typebase_long
  :   ANYBASE_KEYWORD_LONG
  ;

typebase_date
  :   ANYBASE_KEYWORD_DATE ('(' type=ANYBASE_ID ')')?
  ;

typebase_time
  :   ANYBASE_KEYWORD_TIME ('(' type=ANYBASE_ID ')')?
  ;

typebase_datetime
  :   ANYBASE_KEYWORD_DATETIME ('(' type=ANYBASE_ID ')')?
  ;

typebase_email
  :   'email'
  |   ANYBASE_KEYWORD_MAIL
  ;

typebase_phone
  :   ANYBASE_KEYWORD_PHONE
  ;

typebase_mobile
  :   ANYBASE_KEYWORD_MOBILE
  ;

typebase_code
  :   ANYBASE_KEYWORD_CODE ('(' code=valuebase_code ')')?
  |   ANYBASE_KEYWORD_CODE ('(' (fixed='-')? length=anybase_int (',' type=ANYBASE_ID )? ')')?
  ;
  
typebase_url
  :   ANYBASE_KEYWORD_URL
  ;
    
typebase_money
  :   ANYBASE_KEYWORD_MONEY
  ;

typebase_file
  :   ANYBASE_KEYWORD_FILE ('[' ANYBASE_ID (',' ANYBASE_ID) ']')?
  ;

typebase_image
  :   ANYBASE_KEYWORD_IMAGE ('[' ANYBASE_ID (',' ANYBASE_ID) ']')?
  ;

typebase_audio
  :   ANYBASE_KEYWORD_AUDIO
  ;

typebase_video
  :   ANYBASE_KEYWORD_VIDEO
  ;
    
typebase_uuid
  :   ANYBASE_KEYWORD_UUID
  ;

typebase_id
  :   ANYBASE_KEYWORD_ID
  ;
  
typebase_name
  :   ANYBASE_KEYWORD_NAME ('(' type=ANYBASE_ID ')')?
  ;
  
typebase_address
  :   ANYBASE_KEYWORD_ADDRESS
  ;
  
  
typebase_password
  :   ANYBASE_KEYWORD_PASSWORD
  ;
  
typebase_byte
  :   ANYBASE_KEYWORD_BYTE ('(' length=anybase_int ')')?
  ;

typebase_bit
  :   ANYBASE_KEYWORD_BIT ('(' length=anybase_int ')')?
  ;
  
typebase_text
  :   ANYBASE_KEYWORD_TEXT ('(' type=ANYBASE_ID ')')?
  ;
    
typebase_now
  :   ANYBASE_KEYWORD_NOW
  |   'lmt'
  ;

typebase_version
  :   ANYBASE_INT anybase_id? (('.' ANYBASE_INT anybase_id?) | ('-' anybase_id))*
  ;

typebase_native_identifier
  :   '*'? anybase_id (('/' | '-' | '.' | '_') anybase_id)*
  ;

typebase_native
  :   name=typebase_native_identifier 
      ('@' group=typebase_native_identifier (':' artifact=typebase_native_identifier)? (':' version=typebase_version)? (':' classifier=typebase_native_identifier)?)?
      ('<' typebase_native (',' typebase_native)* '>')?
  ;
  
typebase_anybase_id
  :   anybase_id
  ;
    
typebase_any
  :   ANYBASE_KEYWORD_ANY
  ;

typebase_anytype
  :   ('&' reftype=anybase_id ('(' typebase_anybase_id (',' typebase_anybase_id)* ('?' filterkey=typebase_anybase_id '=' filterval=typebase_anybase_id)? ')')?
  |   typebase_id
  |   typebase_string
  |   typebase_code
  |   typebase_name
  |   typebase_date
  |   typebase_time
  |   typebase_datetime
  |   typebase_now
  |   typebase_phone
  |   typebase_mobile
  |   typebase_email
  |   typebase_address
  |   typebase_number
  |   typebase_int
  |   typebase_long
  |   typebase_money
  |   typebase_byte
  |   typebase_bit
  |   typebase_enum
  |   typebase_text
  |   typebase_url
  |   typebase_password
  |   typebase_pair
  |   typebase_hash
  |   typebase_tuple
  |   typebase_protocol
  |		typebase_custom_object
  |   typebase_anonymous_object
  |   typebase_range
  |   typebase_file
  |   typebase_image
  |   typebase_audio
  |   typebase_video
  |   typebase_native
  |   typebase_version
  |   typebase_uuid
  |   typebase_state
  |   typebase_bool
  |   typebase_any)? (array='[]' matrix='[]'?)?
  ;
