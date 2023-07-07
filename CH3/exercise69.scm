(define (integers-starting-from n)
	(cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define (display-line x) (newline) (display x))
(define (show s)
	(define (helper i)
		(if (< i 10)
			(begin 
				(display-line (stream-ref s i))
				(helper (+ i 1))
			)
		)
	)
	(helper 0)
)

(define (interleave s1 s2) 
	(if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))


(define (pairs s t) 
	(cons-stream
	   (list (stream-car s) (stream-car t))
	   (interleave
			(stream-map (lambda (x) (list (stream-car s) x)) 
				        (stream-cdr t))
	        (pairs (stream-cdr s) (stream-cdr t)))))

(define (triples s t u)
	(cons-stream
		(list (stream-car s) (stream-car t) (stream-car u))

		(interleave 
			(stream-map (lambda (x) (cons (stream-car s) x))
				 (stream-cdr (pairs t u)))

			(triples (stream-cdr s) (stream-cdr t) (stream-cdr u))
		)

	)
)

(define x (triples integers integers integers))

(define (Pythagorean? triple)
	(let (
		   (t1 (car triple))
		   (t2 (cadr triple))
		   (t3 (caddr triple))

		 )
		(and (<= t1 t2) (= (+ (square t1) (square t2)) (square t3)))
	)
)

(define Pythagorean (stream-filter Pythagorean? x))
















