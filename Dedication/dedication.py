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

from pulp import LpProblem, LpVariable, lpSum, LpMinimize, value

def read_data(filename):
    Bonds = []
    BondData = {}
    BondDataItems = []
    Liabilities = []
    Liabilities.append(0)
    f = open('dedication.dat', 'r')
    line = f.readline()
    while len(line):
        if 'Liabilities' in line:
            t = 1
            line = f.readline()
            while len(line.split()) == 2:
                period, liability = line.split()
                if int(period) == t:
                    liability = int(''.join(i for i in liability if i.isdigit()))
                    Liabilities.append(liability)
                    t += 1
                else:
                    print 'Missing liability data!'
                line = f.readline()
        elif 'Coupon' in line:
            for i in line.split():
                if i == 'param' or i == ':' or i == ':=':
                    continue
                BondDataItems.append(i)
            line = f.readline()
            while len(line.split()) == len(BondDataItems) + 1:
                bond = line.split()[0]
                Bonds.append(bond)
                for value, item in zip(line.split()[1:], BondDataItems):
                    value = float(''.join(i for i in value if i != ';'))
                    BondData[bond, item] = value
                line = f.readline()
        else:
            line = f.readline()
    f.close()
    return Bonds, BondDataItems, BondData, Liabilities

Bonds, BondDataItems, BondData, Liabilities = read_data('dedication.dat')

# Creates the 'prob' variable to contain the problem data
prob = LpProblem("Dedication Model", LpMinimize)

buy = LpVariable.dicts("buy", Bonds, 0, None)

cash = LpVariable.dicts("cash", range(len(Liabilities)), 0, None)

# ---------------------
# OBJECTIVE
# ---------------------

prob += cash[0] + lpSum(BondData[b, 'Price']*buy[b] for b in Bonds)

# ---------------------
# CONSTRAINTS
# ---------------------

for t in range(1, len(Liabilities)):
    prob += (cash[t-1] - cash[t] 
             + lpSum(BondData[b, 'Coupon'] * buy[b] 
                     for b in Bonds if BondData[b, 'Maturity'] >= t)  
             + lpSum(BondData[b, 'Principal'] * buy[b] 
                     for b in Bonds if BondData[b, 'Maturity'] == t)  
             == Liabilities[t])

prob.solve()
print 'Optimal total cost is: ', value(prob.objective)

print 'Optimal purchases are:'
for b in Bonds:
    if buy[b].varValue > 0:
        print 'Bond ', b, ': ', buy[b].varValue

print 'Cash in each period is:'
for t in cash:
    print 'Period ', int(t), ': ', cash[t].varValue


