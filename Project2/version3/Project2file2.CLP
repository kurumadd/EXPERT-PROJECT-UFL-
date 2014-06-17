;NOW WE HAVE FOUND THE NODES NEXT IS TO DIVIDE THE GRAPHS WITH RESPECT TO THESE NODES. FOR THIS WE TAKE CITY BY CITY AND FIND THE DISTANCE BETWEEN THE CITY AND NODE.NOW DISTANCE FROM EACH CITY TO EACH NODE IS FOUND. THE NEAREST NODE IS FOUND TO EACH CITY AND IS PLACED INTO THAT NODE.

(defrule citiesss

(declare (salience 100))
?c <- (city2 ?c1 ?c2 ?d)
=>
(assert (city3 ?c1 ?c2 ?d))
(assert (city3 ?c2 ?c1 ?d)))


; NOW WE FIND DISTANCE FROM EACH AND EVERY CITY TO EACH AND EVERY NODE
(defrule cheap_path

(declare (salience 40))
?n1 <- (all_nodes ?n $?all)
?k1 <- (count1 ?k $?a)
?c2 <- (count2 $?co)
=>
(retract ?k1 ?c2)
(assert (count1 $?a))
(assert (count2 ?k $?co))
(assert (cheapest_paths ?n ?k)))
 
(defrule change
(declare (salience 40))
?k1 <- (all_nodes ?n $?all)
?k2 <- (count1)
?k3 <- (count2 $?a)
?k4 <- (all_nodes1 $?z)
=>
(retract ?k1 ?k2 ?k3)
(assert ( all_nodes $?all))
(assert (count1 $?a))
(assert (count2))
(assert (all_nodes1 ?n $?z)))
 
(defrule initial_path 

;(declare (salience -36)) 
 (cheapest_paths ?x ?y) 
 => 
 (assert (path  0 ?x)))
 
(defrule extended_path 
; (declare (salience -37))
(path   ?w $?n ?y) 
 ?r1 <- (city3 ?y ?z&~?y&:(not (member ?z $?n)) ?we) 
 => 
 ;(retract ?r1)
 (assert (path =(+ ?w ?we) $?n ?y ?z)))



 
(defrule prune_non-useful_path 
 (declare (salience 10)) 

 (path ?w1 $?a ?x) 
 ?f <- (path ?w2&:(> ?w2 ?w1) $?a ?x) 
 => 
 (retract ?f)) 
 
(defrule cheapest_paths 
 (declare (salience -38)) 
 ?r1 <- (cheapest_paths ?y ?x) 
 ?r2 <-  (path ?w $?n ?x) 
 => 
 ;(retract ?r1 ?r2)
 (assert (final_path  ?w $?n ?x ))) 

;HERE WE HAVE FOUND ALL THE DISTANCES AND NOW WE START GROUPING CITY WILL FALL IN THE GROUP THAT HAS THE MINIMUM DISTANCE BETWEEN THE PARTICULAR CITY AND ANY NODE.

(defrule grouping
(declare (salience -41))

;?k1 <- (all_nodes2 ?node $?nodes)
?k2 <- (count1 ?city1 $?cities)
?k3 <- (group ?node $?grp)

?b <- (final_path ?w1 ?node $?mcity ?city1)	
	(not(final_path ?w2&:(< ?w2 ?w1) ?node1&~?node $?mcity1 ?city1&~node1)) 

=>
(retract ?k3 ?k2)
(assert(group ?node ?city1 $?grp))
;(assert(all_nodes2 $?nodes))
(assert(count1 $?cities)))  	

(defrule grouping1
(declare (salience -38))


?k2 <- (all_nodes1 ?node $?no)
?k3 <- (all_nodes2 $?n)
=>
(retract ?k2 ?k3)
(assert (group ?node))
(assert (all_nodes1 $?no))
(assert (all_nodes2 ?node $?n)))


(defrule grouping2
(declare (salience -50))
?k1 <- (all_nodes2 $?n1 ?n $?n2)
?k2 <- (group ?g $?g1 ?n $?g2)
=>
(retract ?k2)
(assert(group ?g $?g1 $?g2)))