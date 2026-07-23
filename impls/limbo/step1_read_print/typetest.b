implement TypeTest;

include "sys.m";
sys: Sys;

include "draw.m";

include "types.m";
maltypes: MalTypes;
MalType: import maltypes;

TypeTest: module {
	init: fn(nil: ref Draw->Context, nil: list of string);
};

init(nil: ref Draw->Context, nil: list of string) {
	sys = load Sys Sys->PATH;
	maltypes = load MalTypes "types.dis";
	maltypes->init();
	if (maltypes==nil)
	{
		sys->print("Error loading MalTypes\n");
		exit;
	}
	MalType: import maltypes;

	v1 := maltypes->mkint(42);
	v2 := maltypes->mkreal(3.142);
	v3 := maltypes->mkstring("Hello, world!");

	sys->print("%s\n", v1.describe());
	sys->print("%s\n", v2.describe());
	sys->print("%s\n", v3.describe());
}
