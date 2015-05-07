
#######################################################################
### Dependencies
#######################################################################
using DataFrames

#######################################################################
### Abstracts
#######################################################################
abstract financialContract

#######################################################################
### SAC
#######################################################################

type sac <: financialContract

	## Attributes
	t0::Integer
	notional::Number
	n::Integer
	rate::Number
	index::UTF8String

	## Constructor
	function sac(notional::Number, n::Integer, rate::Number, index::UTF8String, t0=0)
		new(t0, notional, n, rate, index)
	end
end

function financialSchedulle(c::sac)

	### Schedulle
	amortization = [c.notional / c.n for i=1:c.n]
	interest = (c.n - [1:c.n] + 1) .* amortization * c.rate
	amortization = [[0], amortization]
	interest = [[0], interest]
	cf = amortization + interest
	balance =  [c.notional - i*(c.notional/c.n) for i=0:c.n]

	### DataFrame
	tabFin = DataFrame()
	tabFin[:t] = [t for t=0:c.n]
	tabFin[:balance] = balance
	tabFin[:amortization] = amortization
	tabFin[:interest] = interest
	tabFin[:cf] =  cf 

	return tabFin 

end

