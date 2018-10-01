require 'Regexp'

# Vars
Knowledge = {}

# Regex for Word
L = /[êéãâóàáõ\w]+/
D = /[oOaA]s? |[Uue]ma? |[Dd][eao] /
W = /#{D}?#{L} ?/

# Regex for Triple
Verb = /é|sou|foi|fui|gosta|gosto|deriva|codifica|fica|fico|estou|está|vejo|vê|tem|tenho/
A = /criado |derivado /
Not = /não /
Conj = /#{Not}?#{Verb}/
Relation = /(#{W}) (#{Conj}) (#{A}?#{W}+)/

def verb3Person(verb)
  case verb
    when /gosto/;   'gosta'
    when /sou/;     'é'
    when /fui/;     'foi'
    when /fico/;    'fica'
    when /estou/;   'está'
    when /vejo/;    'vê'
    when /tenho/;   'tem'
    else;           verb
  end
end

def verifyKnowledge(fact)
  triple = case fact
           when Relation;
             [$1, $2, $3]
           else;
             nil
  end
  putTriple(triple, true)
end

def whoIs(pronoun)
  rep = case pronoun
        when /[Ee]l[ae]s?/;
          $person.downcase
        when /[Ee]u/;
          $actual_person.downcase
        else;
          $person = pronoun
          pronoun.downcase
  end

  names = Knowledge.keys
  names.each do |k|
    return k if k.match(/#{D}?#{rep}/)
  end
  rep
end

def putTriple(triple, isRegistrable)
  if triple.nil?
    return "Não sei o que dizes"
  end

  triple[0] = whoIs(triple[0])
  triple[1] = triple[1].split.map { |w| verb3Person(w) }.join(' ')

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
  registFact(triple, "learning/knowledge.info") if isRegistrable
  "Não sabia... obrigado por me informares"
end

def newTriple(t, isRegistrable)
  Knowledge[t[0]] = {}
  Knowledge[t[0]][t[1]] = []
  Knowledge[t[0]][t[1]].push(t[2])
  registFact(t, "learning/knowledge.info")  if isRegistrable
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
  person = whoIs(pronoun)
  verb   = verb.split.map { |w| verb3Person(w) }.join(' ')

  unless Knowledge[person].nil?
    unless Knowledge[person][verb].nil?
      pronoun2 = Knowledge[person][verb].sample
      "#{person} #{verb} #{pronoun2}"
    else
      "Não sei"
    end
  else
    "Não sei"
  end
end

def analyze(statement)
  puts get_response(statement)
  statement.length > 0
end

def loadFile(fileName)
  File.open(fileName, "r") do |f1|
    while line = f1.gets
      case line
      when /(#{W})\s+- (#{Conj})\s+- (#{A}?#{W}+)/;
        putTriple([$1, $2, $3], false)
      end
    end
  end
end

def registFact(fact, fileName)
  File.open(fileName, "a") do |f2|
    f2.puts "#{fact[0]}\t- #{verb3Person(fact[1])}\t- #{fact[2]}"
  end
end
