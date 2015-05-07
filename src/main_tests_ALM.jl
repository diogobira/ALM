######################################################################
### Dependencies
######################################################################

workspace()

### Julia Packages
using DataStructures
using DataStructures
using DataFrames
using DataFrames

### BalanceSheet Types and Methods
require("balance_sheet_types.jl")
require("balance_sheet_methods.jl")

### Financial Contracts Types and Methods
require("tabfin.jl")

### Stoch Approx Types and Methods
require("stoch_approx_multivariate.jl")

### Risk Factor Models
require("risk_factor_models.jl")

######################################################################
### Initialization of main data structures
######################################################################

### Load initial financial contracts list
contracts = financialContract[]
for i=1:50
	push!(contracts, sac(1000.0, 60, 0.1, UTF8String("TJLP")))
end

### Load initial financial cashFlows list
cashFlows = DataFrame()
for i=1:length(contracts)
	c = contracts[i]
	tf = financialSchedulle(contracts[i])
	tf[:index] = c.index
	cashFlows = [cashFlows,tf]
end

### Load initial balanceSheet
balanceSheet = readtable("../dados/plano_contas.csv", separator=';', header=true)

### Load the start values of risk factors in a appropriate order (Exemplo: [TJLP, SELIC])
index_order = ["TJLP" "SELIC"]
value = [1.015 1.030]
s11,s22 = 0.1^2, 0.1^2; s12 = 0.1*0.1*-0.5; s21 = s12;
r11,r22 = 1,1; r12 = 0.5; r21 = s12;
params = {:drift=>[0.0 0.0], :sigma=>[[s11 s12],[s21 s22]], :rho=>[[r11 r12],[r21 r22]], :dt=>3*21/252};

### Build the tree and apply the "petelecos"
number_of_childs = [128,32,8,2,2,0]
root = PathsTree(value, 1, contracts, cashFlows, balanceSheet) 
add_childs(root, number_of_childs, multivariate_gbm, params)
lots_of_petelecos(root, 1000000, number_of_childs, multivariate_gbm, params, normalized_euclidean_distance);

