#!/bin/perl

use utf8::all;

my @pen;
my @ppl;
my @palavras;
my $enTopic;
my $plTopic;


my $string = join ("", <>);

if ($string =~ s/(.*?)\s*=\s*(.*)//) {
    $enTopic = $1;
    $plTopic = $2;
}

while ($string =~ /(.*?)\s*=\s*(.*?)\s*=\s*(.*)?/g) {
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
    enTopic => $enTopic, 
    plTopic => $plTopic,
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

__DATA__

__mkexer__

<!DOCTYPE html>
<html>
<head>
	<title>POLISH VOCABULARY QUIZ | THE WEATHER (POGODA) 1</title>
	<meta charset="UTF-8">
	<meta content="LearnPolishFeelGood.com" name="author" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<meta content="POLISH VOCABULARY QUIZ (Practice Exercise) | THE WEATHER (POGODA) 1 - Learn and practice talking about the weather in Polish" name="description">
	<meta content="POLISH VOCABULARY QUIZ (Practice Exercise) | THE WEATHER (POGODA) 1 - Learn and practice talking about the weather in Polish" name="keywords">
<style type="text/css">
@media (min-width: 601px) {
	
BODY {margin:0;padding:0;background-color: #ffffff;}

#wrapper {
	background-color: #ffffff;
	padding: 10px;
	margin-left: auto;
    margin-right: auto;
    width: 50%;
	min-width:800px;
	font-family: verdana;
	font-size: 12pt;
	color: #000000;}
}

@media (max-width: 600px) {
BODY {margin:0;padding:0;background-color: #ffffff;}

#wrapper2 {
	background-color: #ffffff;
	padding: 10px;
	font-family: verdana;
	font-size: 12pt;
	color: #000000;}
}


img {
    max-width: 100%;
    height: auto;
}

FORM { margin: 5px 0 }


A:visited {color:#336699}
A:link {color:#336699}

.inputchange {width:120;height:17;border: solid 1px #6699cc}

</style>
<script language="JavaScript" src="http://www.learnpolishfeelgood.com/letters.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
<!--
var score = 0;
var answer = new Array(§appl);
//Check and display score
function check(){
for(i=0;i<answer.length;i++){
  if(document.myform.elements[i].value.toLowerCase()==answer[i]){
    score++;
    }
  }
  alert(score + " out of " + answer.length + ".");
  score = 0;
}
//Put the correct answers into all the fields
function show(){
for(i=0;i<answer.length;i++){
  document.myform.elements[i].value = answer[i];
  }
}
//-->
</script>
<!-- Go to www.addthis.com/dashboard to customize your tools -->
<script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-570f697842c7e31c"></script>


<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
<script>
  (adsbygoogle = window.adsbygoogle || []).push({
    google_ad_client: "ca-pub-1174954976856705",
    enable_page_level_ads: true
  });
</script>
</head>


<body>

<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.async=true;
  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.3";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>




<div style="background:#336699;text-align:center;margin:auto;">
<a href="http://www.learnpolishfeelgood.com/index.html"><img src="http://www.learnpolishfeelgood.com/logo.gif" alt=""/></a>
</div>
<div id="wrapper">
<div id="wrapper2">
<div style="padding:10px;">
<div style="line-height: 150%;">
<a href="http://www.learnpolishfeelgood.com/index.html">HOME</a><br />
<a href="http://www.learnpolishfeelgood.com/polish-verb-tenses.html">VERBS/VERB TENSES</a>
<br />
<a href="http://www.learnpolishfeelgood.com/polish-adjectives-adverbs.html">ADJECTIVES/ADVERBS</a>
<br />
<a href="http://www.learnpolishfeelgood.com/polish-nouns-pronouns.html">NOUNS/PRONOUNS</a>
<br />
<a href="http://www.learnpolishfeelgood.com/polish-prepositions.html">PREPOSITIONS</a>
<br />
<a href="http://www.learnpolishfeelgood.com/vocabulary/index.html">POLISH VOCABULARY EXERCISES</a>
<br />
<a  href="http://www.learnpolishfeelgood.com/travelpolish/index.html">TRAVEL POLISH</a> (Survival Polish for travelers)
</div>
<br /><br />
<!-- AddThis Button BEGIN -->
<a href="https://www.facebook.com/LearnEnglishFeelGoodcom-332890315504/"><img src="http://www.learnenglishfeelgood.com/fbsmall.gif" width="32" height="32" alt="" /></a>&nbsp;<a href="https://twitter.com/lefgcom"><img src="http://www.learnenglishfeelgood.com/twitter-sm.gif" width="32" height="32" alt=""/></a>
<div class="addthis_sharing_toolbox" style="position:relative;left:0px;top:-14px;display:inline-block;white-space:nowrap;"></div> 
<br /><br />
<!-- AddThis Button END -->
<div class="fb-like" data-layout="button_count" data-action="like" data-show-faces="false" data-share="false"></div>
<br /><br />
<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
<!-- lpfg-resp -->
<ins class="adsbygoogle"
     style="display:block"
     data-ad-client="ca-pub-1174954976856705"
     data-ad-slot="5111566712"
     data-ad-format="auto"></ins>
<script>
(adsbygoogle = window.adsbygoogle || []).push({});
</script>
<br /><br />
<span class="bluebold">LEARN NEW POLISH VOCABULARY</span><br>
<span class="bluebold">Visual matching exercise for students of Polish</span>
<br><br>

TOPIC:<strong> §enTopic (§plTopic)</strong>
<br><br>
<em>Complete the following translations, using the following words: <strong> §appl2 </strong> Longa vida a El-Rei Toninho!
<br><br><br>
<!--EXERCISE START-->
<form name="myform" action="">

§linhas
<br>
<strong>Special Polish characters (click to insert):</strong>
		<br><br> 
      <a href="javascript:insertChar(261);" class="letters">ą</a>
      <a href="javascript:insertChar(262);" class="letters">Ć</a>
      <a href="javascript:insertChar(263);" class="letters">ć</a>
      <a href="javascript:insertChar(281);" class="letters">ę</a>
      <a href="javascript:insertChar(321);" class="letters">Ł</a>
      <a href="javascript:insertChar(322);" class="letters">ł</a>
      <a href="javascript:insertChar(324);" class="letters">ń</a>
      <a href="javascript:insertChar(211);" class="letters">Ó</a>
      <a href="javascript:insertChar(243);" class="letters">ó</a>
      <a href="javascript:insertChar(346);" class="letters">Ś</a>
	  <a href="javascript:insertChar(347);" class="letters">ś</a>
      <a href="javascript:insertChar(377);" class="letters">Ź</a>
      <a href="javascript:insertChar(378);" class="letters">ź</a>
	  <a href="javascript:insertChar(379);" class="letters">Ż</a>
      <a href="javascript:insertChar(380);" class="letters">ż</a>
<br><br><br>
<input type="button" value="Check Score" onClick="check();">
<input type="button" value="Show Solution" onClick="show();">
<input type="reset" value="Clear">
</form>
<br><br>
<a href="index.html">Back to list of exercises</a>
<br /><br /><br />




<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
<!-- lpfg-resp -->
<ins class="adsbygoogle"
     style="display:block"
     data-ad-client="ca-pub-1174954976856705"
     data-ad-slot="5111566712"
     data-ad-format="auto"></ins>
<script>
(adsbygoogle = window.adsbygoogle || []).push({});
</script><br /><br />
OUR OTHER SITES:<br />
<a href="http://www.learnspanishfeelgood.com/">LearnSpanishFeelGood.com</a> <br /> 
<a href="http://www.learnenglishfeelgood.com/">LearnEnglishFeelGood.com</a> <br /> 
<a href="http://www.businessenglishsite.com/">BusinessEnglishSite.com</a> <br /> 
<a href="http://www.englishliteracysite.com/">EnglishLiteracySite.com</a> <br /> 
<a href="http://www.englishformyjob.com/index.html">EnglishForMyJob.com</a> <br />  
<a href="http://www.eslpdf.com/">ESLPDF.com</a> <br />
<a href="http://www.infosquares.com/">Infosquares.com</a> <br />
<br />
CONTACT US: questions (at) learnpolishfeelgood (dot) com
<br /><br />

<div style="font-family: verdana;font-size: 10pt;color: #000000;">(c) 2008-2016 LearnPolishFeelGood.com.  All rights reserved. Please contact us before sharing our content.
</div>
<br /><br />
</div>
</div>
</div>
</body>
</html>

__linha__

§en = §pl <INPUT TYPE="text" VALUE="" class="inputchange">.
<br><br>
