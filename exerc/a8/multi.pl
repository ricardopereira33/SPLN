#!/bin/perl

use utf8::all;

my @opts;
my @opttxts;
my $topic;
my $optans;
my $txtans;
my $question;

my $string = join ("", <>);

if ($string =~ s/> (.*)//) {
    $topic = $1;
}

if ($string =~ /((.|\\\n)*?)\s*>\s*(.*?)\s*<\s*(.*)?/g) {
    $question = $1;
    $optans = $3;
    $txtans = $4;
    $question =~ s/\\\n/<br>/g;
}

while ($string =~ s/(.*?)\s*=\s*(.*)//) {
    push(@opts, $1);
    push(@opttxts, $2);
}

my %funcoes = lertemplates("multi.html");

my $linhas;
for (0..(@opts-1)) {
    $linhas .= linha(
	opt => $opts[$_],
	opttxt => $opttxts[$_]
    );
}

my $result = mkexer (
    topic => $topic,
    optans => $optans,
    question => $question,
    linhas => $linhas,
    txtans => $txtans
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
