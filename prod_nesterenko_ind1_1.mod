# Nesterenko Task 2013
# Written in GNU MathProg by Vitaly Feskov vitalfes(at)ya.ru in November 2013

set index := {1..3};

var plan {i in index} >= 0, integer; 	# Integer plan of production var's
param kraska {i in index} > 0;	     	# parameter's on materials	

param price {i in index} > 0;		# parameter's on sales prices
param vc {i in index} > 0;		# VC parameter's
param time {i in index} > 0;		# producing time parameter's
param planning {i in index} > 0;	# maximum plan parameter's
param fc_month > 0;			# Fixed Cost per month
param kraska_cost > 0; 			# Cost of Kraska per gramm

maximize profit:

  sum {i in index} price[i] * plan[i] -   		# revenue
  sum {i in index} vc[i] * plan[i] - 		  	 # VC spendings
  sum {i in index} kraska[i] * kraska_cost * plan[i] -  # spendings on painting
   fc_month*3;   # FC quarterly

subject to

krs:  sum {i in index} kraska[i] * kraska_cost * plan[i] <= 30000; # limit on materials

tim:  sum {i in index} time[i] * plan[i] <= 25*(8*60)*60; 
	# limit on working time

pl1:   plan[1] <= planning[1];
pl2:   plan[2] <= planning[2];
pl3:   plan[3] <= planning[3];

solve;

printf 'Profit=%d Rubles\n', profit - fc_month*3 ; # Correcting ignoring constant

display plan;

data;

param fc_month := 33300;

param kraska_cost := 1;

param:   time            vc          kraska    price   planning := 

 1	60.0		14.0		5.0	50.0   3800.0
 2	40.0		8.0		2.0	20.0   5100.0
 3	35.0		9.0		3.0	30.0   6200.0 	;

end;


