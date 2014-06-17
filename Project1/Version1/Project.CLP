; The rule format for the deffact city is as follows: (distance "the distance in given unit between following two cities" city1 city2)

(deffacts city  (distance 5 orlando tallahassee)  (distance 3  orlando lake-city)  (distance 3  orlando  jacksonville)  (distance 2  orlando  st-augustine)  
(distance 2 orlando  gainesville)  (distance 1 orlando  ocala)  (distance 1 orlando tampa) (distance 3 orlando  ft-myers)  (distance 3 orlando  west-palm)  
(distance 5 orlando miami) (distance 8 orlando key-west) (distance 5 miami orlando) (distance 1 ocala orlando) (distance 3 tampa st-augustine) (distance 3 key-west miami) (distance 3 jacksonville tallahassee)(distance 2 gainesville jacksonville)(distance 3 west-palm st-augustine)(distance 8 key-west st-augustine)(distance 3 gainesville tallahassee) (distance 3 jacksonville orlando)(distance 6 jacksonville miami)(distance 8 ft-myers key-west)(distance 2 west-palm miami)(distance 6 miami ocala)(distance 2 gaineville orlando)(distance 6 tampa tallahassee)(distance 5 miami orlando)(distance 1 ocala orlando)(distance 3 jacksonville tallahassee)(distance 3 tallahassee gainesville)(distance 4 st-augustine tallahassee)(distance 3  west-palm ft-myers)(distance 5 st-augustine ft-myers)(distance 9 jacksonville key-west)(distance 5 miami key-west)(distance 7 miami gainesville)(distance 9 miami tallahassee) (distance 2 tallahassee lake-city)(distance 2 lake-city tallahassee)(distance 12 tallahassee key-west)(distance 8 st-augustine key-west)(distance 4 tampa jacksonville)   
(distance 3 tallahassee gainesville) (distance 4 st-augustine tallahassee) (distance 3 west-palm ft-myers) (distance 4 ocala ft-myers) (distance 9 jacksonville key-west) 
(distance 6 miami ocala) (distance 6 miami gainesville) (distance 9 miami tallahassee) (distance 2 tallahassee lake-city)(distance 2 lake-city tallahassee)  (distance 12 tallahassee key-west) 
(distance 1 st-augustine gainesville) (distance 4 tampa jacksonville) (distance 0 orlando orlando) )  

;The rule format for the deffact truck is as follows: (truck truck-number current-location destination current-action time-arrival total-space-available space-occupied package destination) 

(deffacts truck  (truck  1 orlando none  idle 0 15 0 none none) (truck  2 orlando none  idle 0 5 0 none none) (truck  3 orlando none  idle 0 5 0 none none) 
(truck  4 orlando none  idle 0 10 0 none none) (truck  5 orlando none  idle 0 15 0 none none) (truck  6 orlando none  idle 0 10 0 none none))

;The rule format for the deffact package is as follows: (package package-no depart-city delivery-city size order-arrival-time expected-delivery-time) 

(deffacts package (package 1 orlando jacksonville 4 1 15)  (package 2 gainesville jacksonville  1 1 15) (package 3 west-palm st-augustine 3 4 10) (package 4 key-west st-augustine 4 4 10) 
(package 5 gainesville  tallahassee 9 5 10) (package 6 jacksonville orlando 10 8 18) (package 7 jacksonville miami 5 8 25) (package 8 ft-myers key-west 4 9 20)
(package 9 orlando key-west 4 9 22) (package 10 west-palm miami 2 9 16) (package 11 miami ocala 4 10 20) (package 12 gainesville orlando 7 11 17) 
(package 13 tampa tallahassee 12 12 25) (package 14 miami orlando 5 20 30) (package 15 ocala orlando 7 30 40) (package 16 orlando lake-city 6 40 45) 
(package 17 jacksonville tallahassee 5 65 80) (package 18 tallahassee gainesville 8 80 100) (package 19 st-augustine tallahassee 5 90 110) (package 20 west-palm ft-myers 4 110 120) (package 21 st-augustine ft-myers 7 110 120) (package 22 jacksonville key-west 2 120 150) (package 23 miami key-west 4 150 155) (package 24 miami gainesville 5 150 165) (package 25 miami tallahassee 5 150 170) (package 26 tallahassee lake-city 8 180 200) (package 27 lake-city tallahassee 7 190 200) (package 28 tallahasse key-west 12 200 250) (package 29 st-augustine key-west 3 200 260) (package 30 tampa jacksonville 9 210 240))

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
	(declare(salience 2))
	(clock  ?cur-time)
	?pack11 <- (pack ?pk-no ?d-city ?a-city ?size ?cur-time ?expected-time)	
	(distance ?time orlando ?d-city)
		
	?t <- (truck ?t-no ?cl&orlando ? ?ca&idle ? ?space&:(> ?space ?size) $?)
;	?q <- (running-time ?k ?t-no)
=>
	(retract ?pack11)
;	(assert(running-time =(+ ?k ?time) ?t-no))  
	(assert(truck ?t-no orlando ?d-city going-to-pick-package =(+ ?cur-time ?time) ?space ?size ?pk-no ?a-city)))

(defrule rule-21

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
	;?q <- (running-time ?k ?t-no)	 	

=>
	(retract ?t ?e1)
	;(assert(running-time =(+ ?k ?time) ?t-no))
	(assert (wait-time ?pk-no =(- ?cur-time ?tar)))
	(assert (pick-up ?pk-no ?cur-time)) 
	(assert(truck ?t-no ?d-city ?a-city delivering-package =(+ ?cur-time ?time) ?space ?size ?pk-no ?a-city)))


(defrule rule-4

	(declare(salience 1))	
	(clock  ?cur-time)
	?t <- (truck ?t-no ?d-city ?a-city delivering-package ?cur-time ?space ?size ?pk-no ?a-city)	
	(distance ?time orlando ?a-city)
;	?q <- (running-time ?k ?t-no)		 	

=>
	(retract ?t)
;	(assert(running-time =(+ ?k ?time) ?t-no))
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
		