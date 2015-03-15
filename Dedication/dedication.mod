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

set Bonds;

param T > 0 integer;
param Liabilities {1..T}; 
param Price {Bonds};
param Maturity {Bonds};
param Coupon {Bonds};
param Principal {Bonds};

var buy {Bonds} >= 0;
var cash {0..T} >= 0;

minimize total_cost : cash[0] + sum {i in Bonds} Price[i] * buy[i];

subject to cash_balance {t in 1..T}: cash[t-1] - cash[t] + 
	sum{i in Bonds : Maturity[i] >= t} Coupon[i] * buy[i] +
	sum{i in Bonds : Maturity[i] = t} Principal[i] * buy[i] = 
	Liabilities[t];

