###############################################################
### 
###
###
###############################################################

## create_new_contracts
##
##
#function create_new_contracts(node::PathsTree, strategy)
#end

## create_new_cashFlows
##
##
#function create_new_cashFlows(node::PathsTree, strategy)
#end

## run_alm_simulation
## Main method for simulation
## 
function run_alm_simulation(node::PathsTree, strategy)
	
	### Do something with the root
	### 

	### When the node is not the root
	if(root.level!=1)

		### Copy main data structures		
		node.balanceSheet = deepcopy(node.father.balanceSheet)
		node.contracts = deepcopy(node.father.contracts)
		node.cashFlows = deepcopy(node.father.cashFlows)		

		### Create new contracts and cashFlows
		new_contracts = create_contracts_example()
		update_cashFlows(node.cashFlows, new_contracts)
		
		### Other Actions

	end
	
	### Do something with the childs nodes recursively
	for i=1:length(node.childs)
		run_alm_simulation(node.childs[i], strategy)
	end
	
end

