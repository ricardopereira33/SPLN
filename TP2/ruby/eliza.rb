Reflections = {
  "eu" => "tu",
  "estou" => "estás",
  "sou" => "és",
  "estive" => "estiveste",
  "meu" => "teu",
  "és" => "sou",
  "estiveste" => "estive",
  "estás" => "estou",
  "teu" => "meu"
}

Response = [
  [/Eu preciso de (.+)$/, [
    "Porque precisas de %s?",
    "De que forma %s te ajudava?",
    "Precisas mesmo de %s?"]],
  [/Eu sou (.+)$/, [
    "Porque dizes que és %s?",
    "Como te sentes em ser %s?",
    "Há quanto tempo és %s?"]],
  [/(?:O )?[Qq]ue (.+)\?/, [
    "Porque perguntas isso?",
    "O que achas?"]],
  [/(?:Eu )?[Aa]cho (.+)/, [
    "Duvidas %s?",
    "Tens a certeza?"]]
]

def reflect(fragment)
  fragment.downcase.split.map do |token|
    if Reflections.has_key? token
      Reflections[token]
    else
      token
    end
  end.join(" ")
end

def analyze(statement)
  Response.each do |(pattern, replies)|
    match = pattern.match(statement)
    unless match.nil?
      puts replies.sample % match[1..10]
    end
  end
end

if __FILE__ == $0
  loop do
    line = gets.chomp
    analyze(line)

    if line == "sair"
      break
    end
  end
end
