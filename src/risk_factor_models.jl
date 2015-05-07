
## multivariate_gbm
## Function to build a multivariate GBM path starting from a node (that contains the current value),
## given a multivariate drift, a covariance matrix, and a step size.
function multivariate_gbm(node, N, params)

	#Separate the params
	drift = params[:drift] #drift
	rho = params[:rho]
	sigma = params[:sigma] #covariance matrix
	dt = params[:dt] #step size

	#Get the dimension off the process
	d = size(node.value)[2]

	#Create the correlated "shocks"
	A = chol(rho)
	shocks = (A' * randn(d,N))'

	#Volatilities
	vol = sqrt(diag(sigma))'

	#Array for the paths (different dimensions by column)
	path = zeros(N+1,d)
	path[1,:] = node.value
	for i=2:N+1
		path[i,:] = path[i-1,:] .* exp((drift .- 0.5*vol.^2) * dt +  sqrt(dt) * vol .*  shocks[i-1,:])
	end
	
	#If N==1, return only the next step values. Otherwise, returns the complete 
	#path including the initial values
	N==1 ? path[2,:] : path

end

