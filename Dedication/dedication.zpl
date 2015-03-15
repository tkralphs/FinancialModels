#######################################################################
#                                                                     #
# This file is part of a collection developed first for a course in   #
# financial optimization taught out of the text of Cornuejols and     #
# Tutuncu and then adapted for a tutorial on modeling and the COIN-OR #
# Optimization Suite. Materials for the original course on financial  #
# optimization are hosted here:                                       #
#                                                                     #
# http://coral.ie.lehigh.edu/~ted/teaching/ie447                      #
#                                                                     #
# Materials for the tutorial are hosted here:                         #
#                                                                     #
# http://coral.ie.lehigh.edu/~ted/teaching/coin-or                    #
#                                                                     #
#                                                                     #
# This collection of models is licensed under The Creative Commons    # 
# CC BY-SA 3.0 License, a copy of which is available here:            #
#                                                                     #
# http://creativecommons.org/licenses/by-sa/3.0/                      #
#                                                                     #
# Copyright 2014, Ted Ralphs                                          #
# All Rights Reserved                                                 #
# ted@lehigh.edu                                                      #
#                                                                     #
#######################################################################

# ---------------------
# SETS
# ---------------------

# bonds available for purchase

set bonds := {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J"};     
	
# years in planning horizon

set years := {1..8};

# ---------------------
# SETS
# ---------------------

# liabilities[j] is the total liabilitry in  year j

param liabilities[years] := 		
<1>     12000,
<2>     18000,
<3>     20000,
<4>     20000,
<5>     16000,
<6>     15000,
<7>     12000,
<8>     10000;

# cost[i] is the cost per bond for bond type i 
param price[bonds] := 
<"A">   102, 
<"B">    99,
<"C">   101,
<"D">    98,
<"E">    98,
<"F">   104,
<"G">   100,
<"H">   101,
<"I">   102,
<"J">    94;           

# maturity[i] is the year in which bond type i matures
param maturity[bonds] :=
<"A">   1,
<"B">   2,
<"C">   2,
<"D">   3,
<"E">   4,
<"F">   5,
<"G">   5,
<"H">   6,
<"I">   7,
<"J">   8;        

# payment[i] is the coupon payment amount for bond type i
param coupon[bonds] :=
<"A">   5,
<"B">   3.5,
<"C">   5,
<"D">   3.5,
<"E">   4,
<"F">   9,
<"G">   6,
<"H">   8,
<"I">   9,
<"J">   7;        

# The principal paid out at maturity
param principal[bonds] :=
<"A">   100,
<"B">   100,
<"C">   100,
<"D">   100,
<"E">   100,
<"F">   100,
<"G">   100,
<"H">   100,
<"I">   100,
<"J">   100;        

# ---------------------
# VARIABLES
# ---------------------

var buy[bonds] >= 0;             # buy[i] is the number of bonds of type i
                                 # to purchase

var cash [years union {0}] >= 0; # cash[j] is the amount of cash to be carried
			         # over from year j to year j+1

# ---------------------
# OBJECTIVE
# ---------------------

# Total cost

minimize total_cost : cash[0] + sum <i> in bonds : price[i] * buy[i];

# ---------------------
# CONSTRAINTS
# ---------------------

# All assets and liabilities must balance

subto cash_balance : forall <t> in years: cash[t-1] - cash[t] + 
	sum <i> in bonds with maturity[i] >= t : coupon[i] * buy[i] +
	sum <i> in bonds with maturity[i] == t : principal[i] * buy[i] == 
	liabilities[t];


