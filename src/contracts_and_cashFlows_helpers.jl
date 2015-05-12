
## create_contracts_example
## Create a vector of contracts. 
## WARNING :: This function is just for tests!
function create_contracts_example(N=40)
	contracts = financialContract[]
	for i=1:N
		push!(contracts, sac(1000.0, 60, 0.1, UTF8String("TJLP")))
	end
	return(contracts)
end


## update_cashFlows
## Update the cashFlows dataframe to include flows of new contracts
## In the simulation, the parameter cashFlows must receive something like "node.cashFlows"
## so the tree will be updated by reference! 
function update_cashFlows(cashFlows, contracts, account_id=ALM_DEFAULT_DEST_ACCOUNT_ID)

	for i=1:length(contracts)

		# generate the financial schedulle (general cashFlow information)
		tf = financialSchedulle(contracts[i])

		# contract index
		# tf[:index] = contracts[i].index

		# default acccount	
		tf[:account_id] = account_id

		# binding the new cashFlows dataframe to the current
		if(isempty(cashFlows))
			cashFlows = tf
		else
			append!(cashFlows,tf)
		end			
	
	end
	
	return cashFlows

end

## aggregate_cashFlows
##
function aggregate_cashFlows(cashFlows)
	original_names = names(cashFlows)
	a_cashFlows = aggregate(cashFlows,[:t,:index],sum)
	names!(a_cashFlows, original_names)
	cashFlows = a_cashFlows
end





