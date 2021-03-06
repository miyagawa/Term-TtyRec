use strict;
use Test::More tests => 2;

use IO::File;
use Term::TtyRec::Player;

my $handle = IO::File->new('t/test.tty');
my $player = Term::TtyRec::Player->new($handle);
isa_ok($player, 'Term::TtyRec::Player');

{
    package Tie::DevNull;
    require Tie::Handle;
    @Tie::DevNull::ISA = qw(Tie::Handle);

    sub TIEHANDLE { bless {}, shift }
    sub WRITE { 1 }
}

tie *STDOUT, 'Tie::DevNull';
eval {
    local $SIG{ALRM} = sub { die "alarm\n" };
    alarm 1;
    $player->peek;
    alarm 0;
};
untie *STDOUT;
ok $@, 'can peek';



