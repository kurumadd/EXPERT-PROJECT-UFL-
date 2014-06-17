;HERE NOW WE TRY TO FIND THE DISTANCES BETWEEN EACH ADJOINING CITY AND THE PATH TO THE NEXT CITY.THE SAME ALGORITHM WHICH WAS USED TO FIND THE DISTANCE BETWEEN THE NODES AND EACH AND EVERY CITY IS USED. AS MENTIONED THIS IS A BRUTE FORCE METHOD THAT IS IT CALCULATES EACH AND EVERY PERMUTATION AND COMBINATION AND THEN GIVES THE MINIMUM RESUL OF IT.

(defrule cheap_path1

(declare (salience 40))
;?n1 <- (all_nodes7 ?n $?all)
?k1 <- (dis1 ?city1 ?city2)

=>
(retract ?k1)


(assert (cheapest_paths1 ?city1 ?city2)))
 
 
(defrule initial_path1 

;(declare (salience -36)) 
 (cheapest_paths1 ?x ?y) 
 => 
 (assert (path1  0 ?x)))
 
(defrule extended_path1 
; (declare (salience -37))
(path1   ?w $?n ?y) 
 ?r1 <- (city3 ?y ?z&~?y&:(not (member ?z $?n)) ?we) 
 => 
 ;(retract ?r1)
; (assert ( city3 ?y ?z ?we))
 (assert (path1 =(+ ?w ?we) $?n ?y ?z)))

 
(defrule prune_non-useful_path1 
 (declare (salience 10)) 

 (path1 ?w1 $?a ?x) 
 ?f <- (path1 ?w2&:(> ?w2 ?w1) $?a ?x) 
 => 
 (retract ?f)) 
 
(defrule cheapest_paths11 
 (declare (salience -10)) 
 ?r1 <- (cheapest_paths1 ?y ?x) 
 ?r2 <-  (path1 ?w ?y $?n ?x) 
(not(path1 ?w1&:(< ?w1 ?w) ?y $?n1 ?x))
 => 
 (retract ?r1 ?r2)
 (assert (final_path  ?w ?y $?n ?x ))) 


(defrule all_in
(declare (salience -40))

?k1 <- (city3 ?c1 ?c2 ?d)
=>
(retract ?k1)
(assert(final_path ?d ?c1 ?c2))
(assert(city4 ?c1 ?c2 ?d)))