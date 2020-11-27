use "hw1.sml";

(* Problem 1 Test *)
val d1 = (2019, 10, 13)
val d2 = (2019, 9, 13) (* same year as d1 but older month *)
val d3 = (2019, 10, 12) (* same year and month as d1, but older day *)
val d4 = (2019, 11, 3) (* same year as d1, later month, earlier day *)
val d5 = (2020, 8, 2) (* later year than d1, older month and day *)
val dList = [d1, d2, d3, d4, d5]

val P1T1 = is_older(d2, d1) = true
val P1T2 = is_older(d1, d2) = false
val P1T3 = is_older(d3, d1) = true
val P1T4 = is_older(d4, d1) = false
val P1T5 = is_older(d5, d1) = false

(* Problem 2 Test *)
val P2T1 = number_in_month(dList, 10) = 2
val P2T2 = number_in_month(dList, 3) = 0

(* Problem 3 Test *)
val P3T1 = number_in_months(dList, [10, 11]) = 3
val P3T2 = number_in_months(dList, [1, 2]) = 0
						  
(* Problem 4 Test *)
val P4T1 = dates_in_month(dList, 10) = [d1, d3]
val P4T2 = dates_in_month(dList, 1) = []

(* Problem 5 Test *)
val P5T1 = dates_in_months(dList, [10, 11]) = [d1, d3, d4]
val P5T2 = dates_in_months(dList, [11, 10]) = [d4, d1, d3]
val P5T3 = dates_in_months(dList, [1, 2]) = []

(* Problem 6 Test *)
val P6T1 = get_nth (["a", "b", "c"], 1) = "a"
val P6T2 = get_nth (["a", "b", "c"], 3) = "c"

(* Problem 7 Test *)
val P7T1 = date_to_string(d1) = "October 13, 2019"
val P7T2 = date_to_string(d5) = "August 2, 2020"

(* Problem 8 Test *)
val P8T1 = number_before_reaching_sum(4, [3, 7, 5]) = 1
val P8T2 = number_before_reaching_sum(16, [3, 7, 5, 4]) = 3
val P8T3 = number_before_reaching_sum(30, daysInMonths) = 0 (*  January *)
val P8T4 = number_before_reaching_sum(31, daysInMonths) = 0 (* Still January *)
val P8T5 = number_before_reaching_sum(32, daysInMonths) = 1 (* February *)
val P8T6 = number_before_reaching_sum(59, daysInMonths) = 1 (* Still February *)
val P8T7 = number_before_reaching_sum(60, daysInMonths) = 2 (* March *)

(* Problem 9 *)
val P9T1 = what_month(31) = 1
val P9T2 = what_month(32) = 2
val P9T3 = what_month(364) = 12

(* Problem 10 *)
val P10T1 = month_range(30, 364) = [1,2,3,4,5,6,7,8,9,10,11,12] (* January through December *)
val P10T2 = month_range(23, 43) = [1, 2] (* January and February *)
val P10T3 = month_range(63, 65) = [3] (* Only March *)

(* Problem 11 *)
val P11T1 = oldest([d1, d2, d3, d4, d5]) = SOME d2
val P11T2 = oldest([d1, d3, d4]) = SOME d3 
val P11T3 = oldest([]) = NONE
