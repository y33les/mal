implement MAL;

include "sys.m";

	sys: Sys;

include "draw.m";

MAL: module

{

	init:   fn(ctxt: ref Draw->Context, args: list of string);

};

init(ctxt: ref Draw->Context, args: list of string)

{

	sys = load Sys Sys->PATH;

	while (1)
	{
		sys->print("%s\n", rep(readline("user> ")));
	}

}

READ(str: string): string
{
	return str;
}

EVAL(ast: string, env: string): string
{
	return ast;
}

PRINT(exp: string): string
{
	return exp;
}

rep(str: string): string
{
	return PRINT(EVAL(READ(str),""));
}

readline(prompt: string): string
{
	buf := array [Sys->ATOMICIO] of byte;
	stdin := sys->fildes(0);

	sys->print("%s", prompt);
	n := sys->read(stdin, buf, len buf);
	line := string buf[:n-1];
	return line;
}
