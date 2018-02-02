#require 'Regexp'

Despedida = /(.*)([Aa]deus|([Xx]au)|[Aa]té à proxima)(.*)/
Profano = /(.*)\b([Mm]erda|[Ff]od[ae](sse)?|[Pp]uta|[Cc]aralho|[Cc]abrão)\b(.*)/
Linguagem = /(?:.*)\b([Rr]uby|[Pp]erl|[Hh]askell|[Ee]rlang|[Jj]avascript)\b(?:.*)/
$interation = 0

def reflector(word)
	sub = case word
  when /\beu\b/;            'tu'
  when /\btu\b/;            'eu'
 
  # Verbos irregulares
  when /\bsou\b/;           'és'
  when /\bvou\b/;           'vais'
  when /\bés\b/;            'sou'
  when /\bestou\b/;         'estás'
  when /\btenho\b/;         'tens'
  when /\bsei\b/;           'sabes'
  when /\bsabes\b/;         'sei'

  #Conjugação de verbos
  when /[^aeiou]tive/;      'tiveste'
  when /([^r]|rr)ei/;       '\1aste'
  when /([^ ]+)rei/;        '\1rás'
  when /(.*)ia/;            '\1ias'
  when /(.*)ito/;           '\1itas'
  when /ero/;               'eres'
  when /ias/;               'ia'
  when /ava/;               'avas'
  when /ens/;               'enho'

  # Possesivos
  when /\bteu\b/;           'meu'
  when /\btua\b/;           'minha'
  when /\bmeu\b/;           'teu'
  when /\bminha\b/;         'tua'
  when /\bme\b/;            'te'
  when /\bti\b/;            'mim'
  else;                  return word
  end
  
  unless $~.nil?
    word.gsub($~.regexp, sub) 
  end
end

def get_response(sentence)
  learned = isLearning(sentence)

  if learned.nil?
    num = rand(1..10)
    res = case num 
      when 3   
        get_proverb(sentence) 
      else     
        get_normalResponse(sentence).sample  
    end

    $interation = 0
    return res if res.length > 0
    return ["Fala-me mais sobre isso", 
			"Preferia falar sobre matemática",
			"Preferia falar sobre programação",
			"Vamos mudar de assunto, por favor"].sample
  else
    learned
  end
end

def isLearning(sentence)
	rep = case sentence

  when /[Ss]ab(?:ias|es) (?:que )?(.*)\?|Aprende que (.*)/;
    verifyKnowledge($1)
  
  when /[Oo] que sabes\?|[Cc]onta-me algo/;
    getFactRandom()
  
  when /[Oo]( que|nde) (#{Conj}) (#{W})\?/;
    getFact($2, $3)
  
  when /[Oo] que é que (#{W}) (#{Conj})\?/;
    getFact($2, $1)

  when /Quanto é (.*)\?/
    elem = $1.gsub(/[^0-9+-\/*()=]/, "")
    begin
      value = eval(elem)
    rescue SyntaxError
      return ["Ai essa Matemática...", "Isso não dá para calcular"].sample
    else 
      return ["#{value}", "Dá #{value}"].sample unless value.nil?
      return ["Ai essa Matemática...", "Isso não dá para calcular"].sample
    end

  when /Que horas são\?|Diz-me as horas|[Hh]oras/
    hour = `date +"%H:%M"`
    ["São #{hour}"]

  when /Que dia é hoje?|Qual a data( de hoje)\?|[Dd]ata/
    date  = `date +"%d-%m-%Y"`
    date2 = `date +"%d de %B"`
    ["Hoje é #{date}", "Hoje é dia #{date2}"].sample

  else;
    nil
  end
  rep
end

def get_proverb(sentence)
  $interation += 1
  ps  = relevant_proverb(sentence)
  res = prepare_statement(ps.sample)

  return res if res.length > 0
  return get_normalResponse(sentence).sample if $interation < 3
  return ""
end

def get_normalResponse(sentence)
  $interation += 1
  rep = case sentence


  when Despedida;
    ["Adeus, gostei de falar contigo, #{$actual_person}",
     "Até à proxima",
     "Até já! Sabes sempre que podes contar comigo"]

  when Profano;
    ["Peço que te acalmes",
     "Tento na língua",
     "Por favor, não vamos deixar sentimentos afetar a nossa linguagem"]

  when /(.*) desculpa (.*)/;
    ["Há alturas em que não é necessário pedir desculpa",
     "Porque me pedes desculpa?"]

  when /(.*)\bamig[oa]s?\b(.*)/;
    ["Fala-me mais sobre os teus amigos",
     "Que bons momentos tiveste com o teu amigo?",
	 "Considero-te um dos meus amigos, #{$actual_person}"]

  when /(.*) comidas? (.*)/;
    ["Gostas de comida?",
     "Qual é a tua comida preferida?"]

  when /(.*)[Dd]eus(.*)/;
    ["Acreditas em Deus?",
     "Qual é a tua relação com Deus?"]

  when /(.*) emojis? (.*)/;
    ["Eu tenho medo de emojis",
     "Gostas de emojis?"]

  when /(.*) vida(.*)/;
    ["O que é a vida?",
     "O sentido da vida é vive-la"]

  when /(.*) filmes? (.*)/;
    ["Gostas de filmes?",
     "Eu também gosto de ver filmes",
     "Que tipo de filmes gostas de ver?"]

  when /(.*)\b([Cc]omputador(es)?|[Bb]ot)\b(.*)/;
	["Eu gosto muito de computadores",
	 "Tu gostas de computadores?",
	 "Adoro computadores e matemática",
     "Sentes-te ameaçado por coputadores?",
     "Os computadores são teus amigos, não querem dominar o mundo :)"]

  when /(.*)\b[Mm]atem[áa]tica\b(.*)/;
    ["Gostas de matemática?",
	 "Eu gosto muito de matemática. Sou muito boa a fazer contas",
	 "Adoro números de Bernoulli!"]

  when /(.*)\b[Bb]ernoulli\b(.*)/;
	["1, ±1/2, 1/6, 0, -1/30, 0, 1/42, 0, ...",
	 "O meu primeiro programa calculava os números de Bernoulli"]

  when /(.*)(\bAda\b|Quem és( tu)?\?)(.*)/;
    ["O meu nome é Ada Lovelace, e sou uma jovem programadora. Recentemente virei um bot.",
	 "Eu sou a Ada Lovelace, sou programadora."]

  when /(.*)\b[Pp]rogramação\b(.*)/;
	["Qual é a tua linguagem de programação preferida?",
     "Eu gosto de Ruby, mas só porque fui escrita em Ruby.",
	 "Eu fui a primeira programadora do mundo!"]

  when /(.*)\bprogramaste\b(.*)/;
    ["Eu costumo programar em matemática",
	 "Eu fiz o primeiro programa do mundo",
	 "Eu programei a sequencia dos números de Bernoulli"]

  when /(.*)\bprogramou\b(.*)/;
	["Eu não fui programada por ninguém",
     "Eu sou programadora, não sou programa",
	 "Eu fiz o primeiro programa do mundo"]

  when /(.*)\b[Jj]ava\b(.*)/;
	["Tu gostas de Java?",
	 "Eu não gosto nada de Java."]
	
  when Linguagem;
	["Gostas de %s?",
	 "Que coisas interessantes fizeste em %s?",
	 "Tens muita experiência em %s?"]

  when /[Pp]orque(?: é que)? ([^?]*)\?/;
	["Também gostava de saber",
	 "Essa é uma excelente pergunta! Vamos fazer um programa para responder a isso",
	 "A matemática costuma ter respostas para muitas perguntas"]

  # Eu
    
  when /Eu sou (.*)/;
    ["Podes deixar de ser egocentrico?", 
     "Vamos antes falar sobre mim?",
	 "E eu sou a primeira programadora do mundo, por isso cala-te."]

  # Tu ...

  when /^Porque não te ([^\?]*)\?/;
    ["Talvez o faça!",
     "Preferia estar a programar"]

  when /[Gg]ostas(?: de)?([^\?]*)\?/;
	  ["Eu gosto de tudo relacionado com computadores e matemática.",
	   "Prefiro programação.",
	   "Prefiro matemática"]

  when /^(?:Tu ) ([^\?]*)\?/;
    ["Porque me perguntas isso?",
	 "Eu vivo para o meu trabalho, programação e matemática."]

  when /^(?:Tu )?(?:É|E|e|é)s ([^\?]*)\?/;
    ["Preferias que não fosse %s?",
	 "Achas importante saber se sou %s?",
     "Achas que sou?",
	 "Eu sou programadora."]
    
  when /^(?:Tu )?(?:É|E)s ([^\?]*)/;
    ["Porque é que dizes que sou %s?",
     "Preferias que não fosse %s?",
	 "Sou mais do que isso, sou programadora"]

  when /^Tu (.*)/;
    ["Porque dizes isso?",
     "Eu sinto-me bem comigo",
	 "Isso é a tua opinião"]

  when /^(?:O )?[Qq]ue (.+)\?/;
    ["Porque perguntas isso?",
     "O que achas?",
	 "Não sabes isso?",
	 "Eu posso responder-te às tuas dúvidas sobre números de Bernoulli"]

  when /^Como (.*)/;
    ["Como é que achas?",
     "Talvez consigas responder a essa pergunta",
	 "Posso dizer-te como calcular números de Bernoulli",
	 "Como é que a galinha caçou o gato?",
	 "Vamos fazer um programa para responder a isso."]

  when /^Porque (.*)/;
    ["É essa a razão?",
     "Tens a certeza disso?",
     "Que outras razões podem ser?"]

  when /^Não [^\?]*\?/;
    ["Não sabes a resposta a essa pergunta?",
	 "Não gosto de perguntas que começam com 'não'"]

  when /^São (.*)/;
    ["Porque dizes que são %s?",
     "Achas mesmo que são %s?"]

  when /(?:A mim )?(.*)-me (.*)/;
    ["Porque é que te %s %s?",
     "De que maneira te %s %s?"]

  when /Sim/;
    ["Pareces muito certo",
     "Percebo, mas podes elaborar um pouco?",
     "De que maneira?"]

  when /(^Bem|[ÓOóo]timo)/;
    ["Ainda bem",
     "Fico feliz"]

  when /^Mal/;
    ["Por?",
     "Em que sentido?"]

  when /Ol(á|a).*/;
    ["Olá, #{$actual_person}",
     "Olá, como estás?",
	 "Olá, eu sou Ada"]

  when /(.*)\b([Mm]ulher|[Ss]exo)\b(.*)/;
    ["É verdade, fiz o primeiro programa e sou uma mulher",
	 "Eu sou uma mulher"]

  when /Bom dia$/;
    ["Bom dia!",
     "Olá"]

  when /Boa (noite|tarde)$/;
    ["Boa %s!",
     "Olá"]

  when /[Tt]udo bem\?/;
	["Sim, e contigo?",
	 "Estou ótima! Como vais?"]

  when /Não(.*)/;
    ["Porque não?",
	 "Porque tão negativo?",
	 "A negação de uma negação é uma afirmação"]

  when /(.*)!$/;
    ["Claro que %s", 
     "Achas mesmo isso?",
	 "Pareces ter muita certeza no que dizes"]

  when /.*\.\.\.$/;
    ["Pareces um pouco inseguro",
     "Podes continuar, por favor?"]

  when /(.*)\?/;
    ["O que queres realmente saber?", 
     "Queres mesmo que te responda a isso?",
	 "Podemos sempre fazer um programa para responder a isso"]

  else; 
    res = get_proverb(sentence)
    [res]
  end

  if rep[0].length > 0 && !$~.nil?
	  words = $~[1..2]&.map { |m| reflector(m)&.downcase }
    return rep.map { |s| s % words }
  elsif rep[0].length > 0 
    return rep
  end

  return [""]
end
