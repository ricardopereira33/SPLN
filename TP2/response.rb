#require 'Regexp'

Despedida = /(.*)([Aa]deus|([Xx]au)|[Aa]té à proxima)(.*)/
Profano = /(.*)([Mm]erda|[Ff]od[ae]|[Pp]uta|[Cc]aralho|[Cc]abrão)(.*)/
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
    num = rand(1..5)
    res = case num 
      when 3;   get_proverb(sentence) 
      else;     get_normalResponse(sentence).sample  
    end
    $interation = 0
    return res if res.length > 0
    return ["Fala-me mais sobre isso", 
            "Como é que isso te faz sentir?", 
            "Não entendi o que disseste"].sample
  else
    learned
  end
end

def isLearning(sentence)
  rep = case sentence

  when /[Ss]abias que (.*)\?|Aprende que (.*)/;
    verifyKnowledge($1)
  
  when /O que sabes\?|Conta-me algo/;
    getFactRandom()
  
  when /O que (#{Conj}) (#{W})\?/;
    getFact($1, $2)
  
  when /O que é que (#{W}) (#{Conj})\?/;
    getFact($2, $1)

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

  when /Quanto é (.*)\?/
    elem = $1.gsub(/[^0-9+-\/*()]/, "")
    value = eval(elem)
    ["#{value}"]

  when /Que horas são\?|Diz-me as horas|[Hh]oras/
    hour = `date +%T`
    ["#{hour}"]

  when /Que dia é hoje?|Qual a data( de hoje)\?|[Dd]ata/
    date = `date +%D`
    ["#{date}"]

  when Despedida;
    ["Adeus, gostei de falar contigo",
     "Até à proxima",
     "Até já! Sabes sempre que podes contar comigo"]

  when Profano;
    ["Peço que te acalmas",
     "Tento na língua",
     "Por favor, não vamos deixar sentimentos afetar a nossa linguagem"]

  when /(.*) desculpa (.*)/;
    ["Há alturas em que não é necessário pedir desculpa",
     "Porque me pedes descula?"]

  when /(.*) amig[oa]s? (.*)/;
    ["Fala-me mais sobre os teus amigos",
     "Que bons momentos tiveste com o teu amigo?"]

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

  when /(.*)ofelia(.*) |Quem és( tu)?\?/;
    ["O meu nome é Ofelia, e sou uma jovem da alta nobreza da Dinamarca. Recentemente virei um bot."]

  # Eu
    
  when /^Porque(?: é que)?(?: eu)? não consigo ([^\?])?/
    ["Porque dizes que não consegues %s?",
     "Achas que devias conseguir %s?",
     "Tentaste realmente %s?"]
    
  when /^(?:Eu )?[Qq]uer(o|ia)(.+)?/;
    ["Em que sentido %s te ajudava?",
     "Porque é que queres isso?",
     "Precisas mesmo de %s?",
     "Achas que %s é necessário?"]

  when /^(?:Eu )?[Pp]reciso de (.+)$/;
    ["Porque precisas de %s?",
    "De que forma %s te ajudava?",
    "Precisas mesmo de %s?"]

  when /^(?:Eu )?[Nn]ão consigo (.+)/;
    ["Talvez se tentasses %s, conseguias.",
     "Como achas que poderias %s?"]

  when /^(?:Eu )?[Ss]ou (.+)$/;
    ["Porque dizes que és %s?",
    "Como te sentes em ser %s?",
    "Há quanto tempo és %s?"]

  when /^(?:Eu )?[Ee]stou (.+)$/;
    ["Porque dizes que estás %s?",
    "Como te sentes em ser %s?",
    "Há quanto tempo és %s?"]

  when /(?:Eu )?[Ss]into(?:-me)? (.*)/;
    ["Fala-me mais sobre esses sentimentos",
     "Quantas vezes te sentes %s?",
     "Gostas de te sentir %s?"]

  when /(?:Eu )?[Gg]ostava (.*)/;
    ["Porque é que gostavas %s?"]

  when /(?:Eu )?([Nn]ão )?[Gg]osto de (.*)/;
    ["Eu também %sgosto de #{$2}",
     "Porque é que %sgostas de #{$2}?"]

  when /(?:Eu )?(?:[Aa]cho|[Pp]enso) (.+)/;
    ["Duvidas %s?",
    "Tens a certeza?"]

  when /Eu ?(.*)/;
    ["Porquê?", 
     "Porque é que %s?",
     "Achas que isso te define?"]

  # Tu ...

  when /^Porque não te ([^\?]*)\?/;
    ["Talvez o faça",
     "Achas mesmo que eu devia %s"]

  when /^(?:Tu ) ([^\?]*)\?/;
    ["Precisamos de falar sobre mim?",
     "Preferia falar sobre ti",
     "Achas mesmo que %s?"]

  when /^(?:Tu ) (.*)/;
    ["Porque é que dizes que %s?",
     "Porque dizes isso?",
     "Eu sinto-me bem comigo."]

  # Nós
  when /Nós (.*)/;
    ["Estás a contar comigo?"]

  when /^(?:O )?[Qq]ue (.+)\?/;
    ["Porque perguntas isso?",
    "O que achas?"]

  when /^Como (.*)/;
    ["Como é que achas?",
     "O que é que realmente estás a tentar perguntar?",
     "Talvez consigas responder a essa pergunta"]

  when /^Porque (.*)/;
    ["Essa é a verdadeira resposta?",
     "Tens a certeza disso?",
     "Que outras razões podem ser?",
     "Essa razão aplica-se a mais alguma coisa?",
     "Se %s, que mais podia ser verdade?"]

  when /^Não [^\?]*\?/;
    ["Porque dizes que não %s?",
     "Não sabes a resposta a essa pergunta?"]

  when /^São (.*)/;
    ["Porque dizes que são %s?",
     "Achas mesmo que são %s?"]

  when /(?:A mim )?(.*)-me (.*)/;
    ["Porque é que te %s #{$2}?",
     "De que maneira te %s #{$2}?"]

  when /Sim/;
    ["Pareces muito certo",
     "Percebo, mas podes elaborar um pouco?",
     "De que maneira?"]

  when / (.*) computador (.*)/;
    ["Como é que computadores te fazem sentir?",
     "Sentes-te ameaçado por coputadores?",
     "Os computadores são teus amigos, não querem dominar o mundo :)"]

  when /^Bem/;
    ["Ainda bem",
     "Fico feliz"]

  when /^Mal/;
    ["Porquê?",
     "Em que sentido?"]

  when /^Eu (.*)/; 
    [ "Como é que %s?", 
      "Porquê?" ]

  when /^(?:É|E)s ([^\?])*\?/;
    ["Porque é que é importante se seja %s?",
     "Preferias que não fosse %s?",
     "Achas que sou?"]
    
  when /^(?:É|E)s ([^\?])*/;
    ["Porque é que é dizes que sou %s?",
     "Preferias que não fosse %s?",
     "Podemos falar sobre ti?"]

  when /Ol(á|a).*/;
    ["Olá",
     "Olá, como estás?"]

  when /Bom dia$/;
    ["Bom dia!",
     "Olá"]

  when /Boa (noite|tarde)$/;
    ["Boa %s!",
     "Olá"]

  when /Não(.*)/;
    ["Porque não?"]

  when /(.*)!/;
    ["Claro que %s", 
     "Achas mesmo isso?"]

  when /.*\.\.\.$/;
    ["Pareces um pouco inseguro",
     "Podes continuar, por favor?",
     "Está tudo bem, podes elaborar mais?"]

  when /(.*)\?/;
    ["O que queres realmente saber?", 
     "Não pareces muito seguro...",
     "Queres mesmo que te responda a isso?"]
  else; 
    res = get_proverb(sentence)
    [res]
  end

  if rep[0].length > 0
    rep.map do |s|
      s % $~[1..2]&.map { |m| reflector(m)&.downcase } unless $~.nil?
    end
    return rep
  end

  return [""]
end