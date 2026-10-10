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
	#out := tokenise("(+ 1 2 3 4)");
	#out := tokenise("aaaa xyzzy 2 234 ab12cd # b&#c (fnord aaa) {aa aa} [a a a 2 # ]\n");
	r := read_str("(+ 1 2 3 4)\n");
	printing: do
	{
		out = r.next();
		sys->print("%s, ", out);
	} while (out != nil);
	sys->print("\n");
	exit;
}

Reader.next(r: self ref Reader): str
{
	return r.tokens[r.pos++];
}

Reader.peek(r: self ref Reader): str
{
	return r.tokens[r.pos];
}

read_str(str: string): ref Reader
{
	r: Reader;
	r.tokens = tokenise(str);
	r.pos = 0;
	return r;
}

tokenise(str: string): list of string
{
	# kanaka's original mal regex:
        # [\s,]*(~@|[\[\]{}()'`~^@]|"(?:\\.|[^\\"])*"?|;.*|[^\s\[\]{}('"`,;)]*)
	# Stages of reimplementing each section of the regex:
	#mal_regexp := "[ \t\n\r\v\f]*(~@|[\\[\\]{}\\(\\)'`~\\^@]|a*)"; # Whitespace and ~@
	#mal_regexp := "[ \t\n\r\v\f]*(\"(\\\\.|[^\\\"])*\"?|a*)";      # Special characters
	#mal_regexp := "[ \t\n\r\v\f]*(;.*|a*)";                        # Quoted strings
	#mal_regexp := "[ \t\n\r\v\f]*([^ \t\n\r\v\f\\[\\]{}\\('\"`,;\\)]*|a*)"; # Sequences of non-special characters
	mal_regexp := "[ \t\n\r\v\f]*(~@|[\\[\\]{}\\(\\)'`~\\^@]|\"(\\\\.|[^\\\"])*\"?|;.*|[^ \t\n\r\v\f\\[\\]{}\\('\"`,;\\)]*)";
	(mal_re, nil) := regex->compile(mal_regexp, 1);
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
