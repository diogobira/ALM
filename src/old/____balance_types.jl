###############################################
### Dependencies
###############################################


###############################################
### Basic Types
###############################################

type currency
	name::String
end

type cashFlow
	t0::Integer 
	t::Integer
	v::Number
	k::currency

	function cashFlow(t::Integer, v::Number, k::currency, t0=0)
		new(t0, t, v, k)
	end

end

type discountCurve 
	name::String
	v::Array{(Integer,Number),1}
end

type observable
	name::String
	value::Any
end

###############################################
### Elegant Accessors
###############################################
import Base.getindex
getindex(d::discountCurve,t) = d.v[t][2]

###############################################
### Basic Operations
###############################################

#Scale the cashFlows by a constant s
function scale(c::Array{cashFlow,1}, s::Number)
	map!(x -> cashFlow(x.t, x.v*s, x.k), c)
end

#Returns a new cashFlow array after currency conversion
function exchange(c::Array{cashFlow,1}, k::currency)
	cf = cashFlow[]
	for i=1:length(c)
		v = exchange_(c[i].k, k, c[i].t)
		push!(cf, cashFlow(c[i].t, v, k))
	end
	return cf
end

#Returns a discounted cashFlow array given a discountCurve
function discount(c::Array{cashFlow,1}, d::discountCurve)
	map(x -> cashFlow(x.t, x.v * d[x.t], x.k), cf)
end	

#Returns a discounted cashFlow array given a discountCurve and a destination currency
function discount(c::Array{cashFlow,1}, d::discountCurve, k::currency)
	map(x -> cashFlow(x.t, x.v * d[x.t], k), cf)
end	

#Return the time where the last cashFlow occurs
function horizon(c::Array{cashFlow,1})
	maximum([x.t for x=c])
end

#Truncate all the cashFlows that occurs after time T
function truncate(c::Array{cashFlow,1}, T::Number)
	for i=1:length(c)
		c[i].t > T ? deleteat!(c,i) : Nothing()
	end
end

#Delay cash flows by d units of time
function delay(c::Array{cashFlow,1}, d::Number)
	map!(x -> cashFlow(x.t+d, x.v, x.k), c)
end

#Shift all cashFlow dates by -1
function shiftleft(c::Array{cashFlow,1})
	map!(x -> cashFlow(x.t-1, x.v, x.k), c)
end

