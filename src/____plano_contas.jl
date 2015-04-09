using DataStructures
using DataFrames

#Definição do tipo Conta Contábil
type ContaContabil
	saldo::Float64
	nome::UTF8String
end

function get_ids_contas_irmas(c::ContaContabil)
end

function get_ids_conta_pai(c::ContaContabil)
	
end


#Lê as contas de um arquivo CSV
contas = readtable("plano_contas.csv", separator=';', header=false)
qtd_contas = size(contas)[1]

#Cria um plano de contas vazio usando uma Trie
planoDeContas = Trie{ContaContabil}()

#Carrega a Trie planoDeContas com cada uma das contas
for i=1:qtd_contas
	id = contas[i,1]
	nome = contas[i,2]
	typeof(nome)==NAtype ? nome="" : nome=nome
	println(nome)
	planoDeContas[id]=ContaContabil(1000,nome)
end

#Teste de carga na busca de contas
@time for j=1:100000
	for i=1:qtd_contas
		id = contas[i,1];
		haskey(planoDeContas,id);
	end
end
