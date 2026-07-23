MalTypes: module
{
	init: fn();
	MalType: adt
	{
		pick
		{
			Int => i: int;
			Real => r: real;
			String => s: string;
		}
		describe: fn(c: self ref MalType): string;
	};
	mkint: fn(val: int): ref MalType;
	mkreal: fn(val: real): ref MalType;
	mkstring: fn(val: string): ref MalType;
};
