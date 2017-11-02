#!/usr/bin/perl -s

our ($alpha);
use strict;
use utf8::all;
use Switch;

$/ = ''; # processar paragrafo a paragrafo

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

# var with the output file
my $fileGraph = 'graph.dot';
my $fileHisto = 'demo.dat';
my $OUTFILE;

# flag option
my $option;

# window size
my $num;

# var with the searched name
my $wanted;

if ( ($#ARGV + 1) < 1 ) {
    print "\nUsage:\trelationNP [option g] [window size] [file]\n";
    print "\trelationNP [option r] [window size] [name] [file]\n";
    print "\nHelp:\trelationNP h\n";
    exit;
}
else{
    switch($ARGV[0]){
        case "h"    { printHelpMenu();
                      exit;
                    } 
        case "g"    { shift;
                      $option = 0;
                      $num = shift;
                    }
        case "r"    { shift;
                      $option = 1;
                      $num = shift;
                      $wanted = shift;
                    } 
        else        { exit; } 
    }
}

# regex to find the left and right side (the $center is for all names)
my $np     = qr[(\{.*?\})];
my $left   = qr[([ \w{}]+){1,$num}];
my $right  = qr[(?=(([ \w{}]+){1,$num}))];

# regex to find the np in a window
my $npp    = qr[(\{[^{]*\})];
my $words  = qr[([ \w{}]+){1,$num}];

while(<>){
    if($option){
        while(/$np$left\{$wanted\}$right/g){
            findNames($1);
            findNames($3);
        }
    }
    else{
        while(/$npp$words $npp/g){
            addRelation($1, $3);
        }
    }
}

if($option){
    writeFile($fileGraph, 1);
    writeFile($fileHisto, 0);
}
else{
    writeFile($fileGraph, 2);
}

##### FUNCTIONS ######

sub findNames{
    my $words = shift;
    my $aux;

    if(($words =~ /$np/g) and not(grep {$1 eq $_} @failed)){
	$aux = $1;
	$aux =~ s/[{}]//g;
        $names{$aux}++;
    }
}

sub addRelation {
    my $a = shift;
    my $b = shift;

    $a =~ s/[{}]//g;
    $b =~ s/[{}]//g;

    if (not((grep {$a eq $_} @failed) or (grep {$b eq $_} @failed))) {
        $names{$a}{$b}++;
    }
}

sub writeFile{
    my $file = shift;
    my $isGraph = shift;

    if (-f $file) {
        unlink $file
    }

    open $OUTFILE, '>>', $file;

    switch($isGraph){
        case 0  {   my $i = 0;
                    foreach my $name (keys %names){
                        print{ $OUTFILE }("$i\t\t$name\t\t$names{$name}\n");
                        $i = $i + 1;
                    }
                }

        case 1  {   print { $OUTFILE }("digraph G {\n");

                    for(sort{$names{$a} <=> $names{$b}} keys %names){
                        print{ $OUTFILE }("\t$wanted -> \"$_\";\n");
                    }

                    print { $OUTFILE }("}\n");
                }

        case 2  {   print { $OUTFILE }("strict graph G {\n");

                    foreach my $name (sort keys %names) {
                        foreach my $other (keys %{ $names{$name} }) {
                        print{ $OUTFILE }("\t\"$name\" -- \"$other\";\n");
                        }
                    }

                    print { $OUTFILE }("}\n");
                }

        else    { print "Error\n"; }
    }
    close $OUTFILE;
}

sub printHelpMenu{
    print "\nUsage:\trelationNP [option g] [window size] [file]\n";
    print "\trelationNP [option r] [window size] [name] [file]\n";
    print "\nOptions: \n";
    print "g :\tscans an input file and finds all realtions between all NPs\n";
    print "r :\tscans an input file and finds all realtion with a given name\n";
    print "h :\tlist available command line options\n";
    print "\nWindow size: \n";
    print "\tSize of the window (in number of words) where to catch other NPs.\n";
    print "\nName: \n";
    print "\tThe name that is searched for.\n";
    print "\nFile: \n";
    print "\tName of the input file.\n"
}

#### Man instructions ####

__END__
=head1 NAME

relation -- relation a gived name with others names for a specific distance of words

=head1 SYNOPSIS

    relation [name] [file]

=head1 DESCRIPTION

Register all own names for a specific distance of words. The input file most be annotated.

=head2 USAGE
    relationNP [option] [args...] [filename]

Take note that "filename" must be an annotated file. To do this just run
    anotarNP [filename] > anotated_file.txt 

To display the help menu, type
    ralationNP h

The output file is "graph.dot" to compile this into a pdf file run
    dot -Tpdf graph.dot > a.pdf

=head2 DEPENDENCIES
    Switch
    Filter::Util::Call
    Text::Balanced 

=head2 EXPORT

=head1 HISTORY

=head1 SEE ALSO
gnuplot(1), dot(1)

=head1 AUTHOR

Bruno Cancelinha and Ricardo Pereira
