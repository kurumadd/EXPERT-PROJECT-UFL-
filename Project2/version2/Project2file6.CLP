;The rule format for the deffact truck is as follows: (truck truck-number current-location destination current-action time-arrival total-space-available space-free package destination) 

;The rule format for the deffact package is as follows: (package package-no depart-city delivery-city size order-arrival-time expected-delivery-time) 

;HERE FIRST THE TRUCKS ARE ASSIGNED TO A PATH THAT IS THERE ARE TWO TYPES OF TRUCKS ONE THAT ROAMS WITHIN THE GROUP IT GOES FROM NODE->CITY1->...->NODE. OBSERVE IT IS A LOOP STARTS AND ENDS AT THE SAME NODE. THIS HAPPENS FOR EACH AND EVERY NODE. NOW THE OTHER FORM IS THAT GOES AROUND AS A LOOP BETWEEN NODES THAT IS NODE1->NODE2->NODE3->NODE1. OBSERVE EVEN THIS GOES AS A LOOP. THIS FILE HAS  THE MAIN SIMULATION OF THE PROGRAM. HERE THERE ARE TWO LOOPS ON IS CALLED INNER LOOP THAT IS FORMED WITHIN A GROUP AND THE OTHER IS OUTER LOOP WHICH IS FORMED BETWEEN NODES.IN THE CODE BELOW IT IS USED AS MENTIONED ABOVE. THE SIMULATION LOGIC IS THAT THE TRUCKS NEVER STOP THEY WILL CONTINUOUSLY GOING AROUND IN THE LOOPS SO BUSY TIME WILL BE 100% FOR ALL TRUCKS IRRESPECTIVE OF NUMBER OF PACKAGES CARRIED. SO, THE TRUCKS MOVE IN THE SAID MANNER AND WHEN IT REACHES EACH AND EVERY CITY IT CHECKS IF THERE IS ANY PACKAGE WAITING IF THERE IS IT TAKES THE PACKAGE AND IF THE DROP OFF LOCATION IS ON THE WAY IT DROPS IT .NOTE: EVEN IF THE DROPOFF LOCATION IS ANYWHERE INSIDE THAT GROUP THIS TRUCK TAKES IT AND DROPS IT THERE OTHERWISE IT IS DROPPED AT THE NODE. EX A PACKAGE NEED TO GO FROM CITY1 TO CITY2 AND SUPPOSE CITY1 IS IN NODE1 AND CITY2 IS IN NODE2 THEN THE PACKAGE IS FIRST TAKEN FROM CITY1 AND DROPPED AT NODE1. THE PACKAGE THEN GOES FROM NODE1 TO NODE2 AND THEN ANOTHER TRUCK PICKS IT AND ULTIMATELY IT GOES FROM NODE2 TO CITY2 AND REACHES THE DESTINATION.ALL THIS IS IMPLEMENTED IN THIS FILE. 


(defrule clock_update
(declare(salience -11))
?clock12  <- (clock1  ?cur-time)
			     	
=>
  	  (retract  ?clock12)
	  (assert  (clock1  =(+ 1 ?cur-time) ) ))

(defrule initialize
(declare (salience 12))
?e1 <- (all_nodes10 ?n $?rem)
=>
(retract ?e1)
(assert(all_nodes10 $?rem))
(assert(store_data ?n))
(assert(store_data1 ?n))
(assert(carry ?n)))

(defrule truck_reset

(clock1 ?cur-time)
?e1 <- (truck ?t-no ?n ?d transit ?cur-time $?r)

=>
(retract ?e1)
(assert(truck ?t-no ?d none idle 0 $?r)))

(defrule trucko_reset

(clock1 ?cur-time)
?e1 <- (trucko ?t-no ?n ?d transit ?cur-time $?r)

=>
(retract ?e1)
(assert(trucko ?t-no ?d none idle 0 $?r)))


(defrule package_pick_intermediate
(clock1 ?cur-time)
(all_nodes7 $?no1 ?n $?no2)
?e1 <- (truck ?t-no ?d ?m idle ?ta ?sa ?so $?mn)
?e2 <- (package ?pk-no ?d ?w ?s&:(<= ?s ?so) ?t&:(<= ?t ?cur-time) ?edt)
?e3 <- (store_data ?n $?k)
(group_path ?du ?n $?rem1 ?d $?rem2)
=>
(retract ?e1 ?e2 ?e3)
(assert(truck ?t-no ?d ?m idle ?ta ?sa =(- ?so ?s)))
(assert(package_pickup ?pk-no ?cur-time))
(assert(store_data ?n ?pk-no ?w $?k))
(assert(package1 ?pk-no ?d ?w ?s ?t ?edt)))

(defrule package_pick_node
(clock1 ?cur-time)
(all_nodes7 $?no1 ?n $?no2)
?e1 <- (truck ?t-no ?n ?m idle ?ta ?sa ?so)
?e2 <- (package ?pk-no ?n ?w ?s&:(<= ?s ?so) ?t&:(<= ?t ?cur-time) ?edt)
?e3 <- (store_data ?n $?k)

=>
(retract ?e1 ?e2 ?e3)
(assert(truck ?t-no ?n ?m idle ?ta ?sa =(- ?so ?s)))
(assert(store_data ?n ?pk-no ?w $?k))
(assert(package1 ?pk-no ?n ?w ?s ?t ?edt)))


(defrule package_deliver_intermediate

(declare (salience 1))
(clock1 ?cur-time)
(all_nodes7 $?no1 ?n $?no2)
(group_path ?du ?n $?rem)
?e1 <- (truck ?t-no ?w&:(member ?w $?rem) ?m idle ?ta ?sa ?so)
?e3 <- (store_data ?n $?k1 ?pk-no ?w $?k2)
?e2 <- (package1 ?pk-no ?d ?w ?s ?t ?edt)
?e5 <- (occu ?t-no $?tii)
=>
(retract ?e1 ?e2 ?e3 ?e5)
(assert(occu ?t-no $?tii ?s))
(assert(truck ?t-no ?w ?m idle ?ta ?sa =(+ ?so ?s)))
(assert(store_data ?n $?k1 $?k2))
(assert(package_delivered ?pk-no ?d ?w ?s ?t ?edt ?cur-time)))

(defrule package_deliver_to_node

(declare (salience 1))
(clock1 ?cur-time)
(all_nodes7 $?no1 ?n $?no2)
(group_path ?du ?n $?rem)
?e1 <- (truck ?t-no ?n ?m idle ?ta ?sa ?so)
?e3 <- (store_data ?n $?k1 ?pk-no ?n $?k2)
?e2 <- (package1 ?pk-no ?d ?n ?s ?t ?edt)
?e4 <- (no_pks ?t-no ?pree)
=>
(retract ?e1 ?e2 ?e3 ?e4)
(assert (no_pks ?t-no =(+ 1 ?pree)))
(assert(truck ?t-no ?n ?m idle ?ta ?sa =(+ ?so ?s)))
(assert(store_data ?n $?k1 $?k2))
(assert(package_delivered ?pk-no ?d ?n ?s ?t ?edt ?cur-time)))


(defrule package_deliver_node
(declare (salience 10))
(clock1 ?cur-time)
(all_nodes7 $?all)

?e1 <- (truck ?t-no ?n&:(member ?n $?all) ?m idle ?ta ?sa ?so)
(group_path ?du ?n $?rem)
?e2 <- (store_data ?n $?k1 ?pk-no ?d&:(not(member ?d $?rem))  $?k2)
?e3 <- (store_data1 ?n $?pre)
=>
(retract ?e1 ?e2 ?e3)
(assert(store_data ?n $?k1 $?k2))
(assert(store_data1 ?n ?pk-no ?d $?pre))
(assert(truck ?t-no ?n ?m idle ?ta ?sa ?sa)))


(defrule inner_loop
(declare (salience -8))
(clock1 ?cur-time)

?e2 <- (group_path ?du ?n ?c1 $?rem)
(final_path ?dis ?n $?mid ?c1)
(not(final_path ?dis1&:(< ?dis1 ?dis) ?n $?mid1 ?c1))
?e3 <- (truck ?t-no ?n ?k idle ?s ?sa ?so)
=>
(retract ?e3)
(assert(truck ?t-no ?n ?c1 transit =(+ ?dis ?cur-time) ?sa ?so)))


(defrule loop_traverse

(clock1 ?cur-time)
?e3 <- (truck ?t-no ?c1 ?c9 idle ?s ?sa ?so)
?e4 <- (group_path ?du ?n $?k1 ?c1 ?c2 $?k2)
(final_path ?dis ?c1 $?mid ?c2)
(not(final_path ?dis1&:(< ?dis1 ?dis) ?c1 $?mid1 ?c2))

=>
(retract ?e3)
(assert(truck ?t-no ?c1 ?c2 transit =(+ ?dis ?cur-time) ?sa ?so)))


(defrule loop_end 

(clock1 ?cur-time)
?e3 <- (truck ?t-no ?c1 ?c9 idle ?s ?sa ?so)
?e4 <- (group_path ?du ?n $?k1 ?c1)
(final_path ?dis ?n $?mid ?c1)
(not(final_path ?dis1&:(< ?dis1 ?dis) ?n $?mid1 ?c1))

=>
(retract ?e3)
(assert(truck ?t-no ?c1 ?n transit =(+ ?dis ?cur-time) ?sa ?so)))




(defrule outer_loop

(declare (salience 9))
(clock1 ?cur-time)
?e2 <- (all_nodes5 ?n1 ?n2 $?n)
?e1 <- (truck ?t-no ?n1 ?k idle ?ta ?sa ?so)
(final_path ?dis ?n1 $?mid ?n2)
(not(final_path ?dis1&:(< ?dis1 ?dis) ?n1 $?mid1 ?n2))

=>
(retract ?e1 ?e2)
(assert(all_nodes5 ?n2 $?n))
(assert(trucko ?t-no ?n1 ?n2 transit =(+ ?dis ?cur-time) ?sa ?so)))

(defrule outer_loop_end

(declare (salience 9))
?e2 <- (all_nodes5 ?n1)
?e1 <- (truck ?t-no ?n1 ?k idle ?ta ?sa ?so)

(all_nodes6 ?n2&~n1 $?n)
(clock1 ?cur-time)
(final_path ?dis ?n1 $?mid ?n2)
(not(final_path ?dis1&:(< ?dis1 ?dis) ?n1 $?mid1 ?n2))

=>
(retract ?e1 ?e2)
(assert(trucko ?t-no ?n1 ?n2 transit =(+ ?dis ?cur-time) ?sa ?so)))


(defrule outer_loop1

(declare (salience -10))
?e1 <- (trucko ?t-no ?n1 ?k idle ?ta ?sa ?so)
?e2 <- (all_nodes6 $?nw ?n1 ?n2 $?n)
(clock1 ?cur-time)
(final_path ?dis ?n1 $?mid ?n2)
(not(final_path ?dis1&:(< ?dis1 ?dis) ?n1 $?mid1 ?n2))

=>
(retract ?e1)

(assert(trucko ?t-no ?n1 ?n2 transit =(+ ?dis ?cur-time) ?sa ?so)))

(defrule outer_loop_end1

(declare (salience -10))
?e1 <- (trucko ?t-no ?n1 ?k idle ?ta ?sa ?so)
?e2 <- (all_nodes6 ?n2 $?nw ?n1)
(clock1 ?cur-time)
(final_path ?dis ?n1 $?mid ?n2)
(not(final_path ?dis1&:(< ?dis1 ?dis) ?n1 $?mid1 ?n2))

=>
(retract ?e1)
(assert(trucko ?t-no ?n1 ?n2 transit =(+ ?dis ?cur-time) ?sa ?so)))

(defrule pack_init

(declare(salience 10))

?e1 <- (trucko ?t-no ?n1 ?d1 idle ?ta ?sa ?so)
?e2 <- (store_data1 ?n1 ?pk-no ?d  $?pk)
(package1 ?pk-no ?m ?d ?si&:(< ?si ?so) ?oa ?edt)
=>
(retract ?e2 ?e1)
(assert(trucko ?t-no ?n1 ?d1 idle ?ta ?sa =(- ?so ?si)))
(assert(store_data1 ?n1 $?pk))
(assert(pack ?t-no ?pk-no ?d)))
 
(defrule package_deliver

(declare(salience 11))
(clock1 ?cur-time)

?e2 <-(trucko ?t-no ?n1 ?n2 idle ?ck ?sa ?so)
(group_path ?du ?n1 $?rem)
?e1 <- (pack ?t-no ?pk-no ?d&n1|:(member ?d $?rem))

(package1 ?pk-no ?m ?d ?s ?oa ?edt)

=>
(retract ?e1 ?e2)
(assert (trucko ?t-no ?n1 ?n2 idle ?ck ?sa =(+ ?so ?s)))
(assert (package ?pk-no ?n1 ?d ?s ?cur-time ?edt)))


(defrule package_deliver1

(declare(salience 12))
(clock1 ?cur-time)

?e2 <-(trucko ?t-no ?n1 ?n2 idle ?ck ?sa ?so)
?e1 <- (pack ?t-no ?pk-no ?n1)
?e3 <- (no_pks ?t-no ?pree)
?e4 <- (occu ?t-no $?tii)
(package1 ?pk-no ?m ?n1 ?s ?oa ?edt)

=>

(retract ?e1 ?e2 ?e4)
(assert (no_pks ?t-no =(+ 1 ?pree)))
(assert(occu ?t-no $?tii ?s))
(assert (trucko ?t-no ?n1 ?n2 idle ?ck ?sa =(+ ?so ?s)))
(assert (package_delivered ?pk-no ?m ?n1 ?s ?oa ?edt ?cur-time)))


(defrule halt
(declare (salience 100))
?e2 <- (clock1 ?cur-time&:(> ?cur-time 301))
=>
(retract ?e2))


