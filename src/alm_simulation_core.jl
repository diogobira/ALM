###############################################################
### 
###
###
###############################################################

## run_alm_simulation
## Main method for simulation
## 
function run_alm_simulation(node::PathsTree, strategy)
	
	### Do something with the root
	print(string(node.level,"/",node.state,"\n"))

	### When the node is not the root
	if(node.level!=1)

		### Copy main data structures		
		#node.balanceSheet = copy(node.father.balanceSheet)
		#node.contracts = copy(node.father.contracts)
		#node.cashFlows = copy(node.father.cashFlows)		

		### Create new contracts and cashFlows
		new_contracts = create_contracts_example()
		node.cashFlows = update_cashFlows(node.cashFlows, new_contracts)
		
		### Other Actions

	end
	
	### Do something with the childs nodes recursively
	#@parallel for i=1:length(node.childs)
	#for i=1:length(node.childs)		
	@parallel for i=1:length(node.childs)
		run_alm_simulation(node.childs[i], strategy)
	end
	
end


## run_alm_simulation
## Main method for simulation
	## 
function run_alm_simulation(root, strategy, stages, states)
	
	#M = Array(PathsTree,(stages,states))
	#M = DArray(PathsTree,(stages,states))
	M = @DArray[PathsTree for i=1:stages, j=1:states]
	#M = SharedArray(PathsTree,(stages,states))

	@parallel for i=1:states

		M[1,i] = root

		for j=2:stages

			### Do something with the root
			print(string(j,"/",i,"\n"))

			### Copy early stage data
			M[j,i] = deepcopy(M[j-1,i])

			### Create new contracts and cashFlows
			new_contracts = create_contracts_example()
			M[j,i].cashFlows = update_cashFlows(M[j,i].cashFlows, new_contracts)

		end
	end

	return M
	
end



