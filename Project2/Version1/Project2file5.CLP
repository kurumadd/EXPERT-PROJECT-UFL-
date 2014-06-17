;The rule format for the deffact truck is as follows: (truck truck-number current-location destination current-action time-arrival total-space-available space-occupied package destination) 

;The rule format for the deffact package is as follows: (package package-no depart-city delivery-city size order-arrival-time expected-delivery-time) 


; IN THIS THE SCATTERED INITIAL TRUCKS WILL BE ASSIGNED AND SENT TO THE NODES



(defrule clock
(declare(salience -10))
?clock1  <- (clock  ?cur-time)
			     	
=>
  	  (retract  ?clock1)
	  (assert  (clock  =(+ 1 ?cur-time) ) ))




(defrule truck_to_nodes

(declare (salience 1))
(clock 0)
?e1 <- (all_nodes8 ?n1 $?all)
?e2 <- (truck ?t-no ?cl ?d idle ?ta ?sa ?so $?k)
(final_path ?dis ?n1 $?mid ?c1)
(not(final_path ?dis1&:(< ?dis1 ?dis) ?n1 $?mid1 ?c1))
=>
(retract ?e2 ?e1)
(assert(all_nodes8 $?all))
(assert(truck ?t-no ?cl ?n1 transit =(+ ?ta ?dis) ?sa ?so $?k)))


(defrule truck_to_nodes1
(clock 0)
?e1 <- (all_nodes9 ?n1 $?all)
?e3 <- (truck ?t-no1 ?c2 ?d2 idle ?ta2 ?sa2 ?so2 $?k2)
(final_path ?dis2 ?n1 $?mid3 ?c2)
(not(final_path ?dis3&:(< ?dis3 ?dis2) ?n1 $?mid4 ?c2))
=>
(retract ?e1 ?e3)
(assert(all_nodes9 $?all))
(assert(truck ?t-no1 ?c2 ?n1 transit =(+ ?ta2 ?dis2) ?sa2 ?so2 $?k2)))


(defrule truck_reached
(clock ?cur-time)
?e1 <- (truck ?t-no ?cl ?des transit ?time&:(= ?time ?cur-time) $?all)
=>
(retract ?e1)
(assert(truck ?t-no ?des null idle 0 $?all)))

(defrule clock_ret

(declare (salience -9))
?e1 <- (clock ?cur-time)
(not(truck $?c1 transit $?c2))
=>
(retract ?e1))


