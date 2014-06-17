;THIS FILE CONSISTS OF RULES THAT HELP TO GENERATE THE REPORT and the format statements for output.

(defrule occupied
(declare (salience 10))
?e1 <- (occu ?t-no ?n1 $?all)
?e2 <- (countoccu ?t-no ?n)
?e3 <- (sumoccu ?t-no ?s)
=>
(retract ?e1 ?e2 ?e3)
(assert(occu ?t-no $?all))
(assert(countoccu ?t-no =(+ 1 ?n)))
(assert(sumoccu ?t-no =(+ ?s ?n1))))

(defrule occupied1
;(declare (salience -10))

?e2 <- (countoccu ?t-no ?n)
?e3 <- (sumoccu ?t-no ?s&~0)
=>
(retract ?e2 ?e3)
(assert(avg ?t-no ?n =(/ ?s ?n))))

(defrule occupied2
(declare (salience -10))
?e4 <- (avg ?t-no ?n ?a)
=>
(bind ?k (/ ?a 6))
(retract ?e4)
(assert(avgp ?t-no ?n =(* ?k 100))))

(defrule truck_print
?e1 <- (avgp ?t-no ?n ?a)
=>
(format t "%nTIME_BUSY:%d NO_OF_PACKAGES:%d AVG_PERCENT_OF_TRUCK_OCCUPIED:%d TRUCK_NO:%d%n" 100 ?n ?a ?t-no))

(defrule package_result1

?e1 <-(package_pickup ?pk-no ?cur-time)
?e2 <-(package_delivered ?pk-no ?n1 ?n2 ?s ?oa ?ex ?ad&:(> ?ad ?ex))
=>
(retract ?e1 ?e2)
(assert (time ?pk-no late =(- ?ad ?ex)))
;(assert wait-time ?pk-no =(- ?cur-time ?oa))
(assert(print ?pk-no))
(assert(package_pickup1 ?pk-no ?cur-time))
(assert(package_delivered1 ?pk-no ?n1 ?n2 ?s ?oa ?ex ?ad)))

(defrule package_result2

?e1 <-(package_pickup ?pk-no ?cur-time)
?e2 <-(package_delivered ?pk-no ?n1 ?n2 ?s ?oa ?ex ?ad&:(<= ?ad ?ex))
=>
(retract ?e1 ?e2)

(assert (time ?pk-no ontime 0))
(assert(package_pickup1 ?pk-no ?cur-time))
(assert(print ?pk-no))
(assert(package_delivered1 ?pk-no ?n1 ?n2 ?s ?oa ?ex ?ad)))

(defrule package_result3
(declare (salience -1))

(package_delivered1 ?pk-no ?n1 ?n2 ?s ?oa ?ex ?ad)
(time ?pk-no ?status ?no)
?e1 <- (print ?pk-no)
(package_pickup1 ?pk-no ?cur-time)
=>
(retract ?e1)
(format t "%nPackageno: %d wait-time:%d Pick-up-time: %d Delivery-time: %d on-time-or-not: %s how-late: %d%n" ?pk-no	(- ?cur-time ?oa)	?cur-time	?ad	?status	?no))



(defrule package_result_avg
(declare(salience -10))
(package_delivered1 ?pk-no ?n1 ?n2 ?s ?oa ?ex ?ad)
(time ?pk-no ?status ?no)
(package_pickup1 ?pk-no ?cur-time&:(> ?cur-time ?oa))
=>

(assert (wait-time ?pk-no =(- ?cur-time ?oa))))

(defrule jdn
?e1 <- (wait-time ?pk-no ?wt)
?e2 <- (coun_wait ?w)
?e3 <- (sum_coun ?s)
=>
(retract ?e1 ?e2 ?e3)
(assert(coun_wait =(+ 1 ?w)))
(assert(sum_coun =(+ ?s ?wt))))

(defrule om
(declare(salience -5))
?e1 <- (time ?pk-no ontime ?no)
?e2 <- (coun_on ?c)
=>
(retract ?e1 ?e2 )
(assert(coun_on =(+ 1 ?c))))

(defrule om1
(declare(salience -5))

?e1 <- (time ?pk-no late ?no)
?e2 <- (coun_l ?c)
?e3 <- (lates ?s)
=>
(retract ?e1 ?e2 ?e3)
(assert(lates (+ ?no ?s)))
(assert(coun_l =(+ 1 ?c))))


(defrule avg-print
(declare(salience -50))
(coun_wait ?cw)
(sum_coun ?sc)
(coun_on ?co)
(coun_l ?cl)
(lates ?s)

=>
(bind ?ss (+ ?cl ?co))
(format t "%nNUMBER_OF_PACKAGES_ON_TIME:%d NO_OF_PACKAGES_LATE:%d AVG_lATE_FOR_LATE_PACKAGES:%d AVG_LATE_ALL_PACKAGES:%d"  ?co ?cl  (/ ?s ?cl) (/ ?s ?ss)))