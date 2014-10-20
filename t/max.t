# -*-perl-*-

use Test; plan test => 2;
use Event 0.37 qw(loop unloop unloop_all sleep);
use Event::Stats;

# $Event::DebugLevel = 2;

$Event::DIED = sub {
    my ($e,$why) = @_;
    ok $why, '/timed out/';
    unloop_all;
};

my $runs=0;
Event->timer(e_desc => "stuck", e_interval => .1, e_cb => sub {
		 if ($sub and ++$runs > 25) {
		     sleep 1;
		 }
	     });
Event->timer(e_desc => "nest", e_after => 0, e_interval => .1,
	     e_cb => sub {
		 return if $sub;
		 local $sub=1;
		 loop;
	     });
Event::Stats::enforce_max_callback_time(1);

loop;
ok $runs > 20;
