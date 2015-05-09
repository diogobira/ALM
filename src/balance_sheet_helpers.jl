
## create_and_load_balance_sheet
## 
function create_and_load_balance_sheet(filename = "../dados/plano_contas.csv")

	## this will create a dataframe with the basic fields :id and :name	
	balanceSheet = readtable(filename, separator=';', header=true)

	## this will add some additional fields
	balanceSheet[:short_name] = balanceSheet[:name]

	## this will add some fields for values
	## that will be updated during the simulation
	balanceSheet[:curve_value] = 0
	balanceSheet[:mtm_value] = 0
	balanceSheet[:risk_free_mtm_value] = 0

	## and then, return this awesome balanceSheet!
	## the auditors would be proud of us!
	return(balanceSheet)

end

##
##
function get_account_values_by_id(balanceSheet, id)
end

##
##
function get_account_values_by_name(balanceSheet, name)
end




