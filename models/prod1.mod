/*

More realistic example of prod0 with a mathematical model formulation:

SETS		like the products
PARAMETERS	like the production and profit rates
VARIABLE	whose values the solver is to determine
OBJECTIVE	to be maximized or minimized
CONSTRAINTS	that the solution must satisfy


*/

# members of set P will be provided in separate data statements
set PRODUCT;

# parameter may be a single scalar value
param maxHours;	

# or a collection of values indexed by a set: there is an aj for each j in P
# which means that a is a collection of parameter values, one for each member of the set P
# an individual value like aj is written a[j]
param rate {j in PRODUCT};				
param profit {j in PRODUCT};		
param market {j in PRODUCT};

# names a collection of var, one for each member of PRODUCT, whose values the solver is to determine
var X {j in PRODUCT};

# the name Total_Profit is arbitrary; any name will do. 
# the precedence of the sum operator is lower than that of *
# so the expression is indeed a sum of products, as intended
maximize Total_Profit: sum {j in PRODUCT} profit[j] * X[j];

# The Time constraint says that a certain sum over the set PRODUCT 
# may not exceed the value of parameter maxHours
subject to Time: sum {j in PRODUCT} X[j] / rate[j] <= maxHours;

# The Limit constraint is actually a family of constraints,
# one for each member j of PRODUCT: each X[j] is bounded by zero and the corresponding market[j]
# we want to impose a different restriction 0<=X[j]<=market[j] for each different product j in the set PRODUCT
subject to Limit {j in PRODUCT}: 0 <= X[j] <= market[j];