
### Dependencies
using DataFrames

### Basic Types
require("basic_types.jl")
require("basic_operations.jl")

### Products
require("bullet.jl")
require("sac.jl")
require("stock.jl")

###
#o = stock(1000.0, 0.05, 3, "PETR4")
#b = bullet(1000.0, 60, "SELIC")
#w = sac(1000.0, 60, 0.1, "TJLP")


### Tests ###

#Create an array of 1000 financial contracts
contracts = Any[]
for i=1:50
	push!(contracts, bullet(1000.0, 60, "SELIC"))
	push!(contracts, sac(1000.0, 60, 0.1, "TJLP"))
end

#Initialize the an array with cashFlows of pre-existent contracts
cashFlows = Any[]
mtms = Float64[]
@time for i=1:length(contracts)
	push!(cashFlows, projectCashFlow(contracts[i]))	 
end

#Loop on simulation horizon, creating new contracts and computing the mtm
d = getProcessFromIndexName("TJLP", discountProcess)
@time for j=1:60

	#create new 20 contracts
	newcontracts = Any[]
	for j=1:50
		push!(newcontracts, bullet(1000.0, rand(30:60,1)[1], "SELIC"))
		push!(newcontracts, sac(1000.0, rand(36:60,1)[1], 0.1, "TJLP"))
	end
	
	#Update the cashFlows array with the new contracts
	for i=1:length(newcontracts)
		push!(cashFlows, projectCashFlow(newcontracts[i]))	 
	end

	#MTM computations
	for i=1:length(cashFlows)
		push!(mtms, mtm(cashFlows[i][:onDomestic], d))
	end

	#Shifting dates and deleting past cashFlows
	for i=1:length(cashFlows)
		shiftCashFlowDates!(cashFlows[i][:onDomestic])
		deletePastCashFlows!(cashFlows[i][:onDomestic])
		shiftCashFlowDates!(cashFlows[i][:onIndex])
		deletePastCashFlows!(cashFlows[i][:onIndex])
	end

end


