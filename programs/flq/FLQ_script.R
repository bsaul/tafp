setwd("/Users/andrewbeauchesne/Desktop/TrueNorth Research/Taste Adaptation Study/FLQ Scoring/")
TA<-read.csv("TasteAdaptationStudy_DATA_2018-06-26_1814.csv", header=TRUE)
TA2<-read.csv("TasteAdaptationStudy_DATA_2018-07-07_2114.csv", header=TRUE)
stattest<-read.csv("stattest.csv", header=TRUE)


#Note on specific exported data file from RedCAP:
  #Under "Data Exports, Reports, and Stats"
  #Selected instruments and/or events ->
    #Instrument: Food Liking Questionnaire AND Events: Pre-treatment
  #Export data CSV / Microsoft Excel (raw data)


####### --- PART ONE: NO LINEAR TRANSFORMATION BASELINE--- ########

#first-order model for liking for salt

TA$salt <- (TA$p2_q1a*0.622 + TA$p2_q5a*0.759 + TA$p2_q6a*0.777 + TA$p2_q8a*0.798 + 
              TA$p4_q5*0.491 + TA$p4_q6*0.398 + TA$p4_q11*0.332 + TA$p4_q12*0.807 + 
              TA$p4_q14*0.796 + TA$p4_q17*0.687 + TA$p4_q18*0.793)/11


#first-order model for liking for sweet
#liking scores were computed for factors F2 through F6
#overall liking score was computed by averaging compounding factors

TA$sweet <- ((TA$p3_q1___4*0.431 + TA$p3_q1___5*0.431 + TA$p3_q1___6*0.431 + 
               TA$p1_q22*0.493 + TA$p1_q24*0.692 + TA$p1_q25*0.78 + TA$p1_q28*0.448 + 
               TA$p1_q29*0.627 + TA$p3_q1___0*0.431 + TA$p3_q1___3*0.431 + TA$p3_q1___2*0.431 +
               TA$p3_q1___1*0.431)/12 + 

               (TA$p1_q22*0.573 + TA$p1_q23*0.702 + TA$p1_q26*0.658 + TA$p1_q27*0.657)/4 + 
                  
               (TA$p4_q3*0.851 + TA$p4_q23*0.725 + TA$p4_q24*0.791)/3 + 
               
               (TA$p2_q12a*0.66 + TA$p2_q15a*0.556 + TA$p2_q16a*0.715 + TA$p4_q10*0.42)/4 + 
               
               (TA$p2_q14a*0.658 + TA$p4_q2*0.441 + TA$p4_q19*0.726 + TA$p4_q21*0.659)/4)/5
  

#first-order model for liking for fat and salt
#liking scores were computed for factors F7 through F11
#overall liking score was computed by averaging compounding factors

TA$fatsalt <- ((TA$p1_q4*0.777 + TA$p1_q5*0.739 + TA$p1_q6*0.732 + TA$p1_q7*0.777 + TA$p1_q8*0.661 +
                TA$p1_q9*0.55 + TA$p1_q10*0.661 + TA$p1_q15*0.55)/8 +
                 
                (TA$p2_q2a*0.603 + TA$p2_q3a*0.628 + TA$p2_q4a*0.693 + TA$p2_q7a*0.559 + TA$p2_q9a*0.492 +
                TA$p2_q10a*0.484 + TA$p2_q11a*0.58 + TA$p4_q1*0.516 + TA$p4_q13*0.496 + TA$p4_q15*0.71 + 
                TA$p4_q16*0.681)/11 +
                
                (TA$p1_q17*0.624 + TA$p1_q18*0.807 + TA$p1_q19*0.808 + TA$p1_q20*0.717)/4 + 
                 
                (TA$p1_q11*0.464 + TA$p1_q12*0.495 + TA$p1_q13*0.838 + TA$p1_q14*0.79 + 
                TA$p1_q16*0.509)/5 +
                
                (TA$p1_q1*0.803 + TA$p1_q2*0.813 + TA$p1_q3*0.734)/3)/5


#first-order model for liking for fat and sweet
#liking scores were computed for factors F12 through F15
#overall liking score was computed by averaging compounding factors

TA$fatsweet <- ((TA$p1_q30*0.433 + TA$p1_q31*0.849 + TA$p1_q35*0.469 + TA$p1_q36*0.528 + 
                TA$p1_q37*0.536 + TA$p1_q38*0.835 + TA$p1_q40*0.665 + TA$p1_q41*0.654)/8 +
  
                (TA$p2_q17a*0.761 + TA$p2_q18a*0.635 + TA$p2_q19a*0.787 + TA$p4_q7*0.854 + TA$p4_q20*0.811)/5 +
  
                (TA$p1_q32*0.834 + TA$p2_q13a*0.816 + TA$p4_q9*0.654 + TA$p4_q22*0.635)/4 +
  
                (TA$p1_q33*0.925 + TA$p1_q34*0.795 + TA$p1_q39*0.925)/3)/4


write.csv(TA, "data_FLQscores.csv")







####### --- PART TWO: LINEAR TRANSFORMATION BASELINE --- ########
#Survey data was linearly transformed into values from 0 - 10
  #(i.e. values from questions 48-66 and 77-89 were multipled by 5/3)

#first-order model for liking for salt

TA$salt2 <- (TA$p2_q1a*0.622*5/3 + TA$p2_q5a*0.759*5/3 + TA$p2_q6a*0.777*5/3 + TA$p2_q8a*0.798*5/3 + 
              TA$p4_q5*0.491 + TA$p4_q6*0.398 + TA$p4_q11*0.332 + TA$p4_q12*0.807*5/3 + 
              TA$p4_q14*0.796*5/3 + TA$p4_q17*0.687*5/3 + TA$p4_q18*0.793*5/3)/11


#first-order model for liking for sweet
#liking scores were computed for factors F2 through F6
#overall liking score was computed by averaging compounding factors

TA$sweet2 <- ((TA$p3_q1___4*0.431 + TA$p3_q1___5*0.431 + TA$p3_q1___6*0.431 + 
                TA$p1_q22*0.493 + TA$p1_q24*0.692 + TA$p1_q25*0.78 + TA$p1_q28*0.448 + 
                TA$p1_q29*0.627 + TA$p3_q1___0*0.431 + TA$p3_q1___3*0.431 + TA$p3_q1___2*0.431 +
                TA$p3_q1___1*0.431)/12 + 
               
               (TA$p1_q22*0.573 + TA$p1_q23*0.702 + TA$p1_q26*0.658 + TA$p1_q27*0.657)/4 + 
               
               (TA$p4_q3*0.851 + TA$p4_q23*0.725*5/3 + TA$p4_q24*0.791*5/3)/3 + 
               
               (TA$p2_q12a*0.66*5/3 + TA$p2_q15a*0.556*5/3 + TA$p2_q16a*0.715*5/3 + TA$p4_q10*0.42)/4 + 
               
               (TA$p2_q14a*0.658*5/3 + TA$p4_q2*0.441 + TA$p4_q19*0.726*5/3 + TA$p4_q21*0.659*5/3)/4)/5


#first-order model for liking for fat and salt
#liking scores were computed for factors F7 through F11
#overall liking score was computed by averaging compounding factors

TA$fatsalt2 <- ((TA$p1_q4*0.777 + TA$p1_q5*0.739 + TA$p1_q6*0.732 + TA$p1_q7*0.777 + TA$p1_q8*0.661 +
                  TA$p1_q9*0.55 + TA$p1_q10*0.661 + TA$p1_q15*0.55)/8 +
                 
                 (TA$p2_q2a*0.603*5/3 + TA$p2_q3a*0.628*5/3 + TA$p2_q4a*0.693*5/3 + TA$p2_q7a*0.559*5/3 + TA$p2_q9a*0.492*5/3 +
                    TA$p2_q10a*0.484*5/3 + TA$p2_q11a*0.58*5/3 + TA$p4_q1*0.516 + TA$p4_q13*0.496*5/3 + TA$p4_q15*0.71*5/3 + 
                    TA$p4_q16*0.681*5/3)/11 +
                 
                 (TA$p1_q17*0.624 + TA$p1_q18*0.807 + TA$p1_q19*0.808 + TA$p1_q20*0.717)/4 + 
                 
                 (TA$p1_q11*0.464 + TA$p1_q12*0.495 + TA$p1_q13*0.838 + TA$p1_q14*0.79 + 
                    TA$p1_q16*0.509)/5 +
                 
                 (TA$p1_q1*0.803 + TA$p1_q2*0.813 + TA$p1_q3*0.734)/3)/5


#first-order model for liking for fat and sweet
#liking scores were computed for factors F12 through F15
#overall liking score was computed by averaging compounding factors

TA$fatsweet2 <- ((TA$p1_q30*0.433 + TA$p1_q31*0.849 + TA$p1_q35*0.469 + TA$p1_q36*0.528 + 
                   TA$p1_q37*0.536 + TA$p1_q38*0.835 + TA$p1_q40*0.665 + TA$p1_q41*0.654)/8 +
                  
                  (TA$p2_q17a*0.761*5/3 + TA$p2_q18a*0.635*5/3 + TA$p2_q19a*0.787*5/3 + TA$p4_q7*0.854 + TA$p4_q20*0.811*5/3)/5 +
                  
                  (TA$p1_q32*0.834 + TA$p2_q13a*0.816*5/3 + TA$p4_q9*0.654 + TA$p4_q22*0.635*5/3)/4 +
                  
                  (TA$p1_q33*0.925 + TA$p1_q34*0.795 + TA$p1_q39*0.925)/3)/4


write.csv(TA, "data_FLQscores.csv")




####### --- PART THREE: LINEAR TRANSFORMATION 30-DAY FOLLOW UP--- ########

#Survey data was linearly transformed into values from 0 - 10
#(i.e. values from questions 48-66 and 77-89 were multipled by 5/3)

#first-order model for liking for salt

TA2$salt2 <- (TA2$p2_q1a*0.622*5/3 + TA2$p2_q5a*0.759*5/3 + TA2$p2_q6a*0.777*5/3 + TA2$p2_q8a*0.798*5/3 + 
               TA2$p4_q5*0.491 + TA2$p4_q6*0.398 + TA2$p4_q11*0.332 + TA2$p4_q12*0.807*5/3 + 
               TA2$p4_q14*0.796*5/3 + TA2$p4_q17*0.687*5/3 + TA2$p4_q18*0.793*5/3)/11


#first-order model for liking for sweet
#liking scores were computed for factors F2 through F6
#overall liking score was computed by averaging compounding factors

TA2$sweet2 <- ((TA2$p3_q1___4*0.431 + TA2$p3_q1___5*0.431 + TA2$p3_q1___6*0.431 + 
                 TA2$p1_q22*0.493 + TA2$p1_q24*0.692 + TA2$p1_q25*0.78 + TA2$p1_q28*0.448 + 
                 TA2$p1_q29*0.627 + TA2$p3_q1___0*0.431 + TA2$p3_q1___3*0.431 + TA2$p3_q1___2*0.431 +
                 TA2$p3_q1___1*0.431)/12 + 
                
                (TA2$p1_q22*0.573 + TA2$p1_q23*0.702 + TA2$p1_q26*0.658 + TA2$p1_q27*0.657)/4 + 
                
                (TA2$p4_q3*0.851 + TA2$p4_q23*0.725*5/3 + TA2$p4_q24*0.791*5/3)/3 + 
                
                (TA2$p2_q12a*0.66*5/3 + TA2$p2_q15a*0.556*5/3 + TA2$p2_q16a*0.715*5/3 + TA2$p4_q10*0.42)/4 + 
                
                (TA2$p2_q14a*0.658*5/3 + TA2$p4_q2*0.441 + TA2$p4_q19*0.726*5/3 + TA2$p4_q21*0.659*5/3)/4)/5


#first-order model for liking for fat and salt
#liking scores were computed for factors F7 through F11
#overall liking score was computed by averaging compounding factors

TA2$fatsalt2 <- ((TA2$p1_q4*0.777 + TA2$p1_q5*0.739 + TA2$p1_q6*0.732 + TA2$p1_q7*0.777 + TA2$p1_q8*0.661 +
                   TA2$p1_q9*0.55 + TA2$p1_q10*0.661 + TA2$p1_q15*0.55)/8 +
                  
                  (TA2$p2_q2a*0.603*5/3 + TA2$p2_q3a*0.628*5/3 + TA2$p2_q4a*0.693*5/3 + TA2$p2_q7a*0.559*5/3 + TA2$p2_q9a*0.492*5/3 +
                     TA2$p2_q10a*0.484*5/3 + TA2$p2_q11a*0.58*5/3 + TA2$p4_q1*0.516 + TA2$p4_q13*0.496*5/3 + TA2$p4_q15*0.71*5/3 + 
                     TA2$p4_q16*0.681*5/3)/11 +
                  
                  (TA2$p1_q17*0.624 + TA2$p1_q18*0.807 + TA2$p1_q19*0.808 + TA2$p1_q20*0.717)/4 + 
                  
                  (TA2$p1_q11*0.464 + TA2$p1_q12*0.495 + TA2$p1_q13*0.838 + TA2$p1_q14*0.79 + 
                     TA2$p1_q16*0.509)/5 +
                  
                  (TA2$p1_q1*0.803 + TA2$p1_q2*0.813 + TA2$p1_q3*0.734)/3)/5


#first-order model for liking for fat and sweet
#liking scores were computed for factors F12 through F15
#overall liking score was computed by averaging compounding factors

TA2$fatsweet2 <- ((TA2$p1_q30*0.433 + TA2$p1_q31*0.849 + TA2$p1_q35*0.469 + TA2$p1_q36*0.528 + 
                    TA2$p1_q37*0.536 + TA2$p1_q38*0.835 + TA2$p1_q40*0.665 + TA2$p1_q41*0.654)/8 +
                   
                   (TA2$p2_q17a*0.761*5/3 + TA2$p2_q18a*0.635*5/3 + TA2$p2_q19a*0.787*5/3 + TA2$p4_q7*0.854 + TA2$p4_q20*0.811*5/3)/5 +
                   
                   (TA2$p1_q32*0.834 + TA2$p2_q13a*0.816*5/3 + TA2$p4_q9*0.654 + TA2$p4_q22*0.635*5/3)/4 +
                   
                   (TA2$p1_q33*0.925 + TA2$p1_q34*0.795 + TA2$p1_q39*0.925)/3)/4


write.csv(TA2, "data_FLQscores2.csv")



t.test(stattest$salt2, stattest$salt2b, paired=TRUE, var.equal = FALSE)
t.test(stattest$sweet2, stattest$sweet2b, paired=TRUE, var.equal = FALSE)
t.test(stattest$fatsalt2, stattest$fatsalt2b, paired=TRUE, var.equal = FALSE)
t.test(stattest$fatsweet2, stattest$fatsweet2b, paired=TRUE, var.equal = FALSE)
