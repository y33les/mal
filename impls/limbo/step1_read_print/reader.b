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
	#tokenise("(+ 1 2 3 4)");
	out := tokenise("aaaa aaa aa a\n");
	printing: do
	{
		sys->print("%s\n", hd out);
		out = tl out;
	} while (out != nil);
	exit;
}

tokenise(str: string): list of string
{
	# kanaka's original mal regex:
        # [\s,]*(~@|[\[\]{}()'`~^@]|"(?:\\.|[^\\"])*"?|;.*|[^\s\[\]{}('"`,;)]*)
	(mal_re, nil) := regex->compile("[ \t\n\r]*(a*)", 1);
	match: array of (int, int);
	match_start := 0;
	match_end := 0;
	matches: list of string;
	out: list of string;
	matching: do
	{
		match = regex->execute(mal_re, str);
		(match_start, match_end) = match[1];
		matches = str[match_start:match_end] :: matches;
		str = str[match_end:];
	} while (str != "" && match_start != match_end && match != nil);
	reversing: do
	{
		out = hd matches :: out;
		matches = tl matches;
	} while (matches != nil);
	return out;
}
