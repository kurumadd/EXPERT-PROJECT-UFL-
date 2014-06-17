;TILL NOW GROUPING HAS BEEN COMPLETED AND THE NEXT TASK IS TO FORM A ROUTE WITHIN THE GROUP.THIS IS A HEURISTIC WAY IF FINDING THE PATH AND IS NOT COMPULSARILY THE MINIMUM PATH.

(defrule fix_path

(declare (salience -110))
?k1 <- (group ?node $?c2)
(all_nodes7 $?al1 ?node $?al2)
=>
(retract ?k1 )
(assert (group1 ?node))
(assert (group_path 0 ?node))
(assert(group ?node $?c2)))


(defrule fix_path1

?k1 <- (group ?node $?c1 ?c2&~?node $?c3)
?k2 <- (group_path ?d ?c $?city ?node) 
(all_nodes7 $?n1 ?node $?n2)
?k3 <- (group1 $?k)
(city3 ?c ?c2 ?d1)
(not(city3 ?c ?c5&:(member ?c5 $?c1) ?d2&:(< ?d2 ?d1)))

=>
(retract ?k1 ?k2 ?k3)
(assert (group1 $?k ?c2)) 
(assert(group ?node $?c1 $?c3))
(assert(group_path =(+ ?d ?d1) ?c2 ?c $?city ?node)))

(defrule fix_path3

?k1 <- (group ?node $?c1 ?c2&~?node $?c3)
?k2 <- (group_path ?d ?c $?city ?node) 
(all_nodes7 $?n1 ?node $?n2)
?k3 <- (group1 $?k)
(city3 ?c ?c2 ?d1)
(not(city3 ?c ?c5&:(member ?c5 $?c3) ?d2&:(< ?d2 ?d1)))

=>
(retract ?k1 ?k2 ?k3)
(assert (group1 $?k ?c2)) 
(assert(group ?node $?c1 $?c3))
(assert(group_path =(+ ?d ?d1) ?c2 ?c $?city ?node)))


(defrule fix_path2

(declare (salience -100))
?k1 <- (group ?node)
?k2 <- (group_path ?d ?c $?city ?node) 
?k3 <- (group1 $?k)
(all_nodes7 $?n1 ?node $?n2)
(final_path ?d1 ?node $?mid ?c)
(not(final-path ?d2&:(< ?d2 ?d1) ?node $?mid1 ?c))

=>
(retract ?k1 ?k2 ?k3)
(assert (group1 $?k )) 
(assert(group_path =(+ ?d ?d1) ?node ?c $?city)))

(defrule fix_path4
(declare (salience -9))
?k1 <- (group ?node $?c1 ?c2&~?node $?c3)
?k2 <- (group_path ?d ?node) 
(all_nodes7 $?n1 ?node $?n2)
?k3 <- (group1 $?k)
(city3 ?node ?c2 ?d1)
(not(city3 ?node ?c5&:(member ?c5 $?c1) ?d2&:(< ?d2 ?d1)))

=>
(retract ?k1 ?k2 ?k3)
(assert (group1 $?k ?c2)) 
(assert(group ?node $?c1 $?c3))
(assert(group_path =(+ ?d ?d1) ?c2 ?node)))


(defrule merge
(declare (salience -111))
(all_nodes7 $?a1 ?node $?a2)
?k1 <- (group_path ?d1 ?node $?rem ?city1 )
?k2 <- (group_path ?d2 ?city2 $?rem2 ?node)
=>
(retract ?k1 ?k2)
(assert (dis1 ?city1 ?city2))
(assert (group_path =(+ ?d1 2) ?node $?rem ?city1 ?city2 $?rem2)) )


(defrule duplicate

(group_path $?a)
=>
(assert(grp $?a))
(assert(group_path1 $?a)))

;BY THE END OF THIS A PATH HAS  BEEN ESTABLISHED. THE METHOD USED TO FIND THIS IS BRUTE FORCE OR IN OTHER WORDS TRIAL AND ERROR METHOD AND TRYING TO FIND THE MINIMUM IN THE OBTAINABLE SETS