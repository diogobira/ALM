############################################################################
# Tipos Básicos relacionados ao Plano de Contas, Contratos, CashFlows etc.
#
############################################################################

### Dependencias
using DataStructures
using DataFrames

### Tipo ContaContabil
type Account

	id::UTF8String
	name::UTF8String
	short_name::UTF8String
	curve_value::Float64
	mtm_value::Float64
	risk_free_mtm_value::Float64
	
	function Account(id,name)
		x = new()
		x.id = id
		x.name = name
		x.short_name = short_name
		x.curve_value = 0
		x.mtm_value = 0
		x.risk_free_mtm_value = 0
		x
	end
	
end

### Tipo Rating
type CreditRating
	name::UTF8String
	spread_curve::Vector{Float64}
	default_probability::Vector{Float64}
	recovery_ratio::Vector{Float64}
end

### Tipo Counterparty
type Counterparty
	id::UTF8String
	name::UTF8String
	short_name::UTF8String  
	rating::CreditRating 
end

### Tipo Contract
type Contract
	id::Int32
	status::UTF8String
	start_date::Int32 
	counterparty::Counterparty 
	defautable::Bool
	rating::CreditRating 
	prepayable::Bool 
	#riskfree_index::UTF8String 
	#default_balanceSheet_account::UTF8String
end

### Tipo RatingTransition
type RatingTransition
	current_rating::UTF8String
	new_rating::UTF8String
	probability::Float64
end

### Tipo CashFlow
type CashFlow
	contract_id::Int32
	currency::UTF8String
	base_date::Int32
	date::Int32 
	index::UTF8String 
	amortization::Float64 
	interest::Float64 
	total::Float64
end


