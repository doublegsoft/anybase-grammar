grammar Mathbase;     

import Anybase, Typebase, Valuebase;

MATHBASE_SLASH:                         '\\';
MATHBASE_VALUE_INFINITY:                '\\infty';
MATHBASE_VALUE_CDOTS:                   '...';

mathbase_greek_letters
    :   'alpha'
    |   'Alpha'
    |   'beta'
    |   'Beta'
    |   'gamma'
    |   'Gamma'
    |   'pi'
    |   'Pi'
    |   'phi'
    |   'Phi'
    ;

mathbase_symbols
    :   'integral'
    ;

mathbase_operators
    :   '^'
    |   '+'
    |   '-'
    |   '!'
    |   'frac'
    |   'sqrt'
    |   'sin'
    |   'cos'
    |   'tan'
    |   'lim'
    ;

mathbase_value_simple
    :   valuebase_anyvalue
    |   anybase_identifier
    |   MATHBASE_VALUE_INFINITY
    |   MATHBASE_VALUE_CDOTS
    ;

mathbase_value_initial
    :   elm=anybase_identifier '=' init=anybase_int
    ;

mathbase_value_indexed
    :   elm=anybase_identifier '_' idx=anybase_identifier
    ;

mathbase_value
    :   mathbase_value_simple
    |   mathbase_value_indexed
    |   mathbase_operation_fraction
    |   mathbase_operation_square_root
    |   mathbase_operation_sum
    |   mathbase_operation_product
    |   mathbase_operation_integrals
    ;

mathbase_operation_fraction
    :   '\\frac' '{' dividend=mathbase_arithmetic '}' '{' divisor=mathbase_arithmetic '}'
    ;

mathbase_operation_square_root
    :   '\\sqrt' ('[' n=mathbase_arithmetic ']')? '{' radicand=mathbase_arithmetic '}'
    ;

// $$\sum_{n=1}^{\infty} 2^{-n} = 1$$
mathbase_operation_sum
    :   '\\sum_' '{' lower=mathbase_value_initial '}' '^' '{' upper=mathbase_arithmetic '}' expr=mathbase_arithmetic
    ;

// $$\prod_{i=a}^{b} f(i)$$
mathbase_operation_product
    :   '\\prod_' '{' lower=mathbase_value_initial '}' '^' '{' upper=mathbase_arithmetic '}' expr=mathbase_arithmetic
    ;

// $$\int_{a}^{b} x^2 dx$$
mathbase_operation_integrals
    :   '\\int_' '{' mathbase_value_simple '}' '{' mathbase_value_simple '}' mathbase_arithmetic
    ;

mathbase_arithmetic
    :   mathbase_arithmetic (add='+' | subtract='-') mathbase_arithmetic
    |   mathbase_arithmetic (multiply='\\times' | divide='\\div' | power='^') mathbase_arithmetic
    |   mathbase_arithmetic factorial='!'
    |   '(' mathbase_arithmetic ')'
    |   mathbase_value 
    ; 

mathbase_formula_name
    :   anybase_identifier
    ;

mathbase_formula_parameter
    :   anybase_identifier
    ;

anybase_identifier_parameters
    :   mathbase_formula_parameter (',' mathbase_formula_parameter)*
    ;

mathbase_formula
    :   mathbase_formula_name '(' anybase_identifier_parameters ')' '=' mathbase_arithmetic 
    ;