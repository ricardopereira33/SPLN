def get_nomes
  name = IO.readlines('nomes.txt').sample.chomp
  apel = IO.readlines('apelidos.txt').sample.chomp
  "#{name} #{apel} "
end

Grammar = {
  S: [[ :NP, :VP ]],
  NP: [[ :D, :N ]],
  VP: [[ :V ]],
  N: [[ method(:get_nomes) ]],
  V: [[ :V1, :Obj ], [ :V2 ]],
  D: [['o'], ['a']],
  V1: [['vende'], ['compra'], ['destroi']],
  V2: [['casou'], ['morreu'], ['caiu']],
  Obj: [['limões'], ['casa'], [:D, :N]]
}

def gera(node)

  if Grammar.has_key?(node)
    Grammar[node].sample.each { |n| gera(n) }
  elsif node.is_a? Method
    print node.call
  elsif node.is_a? String
    print "#{node} "
  end
end

if __FILE__ == $0
  gera(:S)
  puts ''
end
