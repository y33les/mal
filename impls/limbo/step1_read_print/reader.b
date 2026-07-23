implement Reader;

include "sys.m";
sys: Sys;

include "regex.m";
regex: Regex;

include "types.m";
maltypes: MalTypes;

include "draw.m";

include "reader.m";

init(nil: ref Draw->Context, nil: list of string)
{
	sys = load Sys Sys->PATH;
	regex = load Regex Regex->PATH;
	maltypes = load MalTypes "types.dis";
	maltypes->init();
	tokenise("(+ 1 2 3 4)");
}

tokenise(str: string)#: list of string
{
	(mal_re, nil) := regex->compile("[\\s,]*(~@|[\\[\\]{}()'`~^@]|\"(?:\\\\.|[^\\\\\"])*\"?|;.*|[^\\s\\[\\]{}('\"`,;)]*)", 0);
	match_from := 0;
	match_start: int;
	match_end: int;
	while (1)
	{
		match := regex->execute(mal_re, str[match_from:]);
		if (match == nil)
		{
			sys->print("syntax error\n");
			exit;
		}
		(match_start, match_end) = match[0];
		sys->print("%s\n", str[match_start:match_end]);
		match_from = match_end;
	}
}
