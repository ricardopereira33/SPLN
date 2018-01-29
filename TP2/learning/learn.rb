#require 'Regexp'

# Hash with all knowledge
Knowledge = {}

# Regex for Triple
Verb = /é|gosta|criado|derivado|codifica/
Not = /não/
Conj = /#{Not}?#{Verb}/
Relation = /(.*) (#{Conj}) (.*)/

# Regex for Word
L = /[éãâóàáõ\w]+/
D = /[oOaA]s? |[Uu]ma? |[Dd][eao] /
W = /#{D}?#{L}/

def verifyKnowledge(fact)
  triple = case fact
           when Relation;
             [$1, $2, $3]
           else;
             nil
  end
  putTriple(triple, true)
end

def putTriple(triple, isRegistrable)
  if triple.nil?
    return "Não sei o que dizes"
  end

  unless Knowledge[triple[0]].nil?
    elem = Knowledge[triple[0]]
    if elem[triple[1]].nil?
      elem[triple[1]] = []
      unknown(triple, elem, isRegistrable)
    else
      if elem[triple[1]].include?(triple[2])
        "Já sabia"
      else
        unknown(triple, elem, isRegistrable)
      end
    end
  else
    newTriple(triple, isRegistrable)
    "Não sabia... obrigado por me informares"
  end
end

def unknown(triple, elem, isRegistrable)
  elem[triple[1]].push(triple[2])
  registFact(triple, "knowledge.info") if isRegistrable
  "Não sabia... obrigado por me informares"
end

def newTriple(t, isRegistrable)
  Knowledge[t[0]] = {}
  Knowledge[t[0]][t[1]] = []
  Knowledge[t[0]][t[1]].push(t[2])
  registFact(t, "knowledge.info")  if isRegistrable
end

def getFactRandom()
  fstPronouns = Knowledge.keys
  fstPronoun = fstPronouns.sample
  relations = Knowledge[fstPronoun].keys
  relation = relations.sample
  sndPronoun = Knowledge[fstPronoun][relation].sample
  responses = ["Sabias que #{fstPronoun} #{relation} #{sndPronoun}?",
               "Um facto: #{fstPronoun} #{relation} #{sndPronoun}!"]
  responses.sample
end

def getFact(verb, pronoun)
  unless Knowledge[pronoun].nil?
    unless Knowledge[pronoun][verb].nil?
    pronoun2 = Knowledge[pronoun][verb].sample
    "#{pronoun} #{verb} #{pronoun2}"
    else
      "Não sei"
    end
  else
    "Não sei"
  end
end

def get_response(sentence)
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
          return "Desconheço"
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
      case line
      when /(#{W})\s+- (#{W})\s+- (#{W})/;
        putTriple([$1, $2, $3], false)
      end
    end
  end
end

def registFact(fact, fileName)
  File.open(fileName, "a") do |f2|
    f2.puts "#{fact[0]}\t- #{fact[1]}\t- #{fact[2]}"
  end
end

if __FILE__ == $0
  loadFile("knowledge.info")
  puts Knowledge
  loop do
    print "> "
    line = gets.chomp

    print "< "
    unless analyze(line.capitalize)
      break
    end
  end
end
