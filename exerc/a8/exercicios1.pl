#!/bin/perl

use utf8::all;

my @pen;
my @ppl;
my @palavras;


my $string = q{
It's very humid today. = Dzisiaj jest bardzo = wilgotno
Arizona has a dry climate. = Arizona ma bardzo suchy = klimat
It's going to be sunny tomorrow. = Jutro będzie = słonecznie
The sky is clear. = Niebo jest = czyste
It's windy. = Jest = wietrznie
The snow melted. =  się roztopił. = śnieg
I like the rain. = Lubię = deszcz 
It's very hot today. = Dzisiaj jest bardzo = gorąco
It's cold. = Jest = zimno
What's the weather like? = Jaka jest = pogoda };

while ($string =~ /(.*?)\s*=\s*(.*?)\s*=\s*(.*)/g) {
    push(@pen, $1);
    push(@ppl, $2);
    push(@palavras, $3);
}

#my $linhas = join("", map {aplicafuncao("linha", en => $pen{$_}, pl => $ppl{$_})} 0..(@pen-1));
my %funcoes = lertemplates("pvw.html");

my $linhas;
for (0..(@pen-1)) {
    $linhas .= ".".($_+1).linha (
	en => $pen[$_],
	pl => $ppl[$_]);
}
#my $result = aplicafuncao("mkexer",
my $result = mkexer (
    enTopic => "Weather",
    plTopic => "POGODA!!",
    appl => join (",", map {qq("$_")} @palavras), 
    appl2 => join (", ", map {qq($_)} @palavras),
    linhas => $linhas
);

print $result;

sub aplicafuncao {
    my $nome = shift;
    my %params = @_;

    my $result = $funcoes{$nome};
    for (keys %params) {
	$result =~ s/§$_\b/$params{$_}/g;
    }

    return $result;
}

sub lertemplates {
    my $filename = shift;
    open(F, $filename) or die("Can't open file $filename!\n");
    my $text = join("", <F>);
    close(F);

    my %funcoes;
    while($text =~ /__(\w+)__(.*?)(?=\n__|$)/gs) {
	$funcoes{$1} = $2;
	eval "sub $1 {aplicafuncao('$1', \@_)}";
    }

    return %funcoes;
}
