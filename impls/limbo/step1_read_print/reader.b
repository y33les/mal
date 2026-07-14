implement Reader;

include "sys.m";
	sys: Sys;

include "draw.m";
include "reader.m";

init(ctxt: ref Draw->Context, args: list of string)
{
	sys = load Sys Sys->PATH;
}

greet(name: string)
{
	sys->print("Hello, %s!\n", name);
}
