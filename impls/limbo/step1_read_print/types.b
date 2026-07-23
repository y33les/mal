implement MalTypes;

include "sys.m";
sys: Sys;

include "types.m";

init()
{
	sys = load Sys Sys->PATH;
}

mkint(val: int): ref MalType
{
	return ref MalType.Int(val);
}

mkreal(val: real): ref MalType
{
	return ref MalType.Real(val);
}

mkstring(val: string): ref MalType
{
	return ref MalType.String(val);
}

MalType.describe(mt: self ref MalType): string
{
	pick val := mt
	{
		Int => return sys->sprint("Int: %d", val.i);
		Real => return sys->sprint("Real: %f", val.r);
		String => return sys->sprint("String: %s", val.s);
	}
	return "Unknown type";
}
