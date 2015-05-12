
#####################################################
####
#### SAC Credit Operation Types and Methods
####
#####################################################

### Dependencies
require("Basic.Types.And.Functions/basic_types.jl")

type sac

	t0::Integer
	notional::Number
	n::Integer
	rate::Number
	k::currency
	
	#Constructor
	function sac(notional::Number, n::Integer, rate::Number, k::currency, t0=0)
		new(t0, notional, n, rate, k)
	end

end

#Financial Schedulle
function financialSchedulle(c::sac)
	amortization = [c.notional / c.n for i=1:c.n]
	interest = (c.n - [1:c.n] + 1) .* amortization * c.rate
	amortization = [[0], amortization]
	interest = [[0], interest]
	cf = amortization + interest
	balance =  [c.notional - i*(c.notional/c.n) for i=0:c.n]
	return {:balance=>balance, :amortization=>amortization, :interest=>interest, :cf=>cf}
end

function projectCashFlow(c::sac)
	amortization = [c.notional / c.n for i=1:c.n]
	interest = (c.n - [1:c.n] + 1) .* amortization * c.rate
	p = amortization + interest
	[cashFlow(t, p[t], c.k, c.t0) for t=1:c.n]
end

function projectCashFlow(c::sac, k::currency)
	exchange_(projectCashFlow(c))
end

function mtm(c::sac, d::discountCurve)
	sum([x.v for x = discount(projectCashFlow(c),d)])	
end

