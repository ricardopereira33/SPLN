#require 'Regexp'
require_relative 'response'
require_relative 'learning/learn'
require_relative 'theLab/proverbial'

def analyze(statement)
  puts get_response(statement)
  !(Despedida.match(statement))
end

def unthankful(line)
  line.gsub(/(,)?( )*obrigad[oa]/, "")
  line.gsub(/(,)?( )*[Pp]or [Ff]avor(, )?/, "")
end

if __FILE__ == $0
  loadFile("learning/knowledge.info")
  $proverbs = get_proverbs

  puts "Ada\t> Olá, como te chamas?"
  print "#{$actual_person}\t> "
  line = gets.chomp 
  $person = line
  $actual_person = $person
  
  loop do
    print "#{$actual_person}\t> "
    line = gets.chomp
    
    line = unthankful(line)
    print "Ada\t> "

    unless analyze(line.capitalize)
      break
    end
  end
end
