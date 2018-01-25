#! /usr/bin/perl
$\ = "\n";

use strict;
use utf8::all;


while(<>){
    $reply = readLine($_);
    write($reply);
}



sub readLine{
    $line = shift;
    # process line

}
