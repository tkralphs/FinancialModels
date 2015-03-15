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

\* Source Pyomo model name=unknown *\

min 
x1:
+102.000000 x10
+101.000000 x11
+99.000000 x12
+98.000000 x13
+98.000000 x14
+100.000000 x15
+104.000000 x16
+102.000000 x17
+101.000000 x18
+94.000000 x19
+1.000000 x20
 +0.0 ONE_VAR_CONSTANT

s.t.

c_e_x2_:
+105.000000 x10
+5.000000 x11
+3.500000 x12
+4.000000 x13
+3.500000 x14
+6.000000 x15
+9.000000 x16
+9.000000 x17
+8.000000 x18
+7.000000 x19
+1.000000 x20
-1.000000 x21
= 12000.0

c_e_x3_:
+105.000000 x11
+103.500000 x12
+4.000000 x13
+3.500000 x14
+6.000000 x15
+9.000000 x16
+9.000000 x17
+8.000000 x18
+7.000000 x19
+1.000000 x21
-1.000000 x22
= 18000.0

c_e_x4_:
+4.000000 x13
+103.500000 x14
+6.000000 x15
+9.000000 x16
+9.000000 x17
+8.000000 x18
+7.000000 x19
+1.000000 x22
-1.000000 x23
= 20000.0

c_e_x5_:
+104.000000 x13
+6.000000 x15
+9.000000 x16
+9.000000 x17
+8.000000 x18
+7.000000 x19
+1.000000 x23
-1.000000 x24
= 20000.0

c_e_x6_:
+106.000000 x15
+109.000000 x16
+9.000000 x17
+8.000000 x18
+7.000000 x19
+1.000000 x24
-1.000000 x25
= 16000.0

c_e_x7_:
+9.000000 x17
+108.000000 x18
+7.000000 x19
+1.000000 x25
-1.000000 x26
= 15000.0

c_e_x8_:
+109.000000 x17
+7.000000 x19
+1.000000 x26
-1.000000 x27
= 12000.0

c_e_x9_:
+107.000000 x19
+1.000000 x27
-1.000000 x28
= 10000.0

c_e_ONE_VAR_CONSTANT: 
ONE_VAR_CONSTANT = 1.0

bounds 
   0 <= x10 <= +inf
   0 <= x12 <= +inf
   0 <= x11 <= +inf
   0 <= x14 <= +inf
   0 <= x13 <= +inf
   0 <= x16 <= +inf
   0 <= x15 <= +inf
   0 <= x18 <= +inf
   0 <= x17 <= +inf
   0 <= x19 <= +inf
   0 <= x20 <= +inf
   0 <= x21 <= +inf
   0 <= x22 <= +inf
   0 <= x23 <= +inf
   0 <= x24 <= +inf
   0 <= x25 <= +inf
   0 <= x26 <= +inf
   0 <= x27 <= +inf
   0 <= x28 <= +inf
end 
