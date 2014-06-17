; The rule format for the deffact city is as follows: (distance "the distance in given unit between following two cities" city1 city2)

(deffacts city  (distance 5 orlando tallahassee)  (distance 3  orlando lake-city)  (distance 3  orlando  jacksonville)  (distance 2  orlando  st-augustine)  
(distance 2 orlando  gainesville)  (distance 1 orlando  ocala)  (distance 1 orlando tampa) (distance 3 orlando  ft-myers)  (distance 3 orlando  west-palm)  
(distance 5 orlando miami) (distance 8 orlando key-west) (distance 5 miami orlando) (distance 1 ocala orlando) (distance 3 tampa st-augustine) (distance 3 key-west miami) (distance 3 jacksonville tallahassee) (distance 2 gainesville jacksonville)(distance 5 st-augustine ft-myers)(distance 9 jacksonville key-west)(distance 3 west-palm st-augustine)(distance 8 key-west st-augustine)(distance 3 gainesville tallahassee)(ditsnace 6 miami gainesville)(distance 9 miami tallahassee)(distance 3 jacksonville orlando)(distance 6 jacksonville miami)(distance 8 ft-myers key-west)(distance 2 west-palm miami)(distance 6 miami ocala)(distance 2 gainesville orlando)(distance 6 tampa tallahassee)(distance 5 st-augustine ft-myers)(distance 3 gainesville tallahassee)(distance 3 west-palm st-augustine)(distance 8 key-west st-augustine)(distance 9 jacksonville key-west)(distance 3 jacksonville tallahassee)(distance 3 talahassee gainesville) (distance 5 st-augustine ft-myers)(distance 9 jacksonville key-west)(distance 1 ocala orlando)(distance 5 miami orlando)(distance 3 west-palm ft-myers)(distance 6 miami gainesville)(distance 6 tampa tallahassee)(distance 3 miami key-west)(distance 5 st-augustine ft-myers)(distance 6 miami ocala)(distance 2 gainesville orlando)(distance 4 st-augustine tallahassee) (distance 9 miami tallahassee)(distance 2 tallahassee lake-city)(distance 2 lake-city tallahassee)(distance 12 tallahassee key-west)(distance 8 st-augustine key-west)(distance 4 tampa jacksonville)(distance 8 ft-myers key-west)(distance 5 miami orlando)(distance 8 key-west st-augustine)(distance 2 tallahassee lake-city)(distance 3 west-palm ft-myers)(distance 6 tampa tallahassee)
(distance 3 tallahassee gainesville) (distance 4 st-augustine tallahassee) (distance 3 west-palm ft-myers) (distance 4 ocala ft-myers) (distance 9 jacksonville key-west) 
(distance 6 miami ocala) (distance 6 miami gainesville) (distance 9 miami tallahassee) (distance 2 tallahassee lake-city)(distance 2 lake-city tallahassee)  (distance 12 tallahassee key-west) 
(distance 1 st-augustine gainesville) (distance 4 tampa jacksonville) (distance 0 orlando orlando) )  

;The rule format for the deffact truck is as follows: (truck truck-number current-location destination current-action time-arrival total-space-available space-occupied package destination) 

(deffacts truck  (truck  1 orlando none  idle 0 5 0 none none) (truck  2 orlando none  idle 0 5 0 none none) (truck  3 orlando none  idle 0 10 0 none none) 
(truck  4 orlando none  idle 0 10 0 none none) (truck  5 orlando none  idle 0 15 0 none none) (truck  6 orlando none  idle 0 15 0 none none)(truck  6 orlando none  idle 0 20 0 none none))

;The rule format for the deffact package is as follows: (package package-no depart-city delivery-city size order-arrival-time expected-delivery-time) 

(deffacts package (package 1 orlando jacksonville 12 100 120)  (package 2 gainesville jacksonville  4 100 120) (package 3 st-augustine ft-myers 12 95 117) (package 4 jacksonville key-west 5 95 110) 
(package 5 west-palm  st-augustine 14 94 100) (package 6 key-west st-augustine 5 94 105) (package 7 gainesville tallahassee 10 90 100) (package 8 miami gainesville 6 87 110)
(package 9 miami tallahassee 13 78 95) (package 10 jacksonville orlando 4 78 85) (package 11 jacksonville miami 17 77 85) (package 12 ft-myers key-west 5 75 90) 
(package 13 orlando key-west 9 75 85) (package 14 west-palm miami 12 70 80) (package 15 miami ocala 3 70 80) (package 16 gainesville orlando 1 65 75) 
(package 17 tampa tallahassee 13 62 75) (package 18 st-augustine ft-myers 14 60 75) (package 19 gainesville tallahassee 12 60 70) (package 20 west-palm st-augustine 5 55 67)  (package 21 key-west st-augustine 3 55 67)  (package 22 jacksonville key-west  11 55 75) (package 23 jacksonville tallahassee 3 50 57) (package 24 tallahassee gainesville 4 50 60) 
(package 25 st-augustine ft-myers 5 45 58) (package 26 jacksonville key-west 11 40 55) (package 27 ocala orlando 4 40 50) (package 28 miami orlando 15 37 47)
(package 29 west-palm ft-myers 4 35 43) (package 30 orlando lake-city 15 35 40) (package 31 miami gainesville 3 30 45) (package 32 tampa tallahassee 12 25 40) 
(package 33 miami key-west 4 20 25) (package 34 st-augustine ft-myers 14 17 74) (package 35 miami ocala 5 16 30) (package 36 gainesville orlando 2 15 23) 
(package 37 st-augustine tallahassee 18 15 31) (package 38 miami tallahassee 7 15 30) (package 39 tallahassee lake-city 15 13 18) (package 40 lake-city tallahassee 3 12 19) (package 41 tallahassee key-west 14 10 32) (package 42 st-augustine key-west 6 9 25) 
(package 43 tampa jacksonville 14 7 17) (package 44 ft-myers key-west 6 6 15) (package 45 miami orlando 8 5 15) (package 46 key-west st-augustine 15 5 10) 
(package 47 tallahassee lake-city 5 4 9) (package 48 west-palm ft-myers 5 3 18) (package 49 tampa tallahassee 3 2 4) (package 50 orlando key-west 5 1 5))

(deffacts clock (clock 0)  (ol-clo 0) (running-time 0 1)(running-time 0 2)(running-time 0 3)(running-time 0 4)(running-time 0 5)(running-time 0 6)(late-count 0)(early-count 0) (total-wait 0) (total-late 0)(count) )

;(defrule  update-clock1

;	(declare(salience -100))
;	?clock1  <- (clock  ?cur-time)	
;	(truck ? ? ? ?ca&~idle ?time&:(> ?time ?cur-time) $?)   
;	(pack $?)	
			     	
;=>
;  	  (retract  ?clock1)
;	  (assert  (clock  ?time ) ))

;(defrule  update-clock2

;	(declare(salience -1))
;	?clock1  <- (clock  ?cur-time)	
;	(truck ? ? ? ?ca&~idle ?time&:(> ?time ?cur-time) $?)   
;	(package  ? ? ? ? ?arrival-time ?)
 ; 	   (not  (package  ? ? ? ? ?arrival-time2&:(< ?arrival-time2 ?arrival-time) ?) )	
			     	
;=>
;  	  (retract  ?clock1)
;	  (assert  (clock  (min ?arrival-time ?time) ) ))

;(defrule  update-clock3
;
;	(declare(salience -10))

;	?clock1  <- (clock  ?cur-time)
 	
;	   (package  ? ? ? ? ?arrival-time ?)
 ; 	   (not  (package  ? ? ? ? ?arrival-time2&:(< ?arrival-time2 ?arrival-time) ?) )	
			     	
;=>
;  	  (retract  ?clock1)
;	  (assert  (clock  ?arrival-time) ) )

(defrule update-clock
(declare(salience -10000))
?clock1 <- (clock ?time)
=>
(retract ?clock1)
(assert(clock =(+ 1 ?time))))

(defrule rule-1
	
	(clock  ?cur-time)
	?pack11 <- (package ?pk-no ?d-city ?a-city ?size ?cur-time ?expected-time)
	
=>

	(retract ?pack11)
	(assert (edt ?pk-no ?expected-time))
	(assert(arrive ?pk-no ?cur-time))
	(assert(pack ?pk-no ?d-city ?a-city ?size ?cur-time ?expected-time))) 

(defrule rule-2
	(declare(salience 1))
	(clock  ?cur-time)
	?pack11 <- (pack ?pk-no ?d-city ?a-city ?size ?cur-time ?expected-time)	
	(distance ?time orlando ?d-city)
		
	?t <- (truck ?t-no ?cl&orlando ? ?ca&idle ? ?space&:(> ?space ?size) $?)
	?q <- (running-time ?k ?t-no)
=>
	(retract ?t ?pack11 ?q)
	(assert(running-time =(+ ?k ?time) ?t-no))  
	(assert(truck ?t-no orlando ?d-city going-to-pick-package =(+ ?cur-time ?time) ?space ?size ?pk-no ?a-city)))

(defrule rule-21
	(declare(salience 1))
	(clock  ?cur-time)
	
	?pack11 <- (pack ?pk-no ?d-city ?a-city ?size ?cur-time ?expected-time)	
	(distance ?time orlando ?d-city)
	
;	?t <- (truck ?t-no ?cl&orlando ? ?ca&~idle ? ?space&:(> ?space ?size) $?)
	
=>
	(retract ?pack11)
	(assert(pack ?pk-no ?d-city ?a-city ?size (+ ?cur-time 1) ?expected-time)))

(defrule rule-3
	
	(declare(salience 1))
	(clock  ?cur-time)
	?t <- (truck ?t-no ?city&orlando ?d-city going-to-pick-package ?cur-time ?space ?size ?pk-no ?a-city)
	?e1 <- (arrive ?pk-no ?tar)
	(distance ?time ?d-city ?a-city)
	?q <- (running-time ?k ?t-no)	 	

=>
	(retract ?t ?q ?e1)
	(assert(running-time =(+ ?k ?time) ?t-no))
	(assert (wait-time ?pk-no =(- ?cur-time ?tar)))
	(assert (pick-up ?pk-no ?cur-time)) 
	(assert(truck ?t-no ?d-city ?a-city delivering-package =(+ ?cur-time ?time) ?space ?size ?pk-no ?a-city)))


(defrule rule-4

	(declare(salience 1))	
	(clock  ?cur-time)
	?t <- (truck ?t-no ?d-city ?a-city delivering-package ?cur-time ?space ?size ?pk-no ?a-city)	
	(distance ?time orlando ?a-city)
	?q <- (running-time ?k ?t-no)		 	

=>
	(retract ?t ?q)
	(assert(running-time =(+ ?k ?time) ?t-no))
	(assert(package_delivered ?pk-no ?cur-time))
	(assert(truck ?t-no ?a-city orlando returning-to-base =(+ ?cur-time ?time) ?space 0 none none)))


(defrule rule-5

	(declare(salience 1))
	(clock  ?cur-time)
	?t <- (truck ?t-no ?d-city orlando returning-to-base ?cur-time ?space ?size ?pk-no ?a-city)	
	

=>
	(retract ?t)
	(assert(truck ?t-no orlando none idle 0 ?space 0 none none)))


(defrule halt
(declare (salience 100))
(clock ?cur-time&:(> ?cur-time 301))
=>
(halt))
		