grammar Anybase;

// ANYBASE_UNTERMINATEDSTRING:       '\'' (~[\'\\\r\n] | '\\' (. | EOF))*;

// ANYBASE_UNTERMINATEDSTRING:       '"' (~["\\\r\n] | '\\' (. | EOF))*;

ANYBASE_COMMENT:                  '//' ~[\r\n]* -> skip;

ANYBASE_WS:                       [ \n\t\r]+ -> channel(HIDDEN);

fragment
ANYBASE_NAMECHAR
  :   ANYBASE_NAMEFIRSTCHAR
  |   '0'..'9'
  |   '_'
  |   '\u00B7'
  |   '\u0300'..'\u036F'
  |   '\u203F'..'\u2040'
  ;

fragment
ANYBASE_NAMEFIRSTCHAR
  :   'A'..'Z'
  |   'a'..'z'
  |   '\u00C0'..'\u00D6'
  |   '\u00D8'..'\u00F6'
  |   '\u00F8'..'\u02FF'
  |   '\u0370'..'\u037D'
  |   '\u037F'..'\u1FFF'
  |   '\u200C'..'\u200D'
  |   '\u2070'..'\u218F'
  |   '\u2C00'..'\u2FEF'
  |   '\u3001'..'\uD7FF'
  |   '\uF900'..'\uFDCF'
  |   '\uFDF0'..'\uFFFD'
  ; // ignores | ['\u10000-'\uEFFFF];

fragment
ANYBASE_DIGIT:                    [0-9];

ANYBASE_QUOTED_STRING:            '\'' (~['])* '\''; // '\'' (~[\r\n'])* '\'';

ANYBASE_4DIGITS:                  ANYBASE_DIGIT ANYBASE_DIGIT ANYBASE_DIGIT ANYBASE_DIGIT;

ANYBASE_2DIGITS:                  ANYBASE_DIGIT ANYBASE_DIGIT;

ANYBASE_INT:                      ('0'..'9')+;

ANYBASE_HEX_DIGITS:               ('0'..'9' | 'A'..'F')+ 'H';

ANYBASE_TYPE_SCHEME:              'http' | 'https' | 'ftp' | 'sftp' | 'ssh' | 'grpc';
ANYBASE_TYPE_IPV4:                [0-9]+ '.' [0-9]+ '.' [0-9]+ '.' [0-9]+;

ANYBASE_SYMBOL_NUMBER:            'N';
ANYBASE_SYMBOL_ASCII:             'A';
ANYBASE_SYMBOL_UNICODE:           'U';
ANYBASE_SYMBOL_INVISIBLE:         'I';

ANYBASE_SYMBOL_REFERENCE:         '&';

ANYBASE_UNIT_YEAR:                'Y';
ANYBASE_UNIT_MONTH:               'M';
ANYBASE_UNIT_DAY:                 'D';
ANYBASE_UNIT_HOUR:                'h';
ANYBASE_UNIT_MINUTE:              'm';
ANYBASE_UNIT_SECOND:              's';
ANYBASE_UNIT_MILLISECOND:         'ms';
ANYBASE_UNIT_PIXEL:               'px';
ANYBASE_UNIT_POINT:               'pt';

ANYBASE_CODE_YEAR:                'YYYY' | 'YY';
ANYBASE_CODE_MONTH:               'MM';
ANYBASE_CODE_DAY:                 'DD';
ANYBASE_CODE_HOUR:                'hh';
ANYBASE_CODE_MINUTE:              'mm';
ANYBASE_CODE_SECOND:              'ss' ;

ANYBASE_KEYWORD_NUMBER:           'number';
ANYBASE_KEYWORD_STRING:           'string';
ANYBASE_KEYWORD_LONG:             'long';
ANYBASE_KEYWORD_INT:              'int';
ANYBASE_KEYWORD_INTEGER:          'integer';
ANYBASE_KEYWORD_BYTE:             'byte';
ANYBASE_KEYWORD_BIT:              'bit';
ANYBASE_KEYWORD_BOOL:             'bool';
ANYBASE_KEYWORD_ANY:              'any';
ANYBASE_KEYWORD_ID:               'id';
ANYBASE_KEYWORD_SEQUENCE:         'sequence';
ANYBASE_KEYWORD_UUID:             'uuid';
ANYBASE_KEYWORD_CODE:             'code';
ANYBASE_KEYWORD_NAME:             'name';
ANYBASE_KEYWORD_MAIL:             'mail';
ANYBASE_KEYWORD_EMAIL:            'email';
ANYBASE_KEYWORD_PHONE:            'phone';
ANYBASE_KEYWORD_MOBILE:           'mobile';
ANYBASE_KEYWORD_PASSWORD:         'password';
ANYBASE_KEYWORD_ADDRESS:          'address';
ANYBASE_KEYWORD_MONEY:            'money';
ANYBASE_KEYWORD_QUANTITY:         'quantity';
ANYBASE_KEYWORD_URL:              'url';
ANYBASE_KEYWORD_FILE:             'file';
ANYBASE_KEYWORD_IMAGE:            'image';
ANYBASE_KEYWORD_XML:              'xml';
ANYBASE_KEYWORD_JSON:             'json';
ANYBASE_KEYWORD_PNG:              'png';
ANYBASE_KEYWORD_JPG:              'jpg';
ANYBASE_KEYWORD_QR:               'qr';
ANYBASE_KEYWORD_AUDIO:            'audio';
ANYBASE_KEYWORD_VIDEO:            'video';
ANYBASE_KEYWORD_AVATAR:           'avatar';
ANYBASE_KEYWORD_ICON:             'icon';
ANYBASE_KEYWORD_TEXT:             'text';
ANYBASE_KEYWORD_NOW:              'now';
ANYBASE_KEYWORD_DATE:             'date';
ANYBASE_KEYWORD_TIME:             'time';
ANYBASE_KEYWORD_DATETIME:         'datetime';
ANYBASE_KEYWORD_DURATION:         'duration';
ANYBASE_KEYWORD_UNIT:             'unit';
ANYBASE_KEYWORD_STATE:            'state';

ANYBASE_ID:                       ANYBASE_NAMEFIRSTCHAR ANYBASE_NAMECHAR*;

anybase_keywords
  :   ANYBASE_KEYWORD_NUMBER
  |   ANYBASE_KEYWORD_STRING
  |   ANYBASE_KEYWORD_LONG
  |   ANYBASE_KEYWORD_INT
  |   ANYBASE_KEYWORD_INTEGER
  |   ANYBASE_KEYWORD_BYTE
  |   ANYBASE_KEYWORD_BIT
  |   ANYBASE_KEYWORD_BOOL
  |   ANYBASE_KEYWORD_ANY
  |   ANYBASE_KEYWORD_ID
  |   ANYBASE_KEYWORD_SEQUENCE
  |   ANYBASE_KEYWORD_UUID
  |   ANYBASE_KEYWORD_CODE
  |   ANYBASE_KEYWORD_NAME
  |   ANYBASE_KEYWORD_MAIL
  |   ANYBASE_KEYWORD_EMAIL
  |   ANYBASE_KEYWORD_PHONE
  |   ANYBASE_KEYWORD_MOBILE
  |   ANYBASE_KEYWORD_PASSWORD
  |   ANYBASE_KEYWORD_ADDRESS
  |   ANYBASE_KEYWORD_MONEY
  |   ANYBASE_KEYWORD_QUANTITY
  |   ANYBASE_KEYWORD_URL
  |   ANYBASE_KEYWORD_FILE
  |   ANYBASE_KEYWORD_IMAGE
  |   ANYBASE_KEYWORD_XML
  |   ANYBASE_KEYWORD_JSON
  |   ANYBASE_KEYWORD_PNG
  |   ANYBASE_KEYWORD_JPG
  |   ANYBASE_KEYWORD_QR
  |   ANYBASE_KEYWORD_AUDIO
  |   ANYBASE_KEYWORD_VIDEO
  |   ANYBASE_KEYWORD_AVATAR
  |   ANYBASE_KEYWORD_ICON
  |   ANYBASE_KEYWORD_TEXT
  |   ANYBASE_KEYWORD_NOW
  |   ANYBASE_KEYWORD_DATE
  |   ANYBASE_KEYWORD_TIME
  |   ANYBASE_KEYWORD_DATETIME
  |   ANYBASE_KEYWORD_DURATION
  |   ANYBASE_KEYWORD_UNIT
  |   ANYBASE_KEYWORD_STATE
  |   ANYBASE_SYMBOL_NUMBER
  |   ANYBASE_SYMBOL_ASCII
  |   ANYBASE_SYMBOL_UNICODE
  |   ANYBASE_SYMBOL_INVISIBLE
  |   ANYBASE_UNIT_YEAR
  |   ANYBASE_UNIT_MONTH
  |   ANYBASE_UNIT_DAY
  |   ANYBASE_UNIT_HOUR
  |   ANYBASE_UNIT_MINUTE
  |   ANYBASE_UNIT_SECOND
  |   ANYBASE_UNIT_MILLISECOND
  |   ANYBASE_UNIT_PIXEL
  |   ANYBASE_UNIT_POINT
  |   ANYBASE_CODE_YEAR
  |   ANYBASE_CODE_MONTH
  |   ANYBASE_CODE_DAY
  |   ANYBASE_CODE_HOUR
  |   ANYBASE_CODE_MINUTE
  |   ANYBASE_CODE_SECOND
  |   ANYBASE_TYPE_SCHEME
  ;

anybase_symbol_any
  :   ANYBASE_SYMBOL_NUMBER
  |   ANYBASE_SYMBOL_ASCII
  |   ANYBASE_SYMBOL_UNICODE
  |   ANYBASE_SYMBOL_INVISIBLE
  ;
  
anybase_unit_any
  :   ANYBASE_UNIT_YEAR
  |   ANYBASE_UNIT_MONTH
  |   ANYBASE_UNIT_DAY
  |   ANYBASE_UNIT_HOUR
  |   ANYBASE_UNIT_MINUTE
  |   ANYBASE_UNIT_SECOND
  |   ANYBASE_UNIT_MILLISECOND
  |   ANYBASE_UNIT_PIXEL
  |   ANYBASE_UNIT_POINT
  ;
  
anybase_code_any
  :   ANYBASE_CODE_YEAR
  |   ANYBASE_CODE_MONTH
  |   ANYBASE_CODE_DAY
  |   ANYBASE_CODE_HOUR
  |   ANYBASE_CODE_MINUTE
  |   ANYBASE_CODE_SECOND
  ;
  
anybase_id
  :   ANYBASE_ID
  |   anybase_symbol_any
  |   anybase_code_any
  |   anybase_unit_any
  |   anybase_keywords
  ;  

anybase_identifier
  :   anybase_id ('.' anybase_id)*
  ;

anybase_int
  :   ANYBASE_INT
  |   ANYBASE_4DIGITS 
  |   ANYBASE_2DIGITS
  ;

anybase_hex
  :   ANYBASE_HEX_DIGITS
  ;

anybase_number
  :   anybase_int ('.' anybase_int)?
  ;

anybase_string
  :   ANYBASE_QUOTED_STRING
  ;

anybase_date
  :   year=ANYBASE_4DIGITS '-' month=ANYBASE_2DIGITS '-' day=ANYBASE_2DIGITS
  ;

anybase_time
  :   hour=ANYBASE_2DIGITS ':' minute=ANYBASE_2DIGITS (':' second=ANYBASE_2DIGITS)?
  ;

anybase_datetime
  :   anybase_date '#' anybase_time
  ;

anybase_year
  :   anybase_int ANYBASE_UNIT_YEAR
  ;

anybase_month
  :   anybase_int ANYBASE_UNIT_MONTH
  ;

anybase_day
  :   anybase_int ANYBASE_UNIT_DAY
  ;

anybase_hour
  :   anybase_int ANYBASE_UNIT_HOUR
  ;

anybase_minute
  :   anybase_int ANYBASE_UNIT_MINUTE
  ;

anybase_second
  :   anybase_int ANYBASE_UNIT_SECOND
  ;

anybase_percentage
  :   anybase_int '%'
  ;

anybase_host 
  :   anybase_identifier
  |   ANYBASE_TYPE_IPV4
  ;

anybase_url_param
  :   anybase_id '=' anybase_value 
  ;  

anybase_url 
  :   ANYBASE_TYPE_SCHEME '://' anybase_host (':' anybase_int)? ('/' anybase_id)* ('?' anybase_url_param ('&' anybase_url_param)*)? 
  ;  

anybase_value
  :   anybase_identifier
  |   anybase_number
  |   anybase_hex
  |   anybase_string
  |   anybase_date
  |   anybase_time
  |   anybase_datetime
  |   anybase_year
  |   anybase_month
  |   anybase_day
  |   anybase_hour
  |   anybase_minute
  |   anybase_second
  |   anybase_percentage
  ;