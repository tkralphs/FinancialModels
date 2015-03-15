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

set bonds := {
<"A", 102, 1, 5,   100>,
<"B",  99, 2, 3.5, 100>,
<"C", 101, 2, 5  , 100>, 
<"D",  98, 3, 3.5, 100>,
<"E",  98, 4, 4  , 100>,
<"F", 104, 5, 9  , 100>,
<"G", 100, 5, 6  , 100>,
<"H", 101, 6, 8  , 100>,
<"I", 102, 7, 9  , 100>,
<"J",  94, 8, 7  , 100>
};
	
# the total liability in  each year 

set liabilities := {
<1, 12000>,
<2, 18000>,
<3, 20000>,
<4, 20000>,
<5, 16000>,
<6, 15000>,
<7, 12000>,
<8, 10000>
};

# number of years in the horizon

param T := 8;

# ---------------------
# VARIABLES
# ---------------------

var buy[bonds] >= 0;             # the number of bonds to purchase

var cash [{0..T}] >= 0;          # the cash surplus at the beginning
			         # of each year

# ---------------------
# OBJECTIVE
# ---------------------

# Total cost

minimize total_cost : cash[0] + 
sum <i, p, m, c, f> in bonds : p * buy[i, p, m, c, f];

# ---------------------
# CONSTRAINTS
# ---------------------

# All assets and liabilities must balance

subto cash_balance : forall <t, l> in liabilities: cash[t-1] - cash[t] + 
	sum <i, p, m, c, f> in bonds with m >= t : c * buy[i, p, m, c, f] +
	sum <i, p, m, c, f> in bonds with m == t : f * buy[i, p, m, c, f] 
	==  l;


