grammar Tatabase;

import Anybase;

tatabase_enum:      '[' anybase_string (',' anybase_string)* ']';

tatabase_range:     ('[' | '(') anybase_number ',' anybase_number (']' | ')');

tatabase_type
    :   ANYBASE_ID
    |   tatabase_enum
    |   tatabase_range
    ;

tatabase_decl: ANYBASE_ID ':' tatabase_type;

tatabase_defn: ANYBASE_ID '(' tatabase_decl (',' tatabase_decl)* ')';
