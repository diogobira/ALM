
# Dependencias
require("balance_sheet_types.jl")
require("balance_sheet_methods.jl")

# Teste 1: Cria um plano de contas vazio
balanceSheet = Trie{Account}()

# Teste 2: Carga do plano de contas a partir do CSV
filename = "../dados/plano_contas.csv"
carrega_plano_de_contas_csv(balanceSheet, filename)

#Teste 3: Teste de carga na busca de contas
contas = readtable(filename, separator=';', header=true)
qtd_contas = size(contas)[1]
@time for j=1:100000
	for i=1:qtd_contas
		id = contas[i,:id];
		haskey(pc,id);
	end
end
