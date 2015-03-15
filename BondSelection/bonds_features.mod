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

set bonds;
set bond_features;

# ---------------------
# PARAMETERS
# ---------------------

param bond_data {bonds, bond_features};
param limits{bond_features};
param yield{bonds};

param max_cash;               # Maximum amount of cash available to invest

# ---------------------
# VARIABLES
# ---------------------

var buy {bonds} >= 0;         # buy[i] is the amount to invest in bond i

# ---------------------
# OBJECTIVE
# ---------------------

maximize obj : sum {i in bonds} yield[i] * buy[i];

# ---------------------
# CONSTRAINTS
# ---------------------

subject to cash_limit : sum {i in bonds} buy[i] <= max_cash;

subject to limit_constraints {f in bond_features}: 
sum {i in bonds} bond_data[i, f]*buy[i] <=  max_cash*limits[f];
