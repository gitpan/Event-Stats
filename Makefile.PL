# This -*- perl -*- script makes the Makefile!

use ExtUtils::MakeMaker;
use Event::MakeMaker ('event_args');

# Parasoft's Insure++!
@Safe = (
	 OPTIMIZE => '-g',
	 CC => 'insure',
	 LD => 'insure',
	)
    if 0;

my @opt=(PREREQ_PM => { Test => 1,
			Event => '0.53',
			'Time::HiRes' => 1.20 },
	 VERSION_FROM	=> "./Stats.pm",
	 NAME      	=> "Event::Stats",
	 @Safe,
	);

WriteMakefile(event_args(@opt));