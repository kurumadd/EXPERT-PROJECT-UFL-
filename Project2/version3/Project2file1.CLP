;The rule format of city is (city city1 city2 distance_between_them)

(deffacts city (city tallahassee lake-city 2) (city lake-city jacksonville 1) (city lake-city gainesville 1) (city gainesville st-augustine 1) 
(city st-augustine jacksonville 1)(city gainesville ocala 1) (city ocala orlando 1) (city orlando st-augustine 2) (city orlando tampa 1) (city ocala tampa 2) (city tampa ft-myers 2) (city orlando west-palm 3) 
(city west-palm st-augustine 3) (city west-palm ft-myers 3) (city west-palm miami 2) (city miami key-west 3))
(deffacts sum (sum 0) (count1 ) (no_truck 3) (node_final ) (all_nodes) (count2)(all_nodes1)(all_nodes2)(group) (clock 0) (clock1 0)(store_data) (store_data1) (carry)(wait-time 1 0)(wait-time 2 0)(wait-time 3 0)(wait-time 4 0)(wait-time 5 0)(wait-time 6 0)(busy-time 1 0)(busy-time 2 0)(busy-time 3 0)(busy-time 4 0)(busy-time 5 0)(busy-time 6 0)(no_pks 1 0)(no_pks 2 0)(no_pks 3 0)(no_pks 4 0)(no_pks 5 0)(no_pks 6 0)(occu 1)(occu 2)(occu 3 )(occu 4 )(occu 5 )(occu 6)(countoccu 1 0)(countoccu 2 0)(countoccu 3 0)(countoccu 4 0)(countoccu 5 0)(countoccu 6 0)(sumoccu 1 0)(sumoccu 2 0)(sumoccu 3 0)(sumoccu 4 0)(sumoccu 5 0)(sumoccu 6 0)(sum_coun 0)(coun_on 0)(coun_l 0)(lates 0))

;The rule format for the deffact truck is as follows: (truck truck-number current-location destination current-action time-arrival total-space-available space-occupied package destination) 

(deffacts truck  (truck  1 orlando none  idle 0 5 5) (truck  2 orlando none  idle 0 5 5 ) (truck  3 orlando none  idle 0 10 10 ) 
(truck  4 orlando none  idle 0 10 10) (truck  5 orlando none  idle 0 15 15 ) (truck  6 orlando none  idle 0 15 15 ) (truck  7 orlando none  idle 0 20 20 )(coun_wait 0))

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

;In this project the methodology applied is that the map is divided into sub maps that is depending on the number of trucks number of nodes are decided this is decided by counting the cities with maximum number of branches then based on the nodes the cities near it are put into its group and therefore the given graph is subdivided into different graphs based on the nodes.One truck goes around all the nodes in its group and after this assignment all the remaining trucks go around in loop. So the logic is that packages from cities are brought and left at the nodes and these are sent to other nodes and if the city to which package must be delivered is in one of the set then package is taken and left at the node.here again another truck collects it and takes it to final destination.

;Calculate number of cities in the given map..
(defrule no_of_cities
?a <- (city ?c1 ?c2 ?distance)
?k <- (count $?m1 ?c1 $?m2 ?c2 $?m3)	
=>
(retract ?a ?k)
(assert (city1 ?c1 ?c2 ?distance))
(assert (count $?m1 ?c1 $?m2 ?c2 $?m3) )
)
(defrule no_of_cities0
?a <- (city ?c1 ?c2 ?distance)
?k <- (count $?m1 ?c2 $?m2 ?c1 $?m3)	
=>
(retract ?a ?k)
(assert (city1 ?c1 ?c2 ?distance)) 
(assert (count $?m1 ?c1 $?m2 ?c2 $?m3))
)
(defrule no_of_cities1
(declare( salience -2))
?a <- (city ?c1 ?c2 ?distance)
?k <- (count $?m1 ?c1 $?m2)	
=>
(retract ?a ?k)
(assert (city1 ?c1 ?c2 ?distance)) 
(assert  ( count ?c2 ?c1 $?m1 $?m2)))

(defrule no_of_cities2
(declare( salience -2))
?a <- (city ?c1 ?c2 ?distance)
?k <- (count $?m1 ?c2 $?m2)	
=>
(retract ?a ?k)
(assert (city1 ?c1 ?c2 ?distance))
(assert  ( count ?c1 ?c2 $?m1 $?m2))) 


(defrule no_of_cities3
(declare( salience -3))
?a <- (city ?c1 ?c2 ?distance)	
?k <- (count $?m)
=>
(retract ?a ?k)
(assert (city1 ?c1 ?c2 ?distance))
(assert  ( count ?c1 ?c2 $?m))) 


(defrule no_of_cities4
(declare( salience -10))
?a <- (city ?c1 ?c2 ?distance)	
=>
(retract ?a)
(assert (city1 ?c1 ?c2 ?distance))
(assert  ( count ?c1 ?c2)))

;NOW COUNT THE NUMBER OF BRANCHES THAT EACH CITY HAS THE CITIES WITH MAXIMUM BRANCHES ARE TAKEN AS NODES

(defrule count
(declare (salience -11))
?r <- (count ?k $?j)
?m <- (sum ?n)
?h <- (count1 $?t)
=>
(retract ?r ?m ?h)
(assert (sum =(+ ?n 1)))
(assert (count $?j))
(assert (count1 ?k $?t) )) 

(defrule truck
(declare (salience -14))
?l <- (sum ?n)
=>
( retract ?l)
(assert (sum1 =(/ ?n 3))))


(defrule assign1
(declare (salience -12))
?n <- (count1  $?a ?k $?b)
?o <- (city1  ?k ?l ?d)
?z <- (countc ?l ?x)
=>
(retract ?n ?o ?z)
(assert (countc ?k 1))
(assert (countc ?l =(+ ?x 1)))
(assert (city2 ?k ?l ?d))
(assert (count1 $?a ?k $?b)))

(defrule assign2
(declare (salience -13))
?n <- (count1  $?a ?k $?b)
?o <- (city1  ?k ?l ?d)
=>
(retract ?n ?o)
(assert (countc ?k 1))
(assert (countc ?l 1))
(assert (city2 ?k ?l ?d))
(assert (count1 $?a ?k $?b)))

(defrule assign3
(declare (salience -12))
?n <- (count1  $?a ?k $?b)
?o <- (city1  ?k ?l ?d)
?z <- (countc ?k ?x)
=>
(retract ?n ?o ?z)
(assert (countc ?l 1))
(assert (countc ?k =(+ ?x 1)))
(assert (city2 ?k ?l ?d))
(assert (count1 $?a ?k $?b)))

(defrule assign4
(declare (salience -11))
?n <- (count1  $?a ?k $?b)
?o <- (city1  ?k ?l ?d)
?z <- (countc ?l ?x)
?j <- (countc ?k ?p)
=>
(retract ?n ?o ?z ?j)
(assert (countc ?k =(+ ?p 1)))
(assert (countc ?l =(+ ?x 1)))
(assert (city2 ?k ?l ?d))
(assert (count1 $?a ?k $?b)))


(defrule assign11
(declare (salience -12))
?n <- (count1  $?a ?k $?b)
?o <- (city1  ?l ?k ?d)
?z <- (countc ?l ?x)
=>
(retract ?n ?o ?z)
(assert (countc ?k 1))
(assert (countc ?l =(+ ?x 1)))
(assert (city2 ?l ?k ?d))
(assert (count1 $?a ?k $?b)))

(defrule assign22
(declare (salience -13))
?n <- (count1  $?a ?k $?b)
?o <- (city1  ?l ?k ?d)
=>
(retract ?n ?o)
(assert (countc ?k 1))
(assert (countc ?l 1))
(assert (city2 ?l ?k ?d))
(assert (count1 $?a ?k $?b)))

(defrule assign33
(declare (salience -12))
?n <- (count1  $?a ?k $?b)
?o <- (city1  ?l ?k ?d)
?z <- (countc ?k ?x)
=>
(retract ?n ?o ?z)
(assert (countc ?l 1))
(assert (countc ?k =(+ ?x 1)))
(assert (city2 ?l ?k ?d))
(assert (count1 $?a ?k $?b)))

(defrule assign44
(declare (salience -11))
?n <- (count1  $?a ?k $?b)
?o <- (city1  ?l ?k ?d)
?z <- (countc ?l ?x)
?j <- (countc ?k ?p)
=>
(retract ?n ?o ?z ?j)
(assert (countc ?k =(+ ?p 1)))
(assert (countc ?l =(+ ?x 1)))
(assert (city2 ?l ?k ?d))
(assert (count1 $?a ?k $?b)))

;FIND NUMBER OF TRUCKS AS THIS LIMITS THE NUMBER OF NODES

(defrule no_of_trucks

(truck ?n $?all)
(not(truck ?n1&:(> ?n1 ?n) $?all1))

=>
(assert (check =(/ ?n 2))))

;HERE FACT COUNTC HAS THE NUMBER OF NODES FOR EACH CITY.THE MAXIMUM POSSIBLE ARE SELECTED AS NODES

(defrule max
(declare ( salience -20))
?a <- (no_truck ?n&~0)
?w <- (sum1 ?q)
?ch <- (check ?z&:(> ?z 0))
?v <- (all_nodes $?all)
?b <- (countc  ?m ?r)	
	(not(countc ? ?r1&:(> ?r1 ?r)))   	
			     	
=>
  	  (retract  ?a ?b ?w ?ch ?v)
	  (assert  (sum1 ?q))
	  (assert  (check =(- ?z 1)))
	  (assert  (node  ?m ?q) )
	  (assert  (all_nodes ?m $?all))
	   (assert  (node_final ?m))
	  (assert  (no_truck =(- ?n 1))))


(defrule all_nodess
(declare (salience -21))
(all_nodes ?m $?all)
=>
	 (assert  (all_nodes5 ?m ?all)) 
  (assert  (all_nodes7 ?m ?all)) 
	(assert  (all_nodes6 ?m ?all))
	(assert  (all_nodes8 ?m ?all))
	(assert  (all_nodes9 ?m ?all))
	(assert  (all_nodes10 ?m ?all)) ) 
	





;IN SUMMARY THIS FILE HAS ALL THE DEFFACTS AND FINDING WHAT ARE THE NODES IN THE GIVEN GRAPH
