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

MAXIMIZE
1*invest_5 + 0
SUBJECT TO
_C6: - 12 bonds_2 + bonds_5 - 11 credit_4 + credit_5
 + 103 invest_4 - invest_5 = -300

_C5: - 12 bonds_1 + bonds_4 - 11 credit_3 + credit_4
 + 103 invest_3 - invest_4 = -50

_C9: credit__3 = 0

_C17: bonds_4 = 0

_C19: credit_5 = 0

_C11: invest__2 = 0

_C7: bonds__3 = 0

_C14: invest__1 = 0

_C1: bonds_0 - 12 bonds__3 + credit_0 - 11 credit__1 - invest_0
 + 103 invest__1 = 150

_C12: credit__2 = 0

_C15: credit__1 = 0

_C3: bonds_2 - 12 bonds__1 - 11 credit_1 + credit_2
 + 103 invest_1 - invest_2 = 200

_C2: bonds_1 - 12 bonds__2 - 11 credit_0 + credit_1
 + 103 invest_0 - invest_1 = 100

_C13: bonds__1 = 0

_C16: bonds_3 = 0

_C4: - 12 bonds_0 + bonds_3 - 11 credit_2 + credit_3
 + 103 invest_2 - invest_3 = 200

_C8: invest__3 = 0

_C18: bonds_5 = 0

_C10: bonds__2 = 0

VARIABLES
bonds_0 Continuous
bonds_1 Continuous
bonds_2 Continuous
bonds_3 Continuous
bonds_4 Continuous
bonds_5 Continuous
bonds__1 Continuous
bonds__2 Continuous
bonds__3 Continuous
credit_0 Continuous
credit_1 Continuous
credit_2 Continuous
credit_3 Continuous
credit_4 Continuous
credit_5 Continuous
credit__1 Continuous
credit__2 Continuous
credit__3 Continuous
invest_0 Continuous
invest_1 Continuous
invest_2 Continuous
invest_3 Continuous
invest_4 Continuous
invest_5 Continuous
invest__1 Continuous
invest__2 Continuous
invest__3 Continuous
