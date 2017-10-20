#!/usr/bin/perl -s

our ($alpha);
use strict;
use utf8::all;
$/ = ''; # processar paragrafo a paragrafo


# list with the neighbords names
my %names;

# regex to find the left and right side (the $center is for all names)
my $left   = qr[(?<=\b(.{21}))];
my $center = qr[\{(.*?)\}];
my $right  = qr[(?=(.{21}))];

# var with the searched name
my $wanted = "{Cosette}";

my $files = 'output.dot';
my $OUTFILE;

while (<>){
    while(/$left$wanted$right/g){
      print("-------------------------------------------------\n");
      print("Left = '$1' \nCenter =  '$wanted'\nRight = '$2'\n");
      print("Original Phrase: $1 $wanted $2\n");
      print("-------------------------------------------------\n");
      findNames($1);
      findNames($2);
    }
}

#print("============== LIST =====================\n");
#print("=\tNames\t\tTimes\t\t=\n");
#print("=---------------------------------------=\n");
#for(sort{$names{$a} <=> $names{$b}} keys %names){
#    print("|=>\t$_\t\t$names{$_}\n");
#}
#print("\n============== END =====================\n");

if (-f $files) {
    unlink $files
}

open $OUTFILE, '>>', $files

for(sort{$names{$a} <=> $names{$b}} keys %names){
    print("$wanted -> $names{$_}\n");
}

print { $OUTFILE } "Something\n"

close $OUTFILE

# FUNCTIONS

sub findNames{
    my $words = shift;
    print("Phrase:\t$words\n\n");

    if($words =~ /$center/g){
        print("-> Find:\t$1\n\n");
        $names{$1}++;
    }

    return;
}


## Man instructions

__END__
=head1 NAME

TP1

=head1 SYNOPSIS

    tp1.pl input.txt

=head1 DESCRIPTION

Regista todos os nomes anotados numa vizinhança de k caracteres.

=head2 EXPORT

=head1 HISTORY

=head1 SEE ALSO

=head1 AUTHOR

Bruno Cancelinha and Ricardo Pereira
