#!/usr/bin/perl -s

our ($alpha);
use strict;
use utf8::all;
use List::MoreUtils qw(any);

$/ = ''; # processar paragrafo a paragrafo

# Map with o relacionamento de toda a gente
my %names;

# lists failed names
my @failed = ("Em", "Aquela", "Lá", "Isto", "Duas", "Chamava", "Ao",
    "Verão", "Assim", "Bem", "Era", "Eis", "Foi", "Aí", "Vi", "Uma",
    "Lembrou-se", "Onde", "Dois", "Meu", "Isso", "Eu", "Limitamo-nos",
    "Dizendo-me", "No", "Na", "Não", "Quem", "Perdão", "Prato", "Ouvira", "Que",
    "Atirem", "Já", "Quis", "Sossega", "Fui", "Se", "Tendo", "Ideal", "Tão",
    "Ordem", "Estão", "Pois", "Quanto", "Tu", "Queira", "Tinha", "Terminada",
    "Coisa", "Todos", "Tornar", "Fará", "Contacto", "Nada", "Os", "As", "Para");

# regex to find the left and right side (the $center is for all names)
my $np     = qr[(\{[^{]*\})];
my $words  = qr[([ \w{}]+){1,5}];

# var with the output file
my $files = 'graph-geral.dot';
my $OUTFILE;

while (<>){
    while(/$np$words $np/g){
      addRelation($1, $3);
    }
}

#### FUNCTIONS ####

sub addRelation {
    my $a = shift;
    my $b = shift;

    $a =~ s/[{}]//g;
    $b =~ s/[{}]//g;

    if (not((grep {$a eq $_} @failed) or (grep {$b eq $_} @failed))) {
	    $names{$a}{$b}++;
    }
}

#### GENERATES GRAPH ####

if (-f $files) {
    unlink $files
}

open $OUTFILE, '>>', $files;

print { $OUTFILE }("strict graph G {\n");

foreach my $name (sort keys %names) {
    foreach my $other (keys %{ $names{$name} }) {
	print{ $OUTFILE }("\t\"$name\" -- \"$other\";\n");
    }
}

print { $OUTFILE }("}\n");

close $OUTFILE;

#### Man instructions ####

__END__
=head1 NAME

general

=head1 SYNOPSIS

    tp1.pl input.txt

=head1 DESCRIPTION

Regista todos os nomes anotados numa vizinhança de k caracteres.

=head2 DEPENDENCIES

=head2 EXPORT

=head1 HISTORY

=head1 SEE ALSO

=head1 AUTHOR

Bruno Cancelinha and Ricardo Pereira
