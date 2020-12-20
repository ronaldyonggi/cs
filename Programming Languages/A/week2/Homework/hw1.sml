(* Created by: Ronald Yonggi *)

(* Problem 1 *)
(* Takes in 2 dates, return true if the first date is older, otherwise false *)
(* Output: Boolean *)
fun is_older (date1: int*int*int, date2: int*int*int) =
    let
	(* Compare only the year *)
	val compareYear = (#1 date1) < (#1 date2)
	(* If the years are equal , compare the month *)
	val compareMonth = (#1 date1) = (#1 date2) andalso (#2 date1) < (#2 date2)
	(* if both the year and the month are equal, compare the day *)
	val compareDay = (#1 date1) = (#1 date2) andalso (#2 date1) = (#2 date2) andalso (#3 date1) < (#3 date2)
    in
	compareYear orelse compareMonth orelse compareDay
    end;

(* Problem 2 *)
(* Takes in a list of dates and a month, returns total number of dates that have that month *)
(* Output: int *)
fun number_in_month (dates: (int * int * int) list, month: int) =
    if null dates
    then 0
    else if #2 (hd dates) = month
    then 1 + number_in_month (tl dates, month)
    else 0 + number_in_month (tl dates, month) ;

(* Problem 3 *)
(* Similar to previous function but here takes in a list of months *)
(* Output: int *)
fun number_in_months (dates: (int * int *int) list, months: int list) =
    if null months
    then 0
    else number_in_month(dates, hd months) + number_in_months(dates, tl months) ;

(* Problem 4 *)
(* Similar to Problem 2 but this time returns a list containing dates that match the month *)
(* Output: (int * int * int) list *)
fun dates_in_month (dates: (int * int * int) list, month: int) = 
    if null dates
    then []
    else if #2 (hd dates) = month
    then hd dates :: dates_in_month (tl dates, month)
    else dates_in_month(tl dates, month) ;

(* Problem 5 *)
(* Basically Problem 4 with input list of months *)
(* Output: (int*int*int) list *)
fun dates_in_months (dates: (int * int * int) list, months: int list) =
    if null months
    then []
    else dates_in_month (dates, hd months) @ dates_in_months (dates, tl months) ;

(* Problem 6 *)
(* Takes a list of string and n, returns the nth element. The first element of the string is at n = 1. Assume n>0 and list has enough elements. *)
(* Output: string *)
fun get_nth (strings: string list, n: int) =
    if n = 1
    then hd strings
    else get_nth (tl strings, n - 1);

(* Inititate monthString in global scope. Will be used for Problem 7 and 9 *)
val monthsStrings = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
val daysInMonths = [31,28,31,30,31,30,31,31,30,31,30,31];
                 
(* Problem 7 *)
(* Takes in a tuple of date and return a nice formatted string such as "January 20, 2013" *)
(* Output: string *)
fun date_to_string (date: int * int * int) = 
    let
	val stringMonth = get_nth(monthsStrings, #2 date)
	val stringYear = Int.toString(#1 date)
	val stringDay = Int.toString(#3 date)
    in
	stringMonth ^ " " ^ stringDay ^ ", " ^ stringYear
    end ;
			 
(* Problem 8 *)
(* Assume the total sum of numbers is greater than the 
provided argument 'sum'*)   
(* Output: int *)
fun number_before_reaching_sum (sum: int, numbers: int list) = 
    if sum - hd numbers <= 0
    then 0
    else 1 + number_before_reaching_sum(sum - hd numbers, tl numbers) ;
	
(* Problem 9 *)
(* Takes in the day in a year and returns the month that correspond to that day.*)
(* Output: int *)
fun what_month (day:int) =
    number_before_reaching_sum(day, daysInMonths) + 1 ;

(* Problem 10 *)
(* Takes in 2 input of days in a year and return a list containing the integer month between the 2 days *)
(* Output: int list *)
fun month_range(day1: int, day2: int) =
    if day1 >= day2
    then []
    else if day1 = day2
    then (what_month day2)::[]
    else (what_month day1)::month_range(day1 + 1, day2) ;
		  
        
(* Problem 11 *)
(* Takes in a list of dates and return SOME of the oldest date. If the list is empty, returns NONE *)
(* Output: (int * int * int) option *)
fun oldest(dates: (int*int*int) list) = 
    if null dates
    then NONE
    else let
        (* At this point, the list must NOT be empty. The helper function is created
        so that we don't need to check whether the list is empty in the beginning anymore. *)
        fun helper(dates: (int * int * int) list) =
            if null (tl dates)
            then hd dates
            else let
                val next = helper (tl dates)
            in
                if is_older(hd dates, next)
                then hd dates
                else next
            end
    in
        SOME (helper(dates))
    end;

(* Problem 12 *)

fun remove_int (l: int list, x: int) =
    if null l
    then []
    else if (hd l) = x
    then remove_int (tl l, x)
    else (hd l) :: remove_int (tl l, x) ;

fun remove_duplicates (l: int list) =
    if (null l) orelse null (tl l)
    then l
    else (hd l) :: remove_duplicates (remove_int ((tl l), hd l));

fun number_in_months_challenge (dates: (int * int * int) list, months: int list) =
    number_in_months (dates, remove_duplicates months) ;

fun dates_in_months_challenge (dates: (int * int * int) list, months: int list) =
    dates_in_months (dates, remove_duplicates months);

(* Problem 13 *)
fun reasonable_date (date: (int * int * int)) = 
    let
	val year = #1 date ;
	val month = #2 date ;
	val day = #3 date ;
		
	fun leap_year (year: int) =
	    ((year mod 4) = 0 andalso (year mod 100 <> 0)) orelse (year mod 400 = 0) ;

	fun get_days (month: int) =
	    let
		fun get_nth_int (l: int list, i: int) =
		    if i = 1
		    then hd l
		    else get_nth_int (tl l, i - 1) ;
	    in
		get_nth_int (daysInMonths, month)
	    end;

	val valid_year = year > 0
	val is_leap_feb = (leap_year year) andalso month = 2
	val valid_month = (month > 0) andalso (month < 13) ;
	(* Anticipate that if month is not valid, then we can't
	   call get_days with that month *)
	val valid_days = if is_leap_feb
			 then (day > 0) andalso (day < 30)
			 else if valid_month
			 then (day > 0) andalso (day <= get_days month)
						    else false
    in
	valid_year andalso valid_month andalso valid_days
    end;







		       
	    
	
		      
    
		    




