#require 'Regexp'

Knowledge = {}
Verb = /é|gosta|criado|derivado|codifica/
Not = /não/
Relation = /#{Not}?#{Verb}/
L = /[éãâóàáõ\w]+/
D = /[oa]s? /
W = /#{D}?#{L}/

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
      unknown(triple, elem)
    else
      if elem[triple[1]].include?(triple[2])
        "Já sabia"
      else
        unknown(triple, elem)
      end
    end
  else
    newTripleRegistrable(triple)
    "Não sabia... obrigado por me informares"
  end
end

def unknown(triple, elem)
  elem[triple[1]].push(triple[2])
  registFact(triple, "knowledge.info")
  "Não sabia... obrigado por me informares"
end

def newTripleRegistrable(t)
  newTriple(t)
  registFact(t, "knowledge.info")
end

def newTriple(t)
  Knowledge[t[0]] = {}
  Knowledge[t[0]][t[1]] = []
  Knowledge[t[0]][t[1]].push(t[2])
end

def getFact()
  fstPronouns = Knowledge.keys
  fstPronoun = fstPronouns.sample
  relations = Knowledge[fstPronoun].keys
  relation = relations.sample
  sndPronoun = Knowledge[fstPronoun][relation].sample
  responses = ["Sabias que #{fstPronoun} #{relation} #{sndPronoun}?",
               "Um facto: #{fstPronoun} #{relation} #{sndPronoun}!"]
  responses.sample
end

def get_response(sentence)
  rep = case sentence
        when /[Ss]abias que (.*)\?|Aprende que (.*)/;
          verifyKnowledge($1)
        when /O que sabes\?|Conta-me algo/;
          getFact()
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
        putTriple([$1, $2, $3])
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
