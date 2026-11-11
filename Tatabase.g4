grammar Tatabase;

import Anybase;

tatabase_value
  : num=anybase_number
  | str=anybase_string
  | date=anybase_date
  | duration=tatabase_value_duration
  | val=anybase_value
  | var=tatabase_case_variable
  ;

tatabase_name
  : ANYBASE_ID
  | 'lmt'
  | 'id'
  | 'D'
  | 'M'
  ;

tatabase_value_duration
  : year=anybase_year
  | month=anybase_month
  | day=anybase_day
  | hour=anybase_hour
  | minute=anybase_minute
  ;

tatabase_reference
  : '&' obj=tatabase_name '(' attr=tatabase_name ')'
  ;

tatabase_domain
  : (obj=tatabase_name '#')? attr=tatabase_name
  ;

tatabase_enum
  : '[' tatabase_name (',' tatabase_name)* ']'
  ;

tatabase_range
  : (prefix=anybase_string '+')? ('[' | '(') startValue=tatabase_value ',' endValue=tatabase_value (']' | ')')
  ;

tatabase_type
  : num=anybase_number
  | str=anybase_string
  | date=anybase_date
  | datetime=anybase_datetime
  | ref=tatabase_reference
  | dmn=tatabase_domain
  | enmr=tatabase_enum
  | rnge=tatabase_range
  | lmt='lmt'
  | id='id'
  | nil='null'
  ;

tatabase_attribute
  : name=tatabase_name ':' (typ3=tatabase_type | obj=tatabase_object)
  ;

tatabase_object
  : name=tatabase_name '[' size=anybase_number ']' '<' tatabase_attribute (',' tatabase_attribute)* '>'
  ;

tatabase_model
  : obj=tatabase_object+
  ;

tatabase_cases
  : tatabase_case+
  ;  

tatabase_case
  : '[' code=ANYBASE_ID ']' label=anybase_string '{'
    anybase_string*
    tatabase_case_prerequisite*
    tatabase_case_input
    tatabase_case_output+
    '}'
  ;

tatabase_case_assign
  : '=' anybase_id
  ;

tatabase_case_variable
  : '$' anybase_identifier
  ;

tatabase_case_prerequisite
  : '+' tatabase_case_obj_set tatabase_case_assign?
  ;

tatabase_case_input
  : '>' '{' obj=anybase_id '}'
  ;

tatabase_case_output
  : '=' tatabase_case_obj_assert
  ;

tatabase_case_obj_set
  : '{' name=anybase_id ':' tatabase_case_attrs_set '}'
  ;

tatabase_case_attr_set
  : name=anybase_id '=' value=tatabase_value
  ;

tatabase_case_attrs_set
  : tatabase_case_attr_set (',' tatabase_case_attr_set)*
  ;

tatabase_case_obj_assert
  : '{' name=anybase_id ':' tatabase_case_attrs_assert '}' ('#' '(' anybase_id '=' tatabase_value ')')?
  ;

tatabase_case_attr_assert
  : name=anybase_id cmpr=('=' | '<' | '<=' | '>' | '>=' | '!=') value=tatabase_value
  ;

tatabase_case_attrs_assert
  : tatabase_case_attr_assert (',' tatabase_case_attr_assert)*
  ;