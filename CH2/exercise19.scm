#|
(define (count-change amount) (cc amount 5)) 

(define (cc amount kinds-of-coins)
	(cond ((= amount 0) 1)
		((or (< amount 0) (= kinds-of-coins 0)) 0) 
		(else (+ (cc amount
                     (- kinds-of-coins 1))
                 (cc (- amount
                        (first-denomination
                         kinds-of-coins))
					kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
	(cond ((= kinds-of-coins 1) 1) 
		  ((= kinds-of-coins 2) 5)
          ((= kinds-of-coins 3) 10)
          ((= kinds-of-coins 4) 25)
          ((= kinds-of-coins 5) 50)))
|#

(define us-coins (list 50 5 10 25 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))

(define (cc amount coin-values) 
	(cond ((= amount 0) 1)
		((or (< amount 0) (no-more? coin-values)) 0) 
		(else
         (+ (cc amount
                (except-first-denomination
                 coin-values))
            (cc (- amount
                   (first-denomination
                    coin-values))
                coin-values)))))

(define (first-denomination items)
	(car items) 
)
(define (except-first-denomination items)
	(cdr items)
)

(define (no-more? items)
	(null? items)
)

(cc 100 us-coins)


#|
与排列顺序无关，递归都是等价的，但是程序会变慢


|#




