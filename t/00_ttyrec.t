use strict;
use Test::More 'no_plan';

use IO::File;
use Term::TtyRec;

my $handle = IO::File->new('t/test.tty');
my $data = Term::TtyRec->new($handle);
isa_ok($data, 'Term::TtyRec');

my($sec, $text) = $data->read_next;
like $text, qr/Thu Sep 27/, 'prompt check';
