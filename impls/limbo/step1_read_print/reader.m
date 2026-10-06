Reader: module
{
	init: fn(nil: ref Draw->Context, nil: list of string);
	#Reader: adt
	#{
	#	tokens: list of string;
	#	pos: int;
	#	next: fn(r: self ref Reader): str;
	#	peek: fn(r: self ref Reader): str;
	#};
	tokenise: fn(str: string): list of string;
	#read_str: fn(str: string): ref Reader;
	#read_form: fn(r: Reader): ref MalType;
	#read_list: fn(r: Reader): ref MalType;
	#read_atom: fn(r: Reader): ref MalType;
};
