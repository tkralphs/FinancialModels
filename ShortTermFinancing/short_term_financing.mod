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

param T > 0 integer;   
param cash_flow {0..T};
param credit_rate;     
param bond_yield;
param bond_maturity;
param invest_rate;     

var credit {-1..T} >= 0, <= 100;
var bonds {-3..T} >= 0;
var invest {-1..T} >= 0;

maximize wealth : invest[T];

subject to balance {t in 0..T} : 
credit[t] - (1 + credit_rate)* credit[t-1] +  
bonds[t] - (1 + bond_yield) * bonds[t-bond_maturity] -
invest[t] + (1 + invest_rate) * invest[t-1] = cash_flow[t];

subject to initial_credit : credit[-1] = 0;
subject to final_credit   : credit[T]  = 0;
subject to initial_invest : invest[-1] = 0;
subject to initial_bonds {t in 1..bond_maturity}: bonds[-t] = 0;
subject to final_bonds {t in T+1-bond_maturity..T}  : bonds[t] = 0;
