(defrule lateness
?e1 <- (package_delivered ?pk-no ?del)
?e2 <- (edt ?pk-no ?arr&:(< ?arr ?del))
?e3 <- (late-count ?cn)
=>
(retract ?e1 ?e2 ?e3)
(assert(late yes ?pk-no =(- ?del ?arr)))
(assert(late-count =(+ 1 ?cn)))
(assert(pack-del ?pk-no ?del)))


(defrule early
?e1 <- (package_delivered ?pk-no ?del)
?e2 <- (edt ?pk-no ?arr&:(>= ?arr ?del))
?e3 <- (early-count ?cn)
=>
(retract ?e1 ?e2 ?e3)
(assert(late no ?pk-no 0))
(assert(early-count =(+ 1 ?cn)))

(assert(pack-del ?pk-no ?del)))

(defrule printtt
(declare (salience -1))
?e1 <- (wait-time ?pk-no ?tar)
;(not(wait-time ?pk&:(< ?pk ?pk-no) ?tar2))

?e3 <- (pack-del ?pk-no ?del)
?e4 <- (late ?nnn ?pk-no ?laa)
?e5 <- (pick-up ?pk-no ?pick)
(not(pick-up ?pk-n&:(< ?pk-n ?pk-no) ?pi))
=>
(retract ?e5)
(format t "%n PACKAGE NO:%d  Wait-Time:%d Pick-up-Time:%d Delivery-Time:%d Whether-on-time:%s Lateness:%d%n" ?pk-no ?tar ?pick ?del ?nnn ?laa ))

(defrule avg
(declare (salience -2))
?e1 <- (wait-time ?pk-no ?tar)
?e2 <- (total-wait ?t)
=>
(retract ?e1 ?e2)
(assert(total-wait =(+ ?t ?tar))))

(defrule avgq
(declare (salience -2))
?e1 <- (late yes ?pk-no ?tar)
?e2 <- (total-late ?t)
=>
(retract ?e1 ?e2)
(assert(total-late =(+ ?t ?tar))))
(defrule count
(declare (salience -2))
?e1 <-(count) 
(pack-del ?pk-no ?del)
(not(pack-del ?pk-no1&:(> ?pk-no ?pk-no1)))
=>
(retract ?e1)
(assert( count ?pk-no)))

(defrule late-ontime
(declare (salience -10))
(early-count ?ea)
(late-count ?lc)
=>
(assert(late-early ?ea ?lc)))

(defrule print-avg

?e1 <- (total-wait ?tw)
?e2 <- (late-early ?ea ?lc)
?e3 <- (total-late ?tl)
?e4 <- (count ?max)
=>
(retract ?e1 ?e2 ?e3 ?e4)
(format t "%n AVG WAIT TIME:%f NO OF PACKAGES ON_TIME: %f NO_OF PACKAGES LATE:%f AVG LATENESS FOR LATE PACKAGES:%f AVG LATENESS FOR ALL PACKAGES:%f%n" (/ ?tw ?max) ?ea ?lc (/ ?tl ?lc) (/ ?tl ?max)))