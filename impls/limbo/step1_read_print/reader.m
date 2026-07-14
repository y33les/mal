Reader: module
{
	init: fn(ctxt: ref Draw->Context, args: list of string);
	Reader: adt
	{
		tokens: list of string;
		pos: int;
	};
	next: fn(r: Reader): str;
	peek: fn(r: Reader): str;
	read_str: fn(str: string): Reader;
	read_form: fn(r: Reader): MalType;
	read_list: fn(r: Reader): MalType;
	read_atom: fn(r: Reader): MalType;
};
