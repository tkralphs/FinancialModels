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

from bonds_data import bonds, max_rating, max_maturity, max_cash

prob = LpProblem("Bond Selection Model", LpMaximize)

buy = LpVariable.dicts('bonds', bonds.keys(), 0, None)    

prob += lpSum(bonds[b]['yield'] * buy[b] for b in bonds) 

prob += lpSum(buy[b] for b in bonds) <= max_cash, "cash"

prob += lpSum(bonds[b]['rating'] * buy[b] for b in bonds) <= max_cash*max_rating, "ratings"

prob += lpSum(bonds[b]['maturity'] * buy[b] for b in bonds) <= max_cash*max_maturity, "maturities"

status = prob.solve()

epsilon = .001

if LpStatus[status] == 'Optimal':
    print 'Optimal total cost is: ', value(prob.objective)

    print 'Optimal purchases:'
    for i in bonds:
        if buy[i].varValue > epsilon:
            print 'Bond', i, ":", buy[i].varValue

    print

    print 'Marginal Prices:'
    for i in prob.constraints:
        print 'Price of', i, 'constraint:', prob.constraints[i].pi
else:
    print 'Problem is', LpStatus[status]