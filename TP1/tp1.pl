#!/usr/bin/perl -s

our ($alpha);
use strict;
use utf8::all;

$/ = ''; # processar paragrafo a paragrafo

# var with the searched name
my $wanted = shift;

# list with the neighbords names
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
my $np     = qr[(\{.*?\})];
my $left   = qr[([ \w{}]+){1,5}];
my $right  = qr[(?=(([ \w{}]+){1,5}))];

# var with the output file
my $fileGraph = 'output.dot';
my $fileHisto = 'demo.dat';
my $OUTFILE;

while(<>){
    while(/$np$left\{$wanted\}$right/g){
      findNames($1);
      findNames($3);
    }
}

writeFile($fileGraph, 1);
writeFile($fileHisto, 0);

##### FUNCTIONS ######

sub findNames{
    my $words = shift;

    if($words =~ /$np/g){
        $names{$1}++;
    }
    return;
}

sub writeFile{
    my $file = shift;
    my $isGraph = shift;

    if (-f $file) {
        unlink $file
    }

    open $OUTFILE, '>>', $file;

    if($isGraph){
        print { $OUTFILE }("digraph G {\n");

        for(sort{$names{$a} <=> $names{$b}} keys %names){
            print{ $OUTFILE }("\t$wanted -> $_;\n");
        }

        print { $OUTFILE }("}\n");
    }
    else{
        my $i = 0;
        foreach my $name (keys %names){
            print{ $OUTFILE }("$i\t\t$name\t\t$names{$name}\n");
            $i = $i + 1;
        }
    }
    close $OUTFILE;
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
