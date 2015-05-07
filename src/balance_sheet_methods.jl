############################################################################
# Operações Básicas relacionados ao Plano de Contas
#
############################################################################

# carrega_plano_de_contas_csv
# Carrega o plano de contas "planoDeContas" a partir de um arquivo de dados CSV.
function carrega_plano_de_contas_csv(balanceSheet, filename)

	#Lê o arquivo de dados
	contas = readtable(filename, separator=';', header=true)
	qtd_contas = size(contas)[1]

	# Loop de construção do plano de contas
	for i=1:qtd_contas
		id = contas[i,1]
		nome = contas[i,2]
		typeof(nome)==NAtype ? nome="" : nome=nome
		balanceSheet[id]=Account(id,nome)
	end

end

