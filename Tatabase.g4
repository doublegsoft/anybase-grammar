grammar Tatabase;

import Anybase;

tatabase_value
    :   num=anybase_number
    |   str=anybase_string
    |   date=anybase_date
    |   duration=tatabase_value_duration
    ;

tatabase_name
    :   ANYBASE_ID
    |   'lmt'
    |   'id'
    |   'D'
    |   'M'
    ;
    
tatabase_value_duration
    :   year=anybase_year
    |   month=anybase_month
    |   day=anybase_day
    |   hour=anybase_hour
    |   minute=anybase_minute
    ;

tatabase_reference
    :   '&' obj=tatabase_name '(' attr=tatabase_name ')'
    ;

tatabase_domain
    :   (obj=tatabase_name '#')? attr=tatabase_name
    ;

tatabase_enum
    :   '[' tatabase_name (',' tatabase_name)* ']'
    ;

tatabase_range
    :  (prefix=anybase_string '+')? ('[' | '(') startValue=tatabase_value ',' endValue=tatabase_value (']' | ')')
    ;

tatabase_type
    :   num=anybase_number
    |   str=anybase_string
    |   date=anybase_date
    |   datetime=anybase_datetime
    |   ref=tatabase_reference
    |   dmn=tatabase_domain
    |   enmr=tatabase_enum
    |   rnge=tatabase_range
    |   lmt='lmt'
    |   id='id'
    |   nil = 'null'
    ;

tatabase_attribute
    :   name=tatabase_name ':' (typ3=tatabase_type | obj=tatabase_object)
    ;

tatabase_object
    :   name=tatabase_name '[' size=anybase_number ']' '<' tatabase_attribute (',' tatabase_attribute)* '>'
    ;

tatabase_model
    :   obj=tatabase_object+
    ;