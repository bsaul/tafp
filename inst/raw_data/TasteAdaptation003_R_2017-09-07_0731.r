#Clear existing data and graphics
rm(list=ls())
graphics.off()
#Load Hmisc library
library(Hmisc)
#Read Data
data=read.csv('data/TasteAdaptation003_DATA_2017-09-07_0731.csv')
#Setting Labels

label(data$record_id)="Record ID"
label(data$redcap_event_name)="Event Name"
label(data$food_liking_questionnaire_timestamp)="Survey Timestamp"
label(data$date_flq)="Date"
label(data$gender_flq)="Gender"
label(data$diet_flq)="Diet"
label(data$p1_q1)="How much do you like salty snacks (e.g., pretzels, crackers, biscuits, etc.)?"
label(data$p1_q2)="How much do you like potato chips?"
label(data$p1_q3)="How much do you like salted nuts and/or seeds?"
label(data$p1_q4)="How much do you like breakfast sausage (pork, beef, chicken, turkey, etc.)?"
label(data$p1_q5)="How much do you like bratwurst (veal, pork, beef, etc.)?"
label(data$p1_q6)="How much do you like smoked ham?"
label(data$p1_q7)="How much do you like deli meats (i.e., roast beef, bologna, ham, turkey, etc.)?"
label(data$p1_q8)="How much do you like bacon (pork, turkey, etc.)?"
label(data$p1_q9)="How much do you like salted canned meat or fish (i.e., chicken, tuna, salmon, etc.)?"
label(data$p1_q10)="How much do you like hot dogs (beef, pork, chicken, etc.)?"
label(data$p1_q11)="How much do you like hard cheese (i.e., sharp cheddar, parmesan, etc.)?"
label(data$p1_q12)="How much do you like semi-hard cheese (i.e., mozzarella, pepper jack, feta, etc.)?"
label(data$p1_q13)="How much do you like macaroni and cheese?"
label(data$p1_q14)="How much do you like cheese sauce (e.g., on pasta, nachos, fries, etc.)?"
label(data$p1_q15)="How much do you like fried chicken?"
label(data$p1_q16)="How much do you like gravy?"
label(data$p1_q17)="How much do you like meat kebabs?"
label(data$p1_q18)="How much do you like hamburgers?"
label(data$p1_q19)="How much do you like chicken nuggets?"
label(data$p1_q20)="How much do you like caramelized meat drippings?"
label(data$p1_q22)="How much do you like dried fruit (e.g., raisins, apricots, etc.)?"
label(data$p1_q21)="How much do you like fruit juice?"
label(data$p1_q23)="How much do you like sweeteners (e.g., honey, agave, maple syrup, corn syrup, etc.)?"
label(data$p1_q24)="How much do you like fudge?"
label(data$p1_q25)="How much do you like candy?"
label(data$p1_q26)="How much do you like candy bars?"
label(data$p1_q27)="How much do you like coffee cake?"
label(data$p1_q28)="How much do you like whipped cream?"
label(data$p1_q29)="How much do you like pudding?"
label(data$p1_q30)="How much do you like caramel?"
label(data$p1_q31)="How much do you like cupcakes?"
label(data$p1_q32)="How much do you like chocolate mousse?"
label(data$p1_q33)="How much do you like cake?"
label(data$p1_q34)="How much do you like brownies?"
label(data$p1_q35)="How much do you like cheesecake?"
label(data$p1_q36)="How much do you like vanilla wafers?"
label(data$p1_q37)="How much do you like sugar cookies?"
label(data$p1_q38)="How much do you like croissants?"
label(data$p1_q39)="How much do you like chocolate chip cookies?"
label(data$p1_q40)="How much do you like apple pie?"
label(data$p1_q41)="How much do you like doughnuts?"
label(data$p2_example)="Check the box that corresponds to how much butter you prefer to eat on steak. "
label(data$p2_q1a)="Check the box that corresponds to how much salt you prefer to eat on boiled eggs. "
label(data$p2_q2a)="Check the box that corresponds to how much butter you prefer to eat on corn on the cob. "
label(data$p2_q3a)="Check the box that corresponds to how much mayonnaise you prefer to eat on deli meat sandwiches. "
label(data$p2_q4a)="Check the box that corresponds to how much butter you prefer to eat on green beans."
label(data$p2_q5a)="Check the box that corresponds to how much salt you prefer to eat on green beans."
label(data$p2_q6a)="Check the box that corresponds to how much salt you prefer to eat on mashed potatoes."
label(data$p2_q7a)="Check the box that corresponds to how much butter you prefer to eat on steaks."
label(data$p2_q8a)="Check the box that corresponds to how much salt you prefer to eat on chicken breasts."
label(data$p2_q9a)="Check the box that corresponds to how much dill sauce you prefer to eat on salmon."
label(data$p2_q10a)="Check the box that corresponds to how much mayonnaise you prefer to eat on cheese sandwiches."
label(data$p2_q11a)="Check the box that corresponds to how much butter you prefer to eat on toast."
label(data$p2_q12a)="Check the box that corresponds to how much jam you prefer to eat on toast."
label(data$p2_q13a)="Check the box that corresponds to how much nutella or chocolate spread you prefer to eat on toast."
label(data$p2_q14a)="Check the box that corresponds to how much sugar you prefer to eat on strawberries."
label(data$p2_q15a)="Check the box that corresponds to how much fruit you prefer to eat on yogurt."
label(data$p2_q16a)="Check the box that corresponds to how much syrup you prefer to eat on pancakes."
label(data$p2_q17a)="Check the box that corresponds to how much butter you prefer to eat on pancakes."
label(data$p2_q18a)="Check the box that corresponds to how much whipped cream you prefer to eat on brownies."
label(data$p2_q19a)="Check the box that corresponds to how much whipped cream you prefer to eat on ice cream."
label(data$p3_q1___0)="In the list of drink below, select the drinks that you prefer. You can select up to 3 choices. If you do not like any of the drink choices select None. (choice=Fruit Juice (apricot, pear, grape, apple, orange, etc.))"
label(data$p3_q1___1)="In the list of drink below, select the drinks that you prefer. You can select up to 3 choices. If you do not like any of the drink choices select None. (choice=Tomato Juice)"
label(data$p3_q1___2)="In the list of drink below, select the drinks that you prefer. You can select up to 3 choices. If you do not like any of the drink choices select None. (choice=Soda (lemonade, cola, diet cola, orange soda, etc.))"
label(data$p3_q1___3)="In the list of drink below, select the drinks that you prefer. You can select up to 3 choices. If you do not like any of the drink choices select None. (choice=Flavored Water)"
label(data$p3_q1___4)="In the list of drink below, select the drinks that you prefer. You can select up to 3 choices. If you do not like any of the drink choices select None. (choice=Sparkling Water (with or without lemon))"
label(data$p3_q1___5)="In the list of drink below, select the drinks that you prefer. You can select up to 3 choices. If you do not like any of the drink choices select None. (choice=Mineral Water (with or without lemon))"
label(data$p3_q1___6)="In the list of drink below, select the drinks that you prefer. You can select up to 3 choices. If you do not like any of the drink choices select None. (choice=None)"
label(data$p4_q1)="You are given bread at a party. You realize there is no butter. Does it bother you to eat bread without butter? "
label(data$p4_q2)="You are in a restaurant and order yogurt with fruit. After tasting it you realize that it is not very sweet. Does it bother you to eat yogurt that is not very sweet? "
label(data$p4_q3)="You are in a cafe and the waiter brings your favorite hot drink (coffee, tea, herbal tea). There is no sugar on the table. Does it bother you to drink your hot drink without sugar?"
label(data$p4_q5)="Do you add salt to your meal before tasting it?"
label(data$p4_q6)="You go on a BBQ with friends. You bring bread, egg salad, and tomatoes. Do you remember to bring salt?    "
label(data$p4_q7)="You are eating a cup of ice cream. Do you put whipped cream on top?"
label(data$p4_q9)="Do you eat nutella or chocolate spread with a spoon? "
label(data$p4_q10)="Do you eat jam with a spoon? "
label(data$p4_q11)="Do you add salt to the water used to cook pasta?"
label(data$p4_q12)="How do you prefer your soup?"
label(data$p4_q13)="How do you prefer your soup?"
label(data$p4_q14)="How do you prefer your pasta?"
label(data$p4_q15)="How do you prefer your pasta?"
label(data$p4_q16)="How do you prefer your mashed potatoes?"
label(data$p4_q17)="How do you prefer your fries?"
label(data$p4_q18)="How do you prefer your steak?"
label(data$p4_q19)="How do you prefer your yogurt?"
label(data$p4_q20)="How do you prefer your strawberries?"
label(data$p4_q21)="How do you prefer your pancakes?"
label(data$p4_q22)="How do you prefer your pancakes?"
label(data$p4_q23)="How do you prefer your tea?"
label(data$p4_q24)="How do you prefer your coffee?"
label(data$food_liking_questionnaire_complete)="Complete?"
label(data$date_screening)="Date"
label(data$tnhc_screening)="Will you fast at TNHC for a minimum of 5 days and a maximum of 12 days?"
label(data$has_the_participant_stayed)="Have you previously stayed at TNHC?"
label(data$vegan_sos_screening)="Do you eat an exclusively plant based diet free from sugar, oil, and salt?"
label(data$diet_screening)="How would you describe your diet?"
label(data$pregnant_nursing_screening)="Are you pregnant or nursing within the last three months?"
label(data$taste_disorder_screening)="Do you have a smell or taste disorder?"
label(data$cancer_screening)="Do you have cancer?"
label(data$bp_screening)="Do you have blood pressure ≥160 mm Hg systolic/≥100 mm Hg diastolic?"
label(data$glucose_screening)="Do you have fasting glucose ≥126 mg/dL?"
label(data$allergic_screening)="Are you allergic or sensitive to any of the following?  Sucrose Sodium Chloride Citric Acid Caffeine Monosodium Glutamate Linoleic Acid Gum Arabic Xanthan Gum EDTA"
label(data$smoker_screening)="Do you smoke or have you smoked in the last 12 months?"
label(data$do_you_drink_alcohol)="Do you drink alcohol?"
label(data$alcohol_screening)="How many drinks per week?"
label(data$do_you_use_drugs)="Do you use recreational drugs?"
label(data$drug_screening)="How many times per week?"
label(data$consent_screening)="Are you willing to provide informed consent?"
label(data$eligibility_tnh)="Is the participant eligible?"
label(data$enrolled_tnh)="Is the participant enrolled?"
label(data$tnh_participant_screening_eligibility_form_complete)="Complete?"
label(data$proceed_hipaa)="Proceed to review of confidentiality, use/disclosure of protected health information authorization and agreement to participate in study?"
label(data$agree)="Statement by person agreeing to be in this study:"
label(data$date_consented)="Date:"
label(data$time_consented)="Date:"
label(data$tnh_participant_consent_form_complete)="Complete?"
label(data$date)="Date"
label(data$gender)="Gender"
label(data$marital_status)="Marital Status"
label(data$demographics_complete)="Complete?"
label(data$treatment_plan)="Proposed Water-only Fasting Treatment Plan"
label(data$arrival_date)="Arrival Date"
label(data$treatment_start_date)="Treatment Start Date"
label(data$treatment_end_date)="Treatment End Date"
label(data$refeed_start_date)="Refeed Start Date"
label(data$refeed_end_date)="Refeed End Date"
label(data$departure_date)="Departure Date"
label(data$treatment_information_complete)="Complete?"
label(data$date_baseline)="Date"
label(data$treatment_status_baseline)="Treatment Status"
label(data$height)="Height"
label(data$weight)="Weight"
label(data$bmi)="Body Mass Index"
label(data$systolic_blood_pressure)="Systolic Blood Pressure"
label(data$diastolic_blood_pressure)="Diastolic Blood Pressure"
label(data$clinical_complete)="Complete?"
label(data$date_01)="Date"
label(data$group_1_01)="Group 1"
label(data$sample_1_number_01)="Sample #1 Number "
label(data$recognition_taste_g1_01)="What taste is recognizable?"
label(data$group_2_01)="Group 2"
label(data$sample_2_number_01)="Sample #2 Number"
label(data$recognition_taste_g2_01)="What taste is recognizable? "
label(data$group_3_01)="Group 3"
label(data$sample_3_number_01)="Sample #3 Number"
label(data$recognition_taste_g3_01)="What taste is recognizable? "
label(data$group_4_01)="Group 4"
label(data$sample_4_number_01)="Sample #4 Number"
label(data$recognition_taste_g4_01)="What taste is recognizable? "
label(data$group_5_01)="Group 5"
label(data$sample_5_number_01)="Sample #5 Number"
label(data$recognition_taste_g5_01)="What taste is recognizable? "
label(data$group_6_01)="Group 6"
label(data$sample_6_number_01)="Sample #6 Number"
label(data$recognition_taste_g6_01)="What taste is recognizable? "
label(data$group_7_01)="Group 7"
label(data$sample_7_number_01)="Sample #7 Number"
label(data$recognition_taste_g7_01)="What taste is recognizable? "
label(data$group_8_01)="Group 8"
label(data$sample_8_number_01)="Sample #8 Number"
label(data$recognition_taste_g8_01)="What taste is recognizable? "
label(data$group_9_01)="Group 9"
label(data$sample_9_number_01)="Sample #9 NUmber"
label(data$recognition_taste_g9_01)="What taste is recognizable? "
label(data$group_10_01)="Group 10"
label(data$sample_10_number_01)="Sample #10 Number"
label(data$recognition_taste_g10_01)="What taste is recognizable? "
label(data$date_02)="Date"
label(data$group_1_02)="Group 1"
label(data$sample_1_number_02)="Sample #1 Number"
label(data$recognition_taste_g1_02)="What taste is recognizable?"
label(data$group_2_02)="Group 2"
label(data$sample_2_number_02)="Sample #2 Number"
label(data$recognition_taste_g2_02)="What taste is recognizable?"
label(data$group_3_02)="Group 3"
label(data$sample_3_number_02)="Sample #3 Number"
label(data$recognition_taste_g3_02)="What taste is recognizable?"
label(data$group_4_02)="Group 4"
label(data$sample_4_number_02)="Sample #4 Number"
label(data$recognition_taste_04_02)="What taste is recognizable?"
label(data$group_5_02)="Group 5"
label(data$sample_5_number_02)="Sample #5 Number"
label(data$recognition_taste_05_02)="What taste is recognizable?"
label(data$group_6_02)="Group 6"
label(data$sample_6_number_02)="Sample #6 Number"
label(data$recognition_taste_06_02)="What taste is recognizable?"
label(data$group_7_02)="Group 7"
label(data$sample_7_number_02)="Sample #7 Number"
label(data$recognition_taste_07_02)="What taste is recognizable?"
label(data$group_8_02)="Group 8"
label(data$sample_8_number_02)="Sample #8 Number"
label(data$recognition_taste_08_02)="What taste is recognizable?"
label(data$group_9_02)="Group 9"
label(data$sample_9_number_02)="Sample #9 Number"
label(data$recognition_taste_09_02)="What taste is recognizable?"
label(data$group_10_02)="Group 10"
label(data$sample_10_number_02)="Sample #10 Number"
label(data$recognition_taste_10_02)="What taste is recognizable?"
label(data$detection_recognition_assays_complete)="Complete?"
label(data$date_st_01)="Date"
label(data$supra_1_01)="Sample #1   "
label(data$supra_2_01)="Sample #2  "
label(data$supra_3_01)="Sample #3  "
label(data$supra_4_01)="Sample #4   "
label(data$supra_taste_01)="What flavor did you taste?"
label(data$date_st_02)="Date"
label(data$supra_1_02)="Sample #1"
label(data$supra_2_02)="Sample #2"
label(data$supra_3_02)="Sample #3"
label(data$supra_4_02)="Sample #4"
label(data$supra_taste_02)="What flavor did you taste?"
label(data$suprathreshold_assays_complete)="Complete?"
#Setting Units


#Setting Factors(will create new variable for factors)
data$redcap_event_name.factor = factor(data$redcap_event_name,levels=c("pretreatment_arm_1","day_0_arm_1","day_5_arm_1","final_fasting_day_arm_1","refeed_day_3_arm_1","posttreatment_arm_1"))
data$gender_flq.factor = factor(data$gender_flq,levels=c("0","1","2"))
data$diet_flq.factor = factor(data$diet_flq,levels=c("0","1","2","3","4","5"))
data$p1_q1.factor = factor(data$p1_q1,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q2.factor = factor(data$p1_q2,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q3.factor = factor(data$p1_q3,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q4.factor = factor(data$p1_q4,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q5.factor = factor(data$p1_q5,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q6.factor = factor(data$p1_q6,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q7.factor = factor(data$p1_q7,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q8.factor = factor(data$p1_q8,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q9.factor = factor(data$p1_q9,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q10.factor = factor(data$p1_q10,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q11.factor = factor(data$p1_q11,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q12.factor = factor(data$p1_q12,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q13.factor = factor(data$p1_q13,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q14.factor = factor(data$p1_q14,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q15.factor = factor(data$p1_q15,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q16.factor = factor(data$p1_q16,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q17.factor = factor(data$p1_q17,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q18.factor = factor(data$p1_q18,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q19.factor = factor(data$p1_q19,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q20.factor = factor(data$p1_q20,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q22.factor = factor(data$p1_q22,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q21.factor = factor(data$p1_q21,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q23.factor = factor(data$p1_q23,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q24.factor = factor(data$p1_q24,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q25.factor = factor(data$p1_q25,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q26.factor = factor(data$p1_q26,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q27.factor = factor(data$p1_q27,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q28.factor = factor(data$p1_q28,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q29.factor = factor(data$p1_q29,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q30.factor = factor(data$p1_q30,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q31.factor = factor(data$p1_q31,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q32.factor = factor(data$p1_q32,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q33.factor = factor(data$p1_q33,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q34.factor = factor(data$p1_q34,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q35.factor = factor(data$p1_q35,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q36.factor = factor(data$p1_q36,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q37.factor = factor(data$p1_q37,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q38.factor = factor(data$p1_q38,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q39.factor = factor(data$p1_q39,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q40.factor = factor(data$p1_q40,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p1_q41.factor = factor(data$p1_q41,levels=c("0","1","2","3","4","5","6","7","8","9"))
data$p2_example.factor = factor(data$p2_example,levels=c("0","2","3","4","5","6"))
data$p2_q1a.factor = factor(data$p2_q1a,levels=c("0","1","2","3","4","5","6"))
data$p2_q2a.factor = factor(data$p2_q2a,levels=c("0","1","2","3","4","5","6"))
data$p2_q3a.factor = factor(data$p2_q3a,levels=c("0","1","2","3","4","5","6"))
data$p2_q4a.factor = factor(data$p2_q4a,levels=c("0","1","2","3","4","5","6"))
data$p2_q5a.factor = factor(data$p2_q5a,levels=c("0","1","2","3","4","5","6"))
data$p2_q6a.factor = factor(data$p2_q6a,levels=c("0","1","2","3","4","5","6"))
data$p2_q7a.factor = factor(data$p2_q7a,levels=c("0","1","2","3","4","5","6"))
data$p2_q8a.factor = factor(data$p2_q8a,levels=c("0","1","2","3","4","5","6"))
data$p2_q9a.factor = factor(data$p2_q9a,levels=c("0","1","2","3","4","5","6"))
data$p2_q10a.factor = factor(data$p2_q10a,levels=c("0","1","2","3","4","5","6"))
data$p2_q11a.factor = factor(data$p2_q11a,levels=c("0","1","2","3","4","5","6"))
data$p2_q12a.factor = factor(data$p2_q12a,levels=c("0","1","2","3","4","5","6"))
data$p2_q13a.factor = factor(data$p2_q13a,levels=c("0","1","2","3","4","5","6"))
data$p2_q14a.factor = factor(data$p2_q14a,levels=c("0","1","2","3","4","5","6"))
data$p2_q15a.factor = factor(data$p2_q15a,levels=c("0","1","2","3","4","5","6"))
data$p2_q16a.factor = factor(data$p2_q16a,levels=c("0","1","2","3","4","5","6"))
data$p2_q17a.factor = factor(data$p2_q17a,levels=c("0","1","2","3","4","5","6"))
data$p2_q18a.factor = factor(data$p2_q18a,levels=c("0","1","2","3","4","5","6"))
data$p2_q19a.factor = factor(data$p2_q19a,levels=c("0","1","2","3","4","5","6"))
data$p3_q1___0.factor = factor(data$p3_q1___0,levels=c("0","1"))
data$p3_q1___1.factor = factor(data$p3_q1___1,levels=c("0","1"))
data$p3_q1___2.factor = factor(data$p3_q1___2,levels=c("0","1"))
data$p3_q1___3.factor = factor(data$p3_q1___3,levels=c("0","1"))
data$p3_q1___4.factor = factor(data$p3_q1___4,levels=c("0","1"))
data$p3_q1___5.factor = factor(data$p3_q1___5,levels=c("0","1"))
data$p3_q1___6.factor = factor(data$p3_q1___6,levels=c("0","1"))
data$p4_q1.factor = factor(data$p4_q1,levels=c("0","1","2","3","4","5","6","7","8","9","10"))
data$p4_q2.factor = factor(data$p4_q2,levels=c("0","1","2","3","4","5","6","7","8","9","10"))
data$p4_q3.factor = factor(data$p4_q3,levels=c("0","1","2","3","4","5","6","7","8","9","10"))
data$p4_q5.factor = factor(data$p4_q5,levels=c("0","1","2","3","4"))
data$p4_q6.factor = factor(data$p4_q6,levels=c("0","1","2","3","4"))
data$p4_q7.factor = factor(data$p4_q7,levels=c("0","1","2","3","4"))
data$p4_q9.factor = factor(data$p4_q9,levels=c("0","1","2","3","4"))
data$p4_q10.factor = factor(data$p4_q10,levels=c("0","1","2","3","4"))
data$p4_q11.factor = factor(data$p4_q11,levels=c("0","1","2","3","4","5"))
data$p4_q12.factor = factor(data$p4_q12,levels=c("0","1","2","3","4","5"))
data$p4_q13.factor = factor(data$p4_q13,levels=c("0","1","2","3","4","5"))
data$p4_q14.factor = factor(data$p4_q14,levels=c("0","1","2","3","4","5"))
data$p4_q15.factor = factor(data$p4_q15,levels=c("0","1","2","3","4","5"))
data$p4_q16.factor = factor(data$p4_q16,levels=c("0","1","2","3","4","5"))
data$p4_q17.factor = factor(data$p4_q17,levels=c("0","1","2","3","4","5"))
data$p4_q18.factor = factor(data$p4_q18,levels=c("0","1","2","3","4","5"))
data$p4_q19.factor = factor(data$p4_q19,levels=c("0","1","2","3","4","5"))
data$p4_q20.factor = factor(data$p4_q20,levels=c("0","1","2","3","4","5"))
data$p4_q21.factor = factor(data$p4_q21,levels=c("0","1","2","3","4","5"))
data$p4_q22.factor = factor(data$p4_q22,levels=c("0","1","2","3","4","5"))
data$p4_q23.factor = factor(data$p4_q23,levels=c("0","1","2","3","4","5"))
data$p4_q24.factor = factor(data$p4_q24,levels=c("0","1","2","3","4","5"))
data$food_liking_questionnaire_complete.factor = factor(data$food_liking_questionnaire_complete,levels=c("0","1","2"))
data$tnhc_screening.factor = factor(data$tnhc_screening,levels=c("0","1"))
data$has_the_participant_stayed.factor = factor(data$has_the_participant_stayed,levels=c("0","1"))
data$vegan_sos_screening.factor = factor(data$vegan_sos_screening,levels=c("0","1"))
data$diet_screening.factor = factor(data$diet_screening,levels=c("0","1","2","3","4","5"))
data$pregnant_nursing_screening.factor = factor(data$pregnant_nursing_screening,levels=c("0","1"))
data$taste_disorder_screening.factor = factor(data$taste_disorder_screening,levels=c("0","1"))
data$cancer_screening.factor = factor(data$cancer_screening,levels=c("0","1"))
data$bp_screening.factor = factor(data$bp_screening,levels=c("0","1"))
data$glucose_screening.factor = factor(data$glucose_screening,levels=c("0","1"))
data$allergic_screening.factor = factor(data$allergic_screening,levels=c("0","1"))
data$smoker_screening.factor = factor(data$smoker_screening,levels=c("0","1"))
data$do_you_drink_alcohol.factor = factor(data$do_you_drink_alcohol,levels=c("0","1"))
data$alcohol_screening.factor = factor(data$alcohol_screening,levels=c("0","1","2","3"))
data$do_you_use_drugs.factor = factor(data$do_you_use_drugs,levels=c("0","1"))
data$drug_screening.factor = factor(data$drug_screening,levels=c("0","1","2","3"))
data$consent_screening.factor = factor(data$consent_screening,levels=c("0","1"))
data$eligibility_tnh.factor = factor(data$eligibility_tnh,levels=c("1","0"))
data$enrolled_tnh.factor = factor(data$enrolled_tnh,levels=c("1","0"))
data$tnh_participant_screening_eligibility_form_complete.factor = factor(data$tnh_participant_screening_eligibility_form_complete,levels=c("0","1","2"))
data$proceed_hipaa.factor = factor(data$proceed_hipaa,levels=c("1"))
data$agree.factor = factor(data$agree,levels=c("0"))
data$tnh_participant_consent_form_complete.factor = factor(data$tnh_participant_consent_form_complete,levels=c("0","1","2"))
data$gender.factor = factor(data$gender,levels=c("0","1","2","3"))
data$marital_status.factor = factor(data$marital_status,levels=c("0","1","2","3"))
data$demographics_complete.factor = factor(data$demographics_complete,levels=c("0","1","2"))
data$treatment_plan.factor = factor(data$treatment_plan,levels=c("3","4","5","6","7","8","9","10"))
data$treatment_information_complete.factor = factor(data$treatment_information_complete,levels=c("0","1","2"))
data$treatment_status_baseline.factor = factor(data$treatment_status_baseline,levels=c("1","2","3","4","5","6","7"))
data$clinical_complete.factor = factor(data$clinical_complete,levels=c("0","1","2"))
data$group_1_01.factor = factor(data$group_1_01,levels=c("0","1","2"))
data$recognition_taste_g1_01.factor = factor(data$recognition_taste_g1_01,levels=c("1","2","3","4","5","6","7"))
data$group_2_01.factor = factor(data$group_2_01,levels=c("0","1","2"))
data$recognition_taste_g2_01.factor = factor(data$recognition_taste_g2_01,levels=c("1","2","3","4","5","6","7"))
data$group_3_01.factor = factor(data$group_3_01,levels=c("0","1","2"))
data$recognition_taste_g3_01.factor = factor(data$recognition_taste_g3_01,levels=c("1","2","3","4","5","6","7"))
data$group_4_01.factor = factor(data$group_4_01,levels=c("0","1","2"))
data$recognition_taste_g4_01.factor = factor(data$recognition_taste_g4_01,levels=c("1","2","3","4","5","6","7"))
data$group_5_01.factor = factor(data$group_5_01,levels=c("0","1","2"))
data$recognition_taste_g5_01.factor = factor(data$recognition_taste_g5_01,levels=c("1","2","3","4","5","6","7"))
data$group_6_01.factor = factor(data$group_6_01,levels=c("0","1","2"))
data$recognition_taste_g6_01.factor = factor(data$recognition_taste_g6_01,levels=c("1","2","3","4","5","6","7"))
data$group_7_01.factor = factor(data$group_7_01,levels=c("0","1","2"))
data$recognition_taste_g7_01.factor = factor(data$recognition_taste_g7_01,levels=c("1","2","3","4","5","6","7"))
data$group_8_01.factor = factor(data$group_8_01,levels=c("0","1","2"))
data$recognition_taste_g8_01.factor = factor(data$recognition_taste_g8_01,levels=c("1","2","3","4","5","6","7"))
data$group_9_01.factor = factor(data$group_9_01,levels=c("0","1","2"))
data$recognition_taste_g9_01.factor = factor(data$recognition_taste_g9_01,levels=c("1","2","3","4","5","6","7"))
data$group_10_01.factor = factor(data$group_10_01,levels=c("0","1","2"))
data$recognition_taste_g10_01.factor = factor(data$recognition_taste_g10_01,levels=c("1","2","3","4","5","6","7"))
data$group_1_02.factor = factor(data$group_1_02,levels=c("0","1","2"))
data$recognition_taste_g1_02.factor = factor(data$recognition_taste_g1_02,levels=c("1","2","3","4","5","6","7"))
data$group_2_02.factor = factor(data$group_2_02,levels=c("0","1","2"))
data$recognition_taste_g2_02.factor = factor(data$recognition_taste_g2_02,levels=c("1","2","3","4","5","6","7"))
data$group_3_02.factor = factor(data$group_3_02,levels=c("0","1","2"))
data$recognition_taste_g3_02.factor = factor(data$recognition_taste_g3_02,levels=c("1","2","3","4","5","6","7"))
data$group_4_02.factor = factor(data$group_4_02,levels=c("0","1","2"))
data$recognition_taste_04_02.factor = factor(data$recognition_taste_04_02,levels=c("1","2","3","4","5","6","7"))
data$group_5_02.factor = factor(data$group_5_02,levels=c("0","1","2"))
data$recognition_taste_05_02.factor = factor(data$recognition_taste_05_02,levels=c("1","2","3","4","5","6","7"))
data$group_6_02.factor = factor(data$group_6_02,levels=c("0","1","2"))
data$recognition_taste_06_02.factor = factor(data$recognition_taste_06_02,levels=c("1","2","3","4","5","6","7"))
data$group_7_02.factor = factor(data$group_7_02,levels=c("0","1","2"))
data$recognition_taste_07_02.factor = factor(data$recognition_taste_07_02,levels=c("1","2","3","4","5","6","7"))
data$group_8_02.factor = factor(data$group_8_02,levels=c("0","1","2"))
data$recognition_taste_08_02.factor = factor(data$recognition_taste_08_02,levels=c("1","2","3","4","5","6","7"))
data$group_9_02.factor = factor(data$group_9_02,levels=c("0","1","2"))
data$recognition_taste_09_02.factor = factor(data$recognition_taste_09_02,levels=c("1","2","3","4","5","6","7"))
data$group_10_02.factor = factor(data$group_10_02,levels=c("0","1","2"))
data$recognition_taste_10_02.factor = factor(data$recognition_taste_10_02,levels=c("1","2","3","4","5","6","7"))
data$detection_recognition_assays_complete.factor = factor(data$detection_recognition_assays_complete,levels=c("0","1","2"))
data$supra_taste_01.factor = factor(data$supra_taste_01,levels=c("0","1","2","3","4","5"))
data$supra_taste_02.factor = factor(data$supra_taste_02,levels=c("0","1","2","3","4","5"))
data$suprathreshold_assays_complete.factor = factor(data$suprathreshold_assays_complete,levels=c("0","1","2"))

levels(data$redcap_event_name.factor)=c("Pre-treatment","Day 0","Day 5","Final Fasting Day","Refeed Day 3","Post-treatment")
levels(data$gender_flq.factor)=c("Male","Female","Other")
levels(data$diet_flq.factor)=c("Standard American Diet","Vegetarian","Vegan","Exclusively Plant Foods, SOS-Free","Paleo","Other")
levels(data$p1_q1.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q2.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q3.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q4.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q5.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q6.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q7.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q8.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q9.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q10.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q11.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q12.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q13.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q14.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q15.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q16.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q17.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q18.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q19.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q20.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q22.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q21.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q23.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q24.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q25.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q26.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q27.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q28.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q29.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q30.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q31.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q32.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q33.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q34.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q35.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q36.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q37.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q38.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q39.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q40.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p1_q41.factor)=c("Never Tasted","Dislike Extremely","Dislike Very Much","Dislike Moderately","Dislike Slightly","Neither Like nor Dislike","Like Slightly","Like Moderately","Like Very Much","Like Extremely")
levels(data$p2_example.factor)=c("0 None","2","3","4","5 A Lot","Dislike Steak")
levels(data$p2_q1a.factor)=c("0 None","1","2","3","4","5 A Lot","Dislike Boiled Eggs")
levels(data$p2_q2a.factor)=c("0 None","1","2","3","4","5 A Lot","Dislike Corn on the Cob")
levels(data$p2_q3a.factor)=c("0 None","1","2","3","4","5 A Lot","Dislike Deli Meat Sandwiches")
levels(data$p2_q4a.factor)=c("0 None","1","2","3","4","5 A Lot","Dislike Green Beans")
levels(data$p2_q5a.factor)=c("0 None","1","2","3","4","5 A Lot","Dislike Green Beans")
levels(data$p2_q6a.factor)=c("0 None","1","2","3","4","5 A Lot","Dislike Mashed Potatoes")
levels(data$p2_q7a.factor)=c("0 None","1","2","3","4","5 A Lot","Dislike Steaks")
levels(data$p2_q8a.factor)=c("0 None","1","2","3","4","5 A Lot","Dislike Chicken Breasts")
levels(data$p2_q9a.factor)=c("0 None","1","2","3","4","5 A Lot","Dislike Salmon")
levels(data$p2_q10a.factor)=c("0 None","1","2","3","4","5 A Lot","Dislike Cheese Sandwiches")
levels(data$p2_q11a.factor)=c("0 None","1","2","3","4","5 A Lot","Dislike Toast")
levels(data$p2_q12a.factor)=c("0 None","1","2","3","4","5 A Lot","Dislike Toast")
levels(data$p2_q13a.factor)=c("0 None","1","2","3","4","5 A Lot","Dislike Toast")
levels(data$p2_q14a.factor)=c("0 None","1","2","3","4","5 A Lot","Dislike Strawberries")
levels(data$p2_q15a.factor)=c("0 None","1","2","3","4","5 A Lot","Dislike Yogurt")
levels(data$p2_q16a.factor)=c("0 None","1","2","3","4","5 A Lot","Dislike Pancakes")
levels(data$p2_q17a.factor)=c("0 None","1","2","3","4","5 A Lot","Dislike Pancakes")
levels(data$p2_q18a.factor)=c("0 None","1","2","3","4","5 A Lot","Dislike Brownies")
levels(data$p2_q19a.factor)=c("0 None","1","2","3","4","5 A Lot","Dislike Ice Cream")
levels(data$p3_q1___0.factor)=c("Unchecked","Checked")
levels(data$p3_q1___1.factor)=c("Unchecked","Checked")
levels(data$p3_q1___2.factor)=c("Unchecked","Checked")
levels(data$p3_q1___3.factor)=c("Unchecked","Checked")
levels(data$p3_q1___4.factor)=c("Unchecked","Checked")
levels(data$p3_q1___5.factor)=c("Unchecked","Checked")
levels(data$p3_q1___6.factor)=c("Unchecked","Checked")
levels(data$p4_q1.factor)=c("Not At All","","","","","","","","","Very Much","Dislike Bread")
levels(data$p4_q2.factor)=c("Not At All","","","","","","","","","Very Much","Dislike Yogurt")
levels(data$p4_q3.factor)=c("Not At All","","","","","","","","","Very Much","Dislike Hot Drinks")
levels(data$p4_q5.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$p4_q6.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$p4_q7.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$p4_q9.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$p4_q10.factor)=c("Never","Rarely","Sometimes","Often","Always")
levels(data$p4_q11.factor)=c("Never","Rarely","Sometimes","Often","Always","Do Not Cook Pasta")
levels(data$p4_q12.factor)=c("Not Salty","Slightly Salty","Moderately Salty","Rather Salty","Very Salty","Dislike Soup")
levels(data$p4_q13.factor)=c("Without Cream","Small Amount of Cream","Moderate Amount of Cream","Large Amount of Cream","Very Large Amount of Cream","Dislike Soup")
levels(data$p4_q14.factor)=c("Not Salty","Slightly Salty","Moderately Salty","Rather Salty","Very Salty","Dislike Pasta")
levels(data$p4_q15.factor)=c("Without Butter","Small Amount of Butter","Moderate Amount of Butter","Large Amount of Butter","Very Large Amount of Butter","Dislike Pasta")
levels(data$p4_q16.factor)=c("Without Butter","Small Amount of Butter","Moderate Amount of Butter","Large Amount of Butter","Very Large Amount of Butter","Dislike Mashed Potatoes")
levels(data$p4_q17.factor)=c("Not Salty","Slightly Salty","Moderately Salty","Rather Salty","Very Salty","Dislike Fries")
levels(data$p4_q18.factor)=c("Not Salty","Slightly Salty","Moderately Salty","Rather Salty","Very Salty","Dislike Steak")
levels(data$p4_q19.factor)=c("Not Sweet","Slightly Sweet","Moderately Sweet","Rather Sweet","Very Sweet","Dislike Yogurt")
levels(data$p4_q20.factor)=c("Without Cream","Small Amount of Cream","Moderate Amount of Cream","Large Amount of Cream","Very Large Amount of Cream","Dislike Strawberries")
levels(data$p4_q21.factor)=c("Without Syrup","Small Amount of Syrup","Moderate Amount of Syrup","Large Amount of Syrup","Very Large Amount of Syrup","Dislike Pancakes")
levels(data$p4_q22.factor)=c("Without Nutella or Chocolate Spread","Small Amount of Nutella or Chocolate Spread","Moderate Amount of Nutella or Chocolate Spread","Large Amount of Nutella or Chocolate Spread","Very Large Amount of Nutella or Chocolate Spread","Dislike Pancakes")
levels(data$p4_q23.factor)=c("Not Sweet","Slightly Sweet","Moderately Sweet","Rather Sweet","Very Sweet","Dislike Tea")
levels(data$p4_q24.factor)=c("Not Sweet","Slightly Sweet","Moderately Sweet","Rather Sweet","Very Sweet","Dislike Coffee")
levels(data$food_liking_questionnaire_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$tnhc_screening.factor)=c("Yes","No")
levels(data$has_the_participant_stayed.factor)=c("Yes","No")
levels(data$vegan_sos_screening.factor)=c("Yes","No")
levels(data$diet_screening.factor)=c("Standard Omnivorous Diet","Vegetarian","Vegan","Paleo","Whole Foods (no restrictions)","Other")
levels(data$pregnant_nursing_screening.factor)=c("Yes","No")
levels(data$taste_disorder_screening.factor)=c("Yes","No")
levels(data$cancer_screening.factor)=c("Yes","No")
levels(data$bp_screening.factor)=c("Yes","No")
levels(data$glucose_screening.factor)=c("Yes","No")
levels(data$allergic_screening.factor)=c("Yes","No")
levels(data$smoker_screening.factor)=c("Yes","No")
levels(data$do_you_drink_alcohol.factor)=c("Yes","No")
levels(data$alcohol_screening.factor)=c("1-3","4-6","7-10",">10")
levels(data$do_you_use_drugs.factor)=c("Yes","No")
levels(data$drug_screening.factor)=c("1-3","4-6","7-10",">10")
levels(data$consent_screening.factor)=c("Yes","No")
levels(data$eligibility_tnh.factor)=c("Yes","No")
levels(data$enrolled_tnh.factor)=c("Yes","No")
levels(data$tnh_participant_screening_eligibility_form_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$proceed_hipaa.factor)=c("Yes")
levels(data$agree.factor)=c("I have read this consent form and the research study has been explained to me verbally. All my questions have been answered, and I freely and voluntarily choose to take part in this study.")
levels(data$tnh_participant_consent_form_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$gender.factor)=c("Male","Female","Trans","Other")
levels(data$marital_status.factor)=c("Single","Married","Domestic Partnership","Divorced/Separated")
levels(data$demographics_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$treatment_plan.factor)=c("5 days","6 days","7 days","8 days","9 days","10 days","11 days","12 days")
levels(data$treatment_information_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$treatment_status_baseline.factor)=c("Pre-Fast Diet","Water-only Fasting","Refeeding","Post-Fast","TNH Whole Foods Diet","TNH Liquid Diet","No Treatment")
levels(data$clinical_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$group_1_01.factor)=c("A1","A2","A3")
levels(data$recognition_taste_g1_01.factor)=c("Salty","Sweet","Sour","Savory","Bitter","Fatty","None")
levels(data$group_2_01.factor)=c("A4","A5","A6")
levels(data$recognition_taste_g2_01.factor)=c("Salty","Sweet","Sour","Savory","Bitter","Fatty","None")
levels(data$group_3_01.factor)=c("A7","A8","A9")
levels(data$recognition_taste_g3_01.factor)=c("Salty","Sweet","Sour","Savory","Bitter","Fatty","None")
levels(data$group_4_01.factor)=c("A10","A11","A12")
levels(data$recognition_taste_g4_01.factor)=c("Salty","Sweet","Sour","Savory","Bitter","Fatty","None")
levels(data$group_5_01.factor)=c("A13","A14","A15")
levels(data$recognition_taste_g5_01.factor)=c("Salty","Sweet","Sour","Savory","Bitter","Fatty","None")
levels(data$group_6_01.factor)=c("A16","A17","A18")
levels(data$recognition_taste_g6_01.factor)=c("Salty","Sweet","Sour","Savory","Bitter","Fatty","None")
levels(data$group_7_01.factor)=c("A19","A20","A21")
levels(data$recognition_taste_g7_01.factor)=c("Salty","Sweet","Sour","Savory","Bitter","Fatty","None")
levels(data$group_8_01.factor)=c("A22","A23","A24")
levels(data$recognition_taste_g8_01.factor)=c("Salty","Sweet","Sour","Savory","Bitter","Fatty","None")
levels(data$group_9_01.factor)=c("A25","A26","A27")
levels(data$recognition_taste_g9_01.factor)=c("Salty","Sweet","Sour","Savory","Bitter","Fatty","None")
levels(data$group_10_01.factor)=c("A28","A29","A30")
levels(data$recognition_taste_g10_01.factor)=c("Salty","Sweet","Sour","Savory","Bitter","Fatty","None")
levels(data$group_1_02.factor)=c("A1","A2","A3")
levels(data$recognition_taste_g1_02.factor)=c("Salty","Sweet","Sour","Savory","Bitter","Fatty","None")
levels(data$group_2_02.factor)=c("A4","A5","A6")
levels(data$recognition_taste_g2_02.factor)=c("Salty","Sweet","Sour","Savory","Bitter","Fatty","None")
levels(data$group_3_02.factor)=c("A7","A8","A9")
levels(data$recognition_taste_g3_02.factor)=c("Salty","Sweet","Sour","Savory","Bitter","Fatty","None")
levels(data$group_4_02.factor)=c("A10","A11","A12")
levels(data$recognition_taste_04_02.factor)=c("Salty","Sweet","Sour","Savory","Bitter","Fatty","None")
levels(data$group_5_02.factor)=c("A13","A14","A15")
levels(data$recognition_taste_05_02.factor)=c("Salty","Sweet","Sour","Savory","Bitter","Fatty","None")
levels(data$group_6_02.factor)=c("A16","A17","A18")
levels(data$recognition_taste_06_02.factor)=c("Salty","Sweet","Sour","Savory","Bitter","Fatty","None")
levels(data$group_7_02.factor)=c("A19","A20","A21")
levels(data$recognition_taste_07_02.factor)=c("Salty","Sweet","Sour","Savory","Bitter","Fatty","None")
levels(data$group_8_02.factor)=c("A22","A23","A24")
levels(data$recognition_taste_08_02.factor)=c("Salty","Sweet","Sour","Savory","Bitter","Fatty","None")
levels(data$group_9_02.factor)=c("A25","A26","A27")
levels(data$recognition_taste_09_02.factor)=c("Salty","Sweet","Sour","Savory","Bitter","Fatty","None")
levels(data$group_10_02.factor)=c("A28","A29","A30")
levels(data$recognition_taste_10_02.factor)=c("Salty","Sweet","Sour","Savory","Bitter","Fatty","None")
levels(data$detection_recognition_assays_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$supra_taste_01.factor)=c("Salty","Sweet","Bitter","Sour","Umami","Fatty")
levels(data$supra_taste_02.factor)=c("Salty","Sweet","Bitter","Sour","Umami","Fatty")
levels(data$suprathreshold_assays_complete.factor)=c("Incomplete","Unverified","Complete")
