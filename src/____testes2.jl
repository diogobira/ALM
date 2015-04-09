
require("Basic.Types.And.Functions/basic_types.jl")
require("Amortization.Systems/sac.jl")
require("Amortization.Systems/price.jl")
require("Fixed.Income/zcb.jl")
require("Fixed.Income/coupomBond.jl")



#Algumas moedas
BRL = currency("BRL")
USD = currency("USD")
TJLP = currency("TJLP")
SELIC = currency("SELIC")

#Uma curva de desconto
d = discountCurve("PRE", [(i,0.95) for i=1:10000])

#Funções que teriam que ser implementadas pelos usuários do pacote, fazendo acesso as bases de dados disponíveis.
exchange_(k1::currency, k2::currency, t::Integer)=1

#Criando uma operação SAC
s = sac(1000, 10, 0.01, BRL)
cf = projectCashFlow(s)
discount(cf, d)


#Exemplo de criação de funções usando macros
#currencies = {"BRL", "USD", "TJLP", "SELIC"}
#for k1 in currencies
#	for k2 in currencies
#			@eval function $(symbol(string("exchange_",k1,"_",k2)))(t::Number)
#					return(1)
#				  end	
#			@eval function $(symbol(string("discount_",k1,"_",k2)))(t::Number)
#					return(1)
#				  end	
#	end
#end

