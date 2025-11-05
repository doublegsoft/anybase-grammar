grammar Actionbase;

import Anybase;

ESC:        '\\"' | '\\\\' ; // 2-char sequences \" and \\
WS:         [ \t\r\n]+ -> skip;

actionbase_id
	:   anybase_identifier
	;

actionbase_host
	:		anybase_int '.' anybase_int '.' anybase_int '.' anybase_int
	;	

actionbase_url_scheme
	:		'http'
	|		'https'
	|		'ssh'
	|		'sftp'
	|		'grpc'
	|		'rest'
	|		'file'
	;	

actionbase_url_part
	:		'/' actionbase_id
	;

actionbase_url
	:		actionbase_url_scheme '://' host=actionbase_host actionbase_url_part*
	;

actionbase_if
	:		actionbase_comparison '?' actionbase_statement
	;	

actionbase_error
	:		'error' '(' code=anybase_int ',' message=anybase_string ')'
	;	

actionbase_statement
	:		actionbase_error
	|		actionbase_attribute_assignment
	|		actionbase_object_assignment
	|		actionbase_if
	;	
    
actionbase_constant
	:		'`' constant=actionbase_id '`'
	;
		
actionbase_persistent
	:		'@' attribute=actionbase_id '=' variant=actionbase_variant
	;
		
actionbase_variant
	:		'$' name=actionbase_id
	;
		
actionbase_action
	:		actionbase_id
	;
		
actionbase_operand
	:		variant=actionbase_variant
	|		number=anybase_number
	|		constant=actionbase_constant
	|		persistent=actionbase_persistent
	|		nil='null'
	;
		
actionbase_expression
	:		left=actionbase_expression mul_div=('*' | '/' | '^') right=actionbase_expression
	|		left=actionbase_expression add_sub=('+' | '-') right=actionbase_expression
	|		operand=actionbase_operand
	|		'(' single=actionbase_expression ')'
	;
		
actionbase_comparison
	:		left=actionbase_operand operator=('>' | '>=' | '<' | '<=' | '==' | '!=') right=actionbase_operand
	|		first=actionbase_comparison conj=('||' | '&&') second=actionbase_comparison
	|		'(' single=actionbase_comparison ')' 
	;
		
actionbase_attribute_assignment
	:		name=actionbase_id ('=' (constant=actionbase_constant | operand=actionbase_operand | expression=actionbase_expression))?
	;
		
actionbase_attributes
	:		actionbase_attribute_assignment (',' actionbase_attribute_assignment)*
	;
		
actionbase_object_assignment
	:		name=actionbase_id '(' actionbase_attributes ')'
	;
		
actionbase_pipe
	:		('??' comparison=actionbase_comparison)? '||' action=actionbase_action '@' actionbase_object_assignment
	;
		
actionbase_input
	:		'##' action=actionbase_action '@' actionbase_object_assignment actionbase_pipe*
	;

actionbase_program
	:		actionbase_url
	;	