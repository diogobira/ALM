
## create_values_and_params_example
## Create a hash with the initial value in R^2 and process parameters for risk factors.
## WARNING :: This function is just for tests!
function create_values_and_params_example()
	### Load the start values of risk factors in a appropriate order (Exemplo: [TJLP, SELIC])
	#index_order = ["TJLP" "SELIC"]
	value = [1.015 1.030]
	s11,s22 = 0.1^2, 0.1^2; s12 = 0.1*0.1*-0.5; s21 = s12;
	r11,r22 = 1,1; r12 = 0.5; r21 = s12;
	params = {:drift=>[0.0 0.0], :sigma=>[[s11 s12],[s21 s22]], :rho=>[[r11 r12],[r21 r22]], :dt=>3*21/252};
	return {:value=>value, :params=>params}
end


