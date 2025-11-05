grammar Typebase;     

import Anybase;

TYPEBASE_PROTOCOL:          'protocol';
TYPEBASE_ENUM:              'enum';
TYPEBASE_STRING:            'string';
TYPEBASE_NUMBER:            'number';
TYPEBASE_INT:               'int';
TYPEBASE_LONG:              'long';
TYPEBASE_DATE:              'date';
TYPEBASE_TIME:              'time';
TYPEBASE_DATETIME:          'datetime';
TYPEBASE_BIT:               'bit';
TYPEBASE_BYTE:              'byte';

TYPEBASE_MAIL:              'mail';
TYPEBASE_PHONE:             'phone';
TYPEBASE_MOBILE:            'mobile';
TYPEBASE_CODE:              'code';
TYPEBASE_MONEY:             'money';
TYPEBASE_FILE:              'file';
TYPEBASE_IMAGE:             'image';
TYPEBASE_AUDIO:             'audio';
TYPEBASE_VIDEO:             'video';
TYPEBASE_UUID:              'uuid';

TYPEBASE_PERCENTAGE:        '%';
TYPEBASE_REQUIRED:          '*';

typebase_attrdecl
    :   anybase_identifier TYPEBASE_REQUIRED? ':' (typebase_anytype | anybase_identifier)
    ;

typebase_keytext
    :   ANYBASE_ID ':' ANYBASE_ID
    ;

typebase_keylen
    :   ANYBASE_ID ':' anybase_int
    ;

typebase_unit
    :   '%' anybase_string
    ;
    

// pair type
typebase_pair
    :   '<' anybase_value ',' anybase_value '>'
    ;

// hash type
typebase_hash
    :   '#' (typebase_pair | '<' anybase_value '>')
    ;

// tuple type
typebase_tuple
    :   '(' anybase_value ',' anybase_value (',' anybase_value)* ')'
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
    :   ('[' | '(') anybase_number ',' anybase_number (']' | ')')
    ;

// enum type
typebase_enum
    :   TYPEBASE_ENUM '[' typebase_keytext (',' typebase_keytext)* ']'
    ;

// string type
typebase_string
    :   TYPEBASE_STRING ('(' anybase_int ')')?
    ;

// number type
typebase_number
    :   TYPEBASE_NUMBER ('('anybase_int (',' anybase_int)?')')? typebase_unit?
    ;

// custom object type
typebase_anonymous_object
    :   '<' typebase_attrdecl (',' typebase_attrdecl)* '>'
    ;

typebase_custom_object
    :   ANYBASE_ID typebase_anonymous_object
    ;

typebase_protocol
    :   '<' typebase_keylen (',' typebase_keylen)* '>'
    ;

typebase_int
    :   TYPEBASE_INT
    ;

typebase_long
    :   TYPEBASE_LONG
    ;

typebase_date
    :   TYPEBASE_DATE
    ;

typebase_time
    :   TYPEBASE_TIME
    ;

typebase_datetime
    :   TYPEBASE_DATETIME
    ;

typebase_mail
    :   TYPEBASE_MAIL
    ;

typebase_phone
    :   TYPEBASE_PHONE
    ;

typebase_mobile
    :   TYPEBASE_MOBILE ('(' anybase_int ')')?
    ;

typebase_code
    :   TYPEBASE_CODE ('(' anybase_int ')')?
    ;

typebase_money
    :   TYPEBASE_MONEY
    ;

typebase_file
    :   TYPEBASE_FILE ('[' ANYBASE_ID (',' ANYBASE_ID) ']')?
    ;

typebase_image
    :   TYPEBASE_IMAGE ('[' ANYBASE_ID (',' ANYBASE_ID) ']')?
    ;

typebase_audio
    :   TYPEBASE_AUDIO
    ;

typebase_video
    :   TYPEBASE_VIDEO
    ;
    
typebase_uuid
    :   TYPEBASE_UUID
    ;

typebase_version
    :   ANYBASE_INT ANYBASE_ID? (('.' ANYBASE_INT ANYBASE_ID?) | ('-' ANYBASE_ID))*
    ;

typebase_native_identifier
    :   '*'? ANYBASE_ID (('/' | '-' | '.' | '_') ANYBASE_ID)*
    ;

typebase_native
    :   name=typebase_native_identifier 
        ('@' group=typebase_native_identifier (':' artifact=typebase_native_identifier)? (':' version=typebase_version)? (':' classifier=typebase_native_identifier)?)?
        ('<' typebase_native (',' typebase_native)* '>')?
    ;

typebase_anytype
    :   '&' ANYBASE_ID
    |   typebase_pair
    |   typebase_hash
    |   typebase_tuple
    |   typebase_protocol
    |   typebase_anonymous_object
    |   typebase_list
    |   typebase_matrix
    |   typebase_range
    |   typebase_enum
    |   typebase_number
    |   typebase_int
    |   typebase_long
    |   typebase_string
    |   typebase_phone
    |   typebase_mobile
    |   typebase_code
    |   typebase_mail
    |   typebase_date
    |   typebase_time
    |   typebase_datetime
    |   typebase_file
    |   typebase_image
    |   typebase_audio
    |   typebase_video
    |   typebase_native
    |   typebase_version
    |   typebase_uuid
    ;
