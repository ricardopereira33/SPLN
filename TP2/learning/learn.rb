#require 'Regexp'

Knowledge = {}
Relation = /é|gosta|criado|derivado|codifica/
W = /[éãâóàáõ\w]/

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

def verifyKnowledge(fact)
  triple = case fact
           when /(.*) (#{Relation}) (.*)/;
             [$1, $2, $3]
           else;
             nil
  end
  putTriple(triple)
end

def putTriple(triple)
  if triple.nil?
    return "Não sei o que dizes"
  end

  unless Knowledge[triple[0]].nil?
    elem = Knowledge[triple[0]]
    if elem[triple[1]].nil?
      elem[triple[1]] = []
      elem[triple[1]].push(triple[2])
      "Não sabia... obrigado por me informares"
    else
      if elem[triple[1]].include?(triple[2])
        "Já sabia"
      else
        elem[triple[1]].push(triple[2])
        "Não sabia... obrigado por me informares"
      end
    end
  else
    newTriple(triple)
    "Não sabia... obrigado por me informares"
  end
end

def newTriple(t)
  Knowledge[t[0]] = {}
  Knowledge[t[0]][t[1]] = []
  Knowledge[t[0]][t[1]].push(t[2])
end

def get_response(sentence)
  rep = case sentence
        when /[Ss]abias que (.*)\?/;  verifyKnowledge($1)
        when /Aprende que (.*)/;      verifyKnowledge($1)
        else;                         return "Desconheço"
  end

  rep
end


def analyze(statement)
  puts get_response(statement)
  statement.length > 0
end

def loadFile(fileName)
  File.open(fileName, "r") do |f1|
    while line = f1.gets
      if match = line.match(/(#{W}+)\s+- (#{W}+)\s+- (#{W}+)/)
        g1, g2, g3 = match.captures
        newTriple([g1, g2, g3])
      end
    end
  end
end

if __FILE__ == $0
  loadFile("knowledge.info")
  loop do
    print "> "
    line = gets.chomp

    print "< "
    unless analyze(line.capitalize)
      break
    end
  end
end
