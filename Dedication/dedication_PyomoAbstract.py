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

from pyomo.environ import AbstractModel, Var, Param, Set, NonNegativeReals
from pyomo.environ import Objective, minimize, Constraint, SolverFactory

model = AbstractModel()

model.Periods = Set()
model.Bonds = Set()
model.Price = Param(model.Bonds)
model.Maturity = Param(model.Bonds)
model.Coupon = Param(model.Bonds)
model.Principal = Param(model.Bonds)
model.Liabilities = Param(range(9))

model.buy = Var(model.Bonds, within=NonNegativeReals)
model.cash = Var(range(9), within=NonNegativeReals)

def objective_rule(model):
    return model.cash[0] + sum(model.Price[b]*model.buy[b] for b in model.Bonds)
model.objective = Objective(sense=minimize, rule=objective_rule)

def cash_balance_rule(model, t):
    return (model.cash[t-1] - model.cash[t] 
             + sum(model.Coupon[b] * model.buy[b] 
                     for b in model.Bonds if model.Maturity[b] >= t)  
             + sum(model.Principal[b] * model.buy[b] 
                     for b in model.Bonds if model.Maturity[b] == t)  
             == model.Liabilities[t])

model.cash_balance = Constraint(range(1, 9), rule=cash_balance_rule)

epsilon = .001

opt = SolverFactory("cbc")
instance = model.create('dedication-Pyomo.dat')
results = opt.solve(instance)
results.write()
instance.load(results)

print "Optimal strategy"
for b in instance.buy:
    if instance.buy[b].value > epsilon:
        print 'Buy %f of Bond %s' %(instance.buy[b].value, b)
