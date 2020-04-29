/* 
Processing of steel slabs is not a single operation, 
but a series of steps that may proceed at different rates. 
To motivate a more general model, 
imagine that we divide production into a reheat stage that can process the incoming slabs at 200 tons per hour, 
and a rolling stage that makes bands, coils or plate at the rates previously given. 
Further imagine that there are only 35 hours of reheat time, even though there are 40 hours of rolling time.

To cover this kind of situation, we can add a set STAGE of production stages to our model. 
The parameter and constraint declarations are modified accordingly.
Since there is a potentially different number of hours available in each stage, 
the parameter avail is now indexed over STAGE. 
Since there is a potentially different production rate for each product in each stage, 
the parameter rate is indexed over both PROD and STAGE. 
In the Time constraint, the production rate for product p in stage s is referred to as rate[p,s]; 
this is AMPL’s version of a doubly subscripted entity like aps in algebraic notation.
The only other change is to the constraint declaration, where we no longer have a single constraint, 
but a constraint for each stage, imposed by limited time available at that stage :

subject to Time {s in STAGE}: sum {p in PROD} (1/rate[p,s]) * Make[p] <= avail[s];
*/

set PROD;   # products
set STAGE;  # stages

param rate {PROD,STAGE} > 0; # tons per hour in each stage
param avail {STAGE} >= 0;    # hours available/week in each stage
param profit {PROD};         # profit per ton

param commit {PROD} >= 0;    # lower limit on tons sold in week
param market {PROD} >= 0;    # upper limit on tons sold in week

var Make {p in PROD} >= commit[p], <= market[p]; # tons produced

maximize Total_Profit: sum {p in PROD} profit[p] * Make[p];

               # Objective: total profits from all products

subject to Time {s in STAGE}:
   sum {p in PROD} (1/rate[p,s]) * Make[p] <= avail[s];

               # In each stage: total of hours used by all
               # products may not exceed hours available
