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

from pyomo.environ import *

def read_data(filename):
    Bonds = []
    BondData = {}
    Features = []
    Liabilities = []
    Liabilities.append(0)
    f = open(filename, 'r')
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
                Features.append(i)
            line = f.readline()
            while len(line.split()) == len(Features) + 1:
                bond = line.split()[0]
                Bonds.append(bond)
                for value, item in zip(line.split()[1:], Features):
                    value = float(''.join(i for i in value if i != ';'))
                    BondData[bond, item] = value
                line = f.readline()
        else:
            line = f.readline()
    f.close()
    return Bonds, Features, BondData, Liabilities

model = ConcreteModel()

Bonds, Features, BondData, Liabilities = read_data('dedication-Pyomo.dat')

Periods = range(len(Liabilities))

model.buy = Var(Bonds, within=NonNegativeReals)
model.cash = Var(Periods, within=NonNegativeReals)

model.obj = Objective(expr=model.cash[0] + sum(BondData[b, 'Price']*model.buy[b] for b in Bonds), sense=minimize)

def cash_balance_rule(model, t):
    return (model.cash[t-1] - model.cash[t] 
             + sum(BondData[b, 'Coupon'] * model.buy[b] 
                     for b in Bonds if BondData[b, 'Maturity'] >= t)  
             + sum(BondData[b, 'Principal'] * model.buy[b] 
                     for b in Bonds if BondData[b, 'Maturity'] == t)  
             == Liabilities[t])

model.cash_balance = Constraint(Periods[1:], rule=cash_balance_rule)

epsilon = .001

opt = SolverFactory("cbc")
results = opt.solve(model)
model.solutions.load_from(results)

print "Optimal strategy"
for b in model.buy:
    if model.buy[b].value > epsilon:
        print 'Buy %f of Bond %s' %(model.buy[b].value, b)
        
