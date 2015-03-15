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

from pulp import LpProblem, LpVariable, lpSum, LpMaximize, value, LpStatus

from short_term_financing_data import cash_flow, credit_rate, bond_yield 
from short_term_financing_data import bond_maturity, invest_rate

T = len(cash_flow)

# Creates the 'prob' variable to contain the problem data
prob = LpProblem("Short Term Financing Model", LpMaximize)

# ---------------------
# VARIABLES
# ---------------------

credit = LpVariable.dicts("credit", range(-1, T), 0, None)
bonds = LpVariable.dicts("bonds", range(-bond_maturity, T), 0, None) 
invest = LpVariable.dicts("invest", range(-1, T), 0, None)

# ---------------------
# OBJECTIVE
# ---------------------

prob += invest[T-1]

# ---------------------
# CONSTRAINTS
# ---------------------

for t in range(0, T):
    prob += (credit[t] - (1 + credit_rate)* credit[t-1] +  
                    bonds[t] - (1 + bond_yield) * bonds[t-int(bond_maturity)] -
                    invest[t] + (1 + invest_rate) * invest[t-1] == cash_flow[t])

prob += credit[-1] == 0
prob += credit[T-1] == 0
prob += invest[-1] == 0
for t in range(-int(bond_maturity), 0):  prob += bonds[t] == 0
for t in range(T-int(bond_maturity), T): prob += bonds[t] == 0

status = prob.solve()

if LpStatus[status] == 'Optimal':
    print 'Optimal total cost is: ', value(prob.objective)

    print 'Optimal strategy is'
    for t in range(T-1):
        print 'At time', t, ":"
        if credit[t].varValue > 0:
            print '    Borrow', credit[t].varValue
        if bonds[t].varValue > 0:
            print '    Purchase',  bonds[t].varValue, 'worth of bonds'
        if invest[t].varValue > 0:
            print '    Invest ', invest[t].varValue
else:
    print 'Problem is', LpStatus[status]
