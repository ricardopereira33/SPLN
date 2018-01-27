require 'open-uri'
require 'nokogiri'

Irrelevant = /\b(d[aeo]|[aeo]|com|[àao]+s|para|em|és?|uma?|[et]u|que)\b/

def get_proverbs 
  html = open('http://natura.di.uminho.pt/~jj/pln/proverbio.dic')
  doc = Nokogiri::HTML( html.read )
  doc.encoding = 'utf-8'

  list = doc.search("h1")[4].next_sibling.text.to_s.split(/\n/)
  list.concat(doc.search("h1")[6].next_sibling.text.to_s.split(/\n/))
  list.map { |line| line.gsub(/^([^:]*):(.*)$/, '\1') }
end

def get_keywords(phrase)
  tokens = phrase.split
  tokens.delete_if { |tkn| tkn.match(Irrelevant)}
end

def relevant_proverb(phrase, proverbs)
  keywords = get_keywords(phrase)
  relevant = []

  keywords.each do |word|
    relevant.concat(proverbs.select { |p| p.match(/\b#{word}\b/) })
  end

  return relevant
end

def prepare_statement(statement)
  unless statement.nil?
    statement.gsub(/\(([^\)\|]*)\|([^\)\|]*)(\|.*)?\)/, "\\#{rand(1..2)}")
  end
end

if __FILE__ == $0
  proverbs = get_proverbs

  loop do
    phrase = gets.chomp
    ps = relevant_proverb(phrase, proverbs)
    puts prepare_statement(ps.sample)
  end
end
