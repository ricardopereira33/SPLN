#!/usr/bin/perl -s

our ($alpha);
use strict;
use utf8::all;

$/ = ''; # processar paragrafo a paragrafo

# var with the searched name
#my $wanted = "Cosette";
my $wanted = shift;

# list with the neighbords names
my %names;
# lists failed names
my %failed = ("Em", "Aquela", "Lá", "Isto", "Duas", "Chamava", "Verão", "Assim", "Bem");

# regex to find the left and right side (the $center is for all names)
#my $left   = qr[(?<=\b(.{21}))];
my $np= qr[(\{.*?\})];
my $left   = qr[(([ \w{}]+){1,5})];
my $center = qr[\{(.*?)\}];

# var with the output file
my $files = 'output.dot';
my $OUTFILE;

while (<>){
    while(/$np$left\{$wanted\}$right/g){
      print("-------------------------------------------------\n");
      print("Left = '$1 $2' \nCenter = '$wanted'\nRight = '$4'\n");
      print("Original Phrase: $1 $2 $wanted $4\n");
      print("-------------------------------------------------\n");
      findNames($1);
      findNames($2);
    }
}


# write in a file
if (-f $files) {
    unlink $files
}

open $OUTFILE, '>>', $files;

print { $OUTFILE }("digraph G {\n");

for(sort{$names{$a} <=> $names{$b}} keys %names){
    print{ $OUTFILE }("\t$wanted -> $_;\n");
}

print { $OUTFILE }("}\n");

close $OUTFILE;


# FUNCTIONS

sub findNames{
    my $words = shift;
    print("Phrase:\t$words\n\n");

    if($words =~ /$center/g && ){
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

=head2 DEPENDENCIES
Chart::OFC2

=head2 EXPORT

=head1 HISTORY

=head1 SEE ALSO

=head1 AUTHOR

Bruno Cancelinha and Ricardo Pereira
