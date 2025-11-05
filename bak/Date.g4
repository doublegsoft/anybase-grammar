grammar Date;     

ONE_NINE
    : [1-9]
    ;

ZERO_NINE
    : [0-9]
    ;

year
    : (('1'|'2') ZERO_NINE?) | (ZERO_NINE? ZERO_NINE)
    ;

month
    : '0'? ONE_NINE
    | '1' ('1' | '2')
    | 'Jan'
    | 'Feb'
    | 'Mar'
    | 'Apr'
    | 'May'
    | 'Jun'
    | 'Jul'
    | 'Aug'
    | 'Sep'
    | 'Oct'
    | 'Nov'
    | 'Dec'
    | 'January'
    | 'Feburary'
    | 'March'
    | 'April'
    | 'June'
    | 'July'
    | 'August'
    | 'September'
    | 'October'
    | 'November'
    | 'December'
    ;

day
    : '0'? ONE_NINE
    | '1' ZERO_NINE
    | '2' ZERO_NINE
    | '3' ZERO_NINE
    ;

date
    : year '-' month '-' day
    | day '-' month '-' year
    | month '-' day '-' year
    ;
       

