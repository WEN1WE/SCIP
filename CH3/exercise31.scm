(define (make-wire)
	(let ((signal-value 0) (action-procedures '()))
		(define (set-my-signal! new-value) 
			(if (not (= signal-value new-value))
				(begin (set! signal-value new-value) 
					(call-each action-procedures))
				'done))
		(define (accept-action-procedure! proc)
			(set! action-procedures
				(cons proc action-procedures))
			(proc))

		(define (dispatch m)
			(cond ((eq? m 'get-signal) signal-value)
			((eq? m 'set-signal!) set-my-signal!)
			((eq? m 'add-action!) accept-action-procedure!) 
			(else (error "Unknown operation: WIRE" m))))

		dispatch
	)
)


(define (call-each procedures)
	(if (null? procedures) 
		'done
		(begin ((car procedures))
			   (call-each (cdr procedures)))))


(define (get-signal wire) (wire 'get-signal)) 
(define (set-signal! wire new-value)
	((wire 'set-signal!) new-value))
(define (add-action! wire action-procedure)
 	((wire 'add-action!) action-procedure))



(define (after-delay delay action)
	(add-to-agenda! (+ delay (current-time the-agenda))
                     action
                     the-agenda))


(define (propagate)
	(if (empty-agenda? the-agenda)
		'done
		(let ((first-item (first-agenda-item the-agenda)))
        	(first-item)
        	(remove-first-agenda-item! the-agenda)
        	(propagate))))


(define (probe name wire) 
	(add-action! wire
		(lambda ()
			(newline)
			(display name) (display " ") 
			(display (current-time the-agenda)) 
			(display " New-value = ")
			(display (get-signal wire)))))


(define the-agenda (make-agenda)) 
(define inverter-delay 2)
(define and-gate-delay 3)
(define or-gate-delay 5)



(define input-1 (make-wire)) 
(define input-2 (make-wire)) 
(define sum (make-wire)) 
(define carry (make-wire))


(half-adder input-1 input-2 sum carry) 
;ok
(set-signal! input-1 1) 
;done
(propagate)
sum 8 New-value = 1 
;done


(define (half-adder a b s c)
	(let ((d (make-wire)) (e (make-wire)))
	    (or-gate a b d)
	    (and-gate a b c)
	    (inverter c e)
	    (and-gate d e s)
	    'ok))


(define (accept-action-procedure! proc) 
	(set! action-procedures
              (cons proc action-procedures)))





(or-gate a b d)
(and-gate a b c)
(inverter c e)
(and-gate d e s)

a :
   or-action-procedure  --- a b d
   and-action-procedure --- a b c

b : 
   or-action-procedure --- a b d
   and-action-procedure --- a b c

c :
   invert-input  --- c e
   print 

d : 
   and-action-procedure  --- d e s

e : 
   and-action-procedure --- d e s

s : 
   print





the-agenda : 
	 5 d = a or b
	 5 d = a or b
	 3 c = a and b
	 3 c = a and b
	 2 e = not c
	 3 s = d and e
	 3 s = d and e

	; 前面的相当于进行了初始化

	 5 d = a or b
	 3 c = a and b




(set-signal! a 1)

; 如果不初始化，e 为0 D 为1 那么s 就是0，计算错误











