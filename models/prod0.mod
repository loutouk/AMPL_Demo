/*
Toy example where everything is put in this folder (model and data)

A steel company must decide how to allocate next week’s time on a rolling mill. 
The mill takes unfinished slabs of steel as input, 
and can produce either of two semi-finished products, 
which we will call bands and coils. 

The mill’s two products come off the rolling line at different rates:
Tons per hour: 	Bands 200
				Coils 140

and they also have different profitabilities:
Profit per ton: Bands $25
				Coils $30

To further complicate matters, the following weekly production amounts 
are the most that can be justified in light of the currently booked orders:
Maximum tons: 	Bands 6,000
				Coils 4,000


Question: If 40 hours of production time are available this week, 
how many tons of bands and how many tons of coils should be produced
to bring in the greatest total profit?

The total hours to produce all these tons cannot exceed 40 hours:
(hours to make a ton of bands) × XB + (hours to make a ton of coils) × XC
(1/200) XB + (1/140) XC ≤ 40

There are also production limits:
0 ≤ XB ≤ 6000
0 ≤ XC ≤ 4000

By analogy with the formula for total hours, the total profit must be:
(profit per ton of bands) × XB + (profit per ton of coils) × XC

That is, our objective is to maximize 25 XB + 30 XC. 

Putting this all together, we have the following linear program:
*/


var XB;
var XC;
maximize Profit: 25 * XB + 30 * XC;
subject to Time: (1/200) * XB + (1/140) * XC <= 40;
subject to B_limit: 0 <= XB <= 6000;
subject to C_limit: 0 <= XC <= 4000;