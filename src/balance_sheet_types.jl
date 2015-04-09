############################################################################
# Tipos Básicos relacionados ao Plano de Contas
#
# Autores:
#	Diogo Gobira
#	Felipe Vilhena
############################################################################

#Dependencias
using DataStructures
using DataFrames

# Tipo ContaContabil
type ContaContabil
	saldo::Float64
	nome::UTF8String
end

