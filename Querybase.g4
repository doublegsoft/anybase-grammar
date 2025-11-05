grammar Querybase;

ESC:        '\\"' | '\\\\' ; // 2-char sequences \" and \\
WS:         [ \t\r\n]+ -> skip;

ID:         [a-zA-Z0-9_]+;

OPERATOR
    :   '[]' 
    |   '%%' 
    |   '%*' 
    |   '*%' 
    |   '=' 
    |   '<>' 
    |   '>=' 
    |   '<=' 
    |   '!='
    |   '>'
    |   '<'
    |   '!!'
    ;

ORDER
    :   '^'
    ;

EXCLUDE
    :   '-'
    ;

querybase_id
    :   ID ('.' ID)*
    ;
    
querybase_attribute
    :   name=querybase_id (operator=OPERATOR value=querybase_id)?
    ;
    
    
querybase_object
    :   name=querybase_id '(' ( attrs=querybase_more) ')'
    ;
    
querybase_single
    :   obj=querybase_object (required='!')?
    |   attr=querybase_attribute (required='!')?
    ;
    
querybase_more
    :   star='*' 
    |   querybase_single  ('+' querybase_single)*
    ;
    
querybase_model
    :   name=querybase_id ret=('[]' | '{}') select=querybase_more ('?' filter=querybase_more)?
    ;

querybase_inConstants
    :   '[' querybase_constant (',' querybase_constant)? ']'
    ;

querybase_inInnerSelect
    :   '[' querybase_statement ']' 
    ;

querybase_funcInvocation
    :   '#' ID
    ;

querybase_constant
    :   '@' ID
    ;

querybase_operatingAttribute
    :   ((ID querybase_funcInvocation?) | querybase_constant) ('as' alias=ID)?
    ;

querybase_filteringCondition
    :   (OPERATOR (querybase_constant | alias=ID)?)
    |   querybase_inConstants
    |   querybase_inInnerSelect
    ;
    

querybase_filteringAttribute
    :   ID querybase_filteringCondition
    ;

querybase_sortingAttribute
    :   ID ORDER?
    ;

querybase_sortingAttributes
    :   querybase_sortingAttribute (',' querybase_sortingAttribute)*
    ;

querybase_filteringAttributes
    :   querybase_filteringAttribute (',' querybase_filteringAttribute)*
    ;

querybase_operatingAttributes
    :   name=ID ('as' alias=ID)? (exclude=EXCLUDE? '[' querybase_operatingAttribute (',' querybase_operatingAttribute)* ']')?
    ;

querybase_statement
    :   (querybase_operatingAttributes ('+' querybase_operatingAttributes)* ('?' querybase_filteringAttributes)? ('!' querybase_sortingAttributes)?)
    ;


