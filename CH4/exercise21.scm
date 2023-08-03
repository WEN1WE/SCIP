(
	(lambda (n)
		(
			(lambda (fact) (fact fact n))

			(lambda (ft k) (if (= k 1) 1 (* k (ft ft (- k 1)))))

		)

	) 


	10
)

fact : (lambda (ft k) (if (= k 1) 1 (* k (ft ft (- k 1)))))
(fact fact 10)
(* 10 (fact fact 9))
(fact fact 9)
(* 9 (fact fact ))


(
	(lambda (n)
		(
			(lambda (fib) (fib fib n))

			(lambda (ft k) 
				(if (= k 0) 
					0 
					(if (= k 1)
						1
						(+ (ft ft (- k 1)) (ft ft (- k 2)))))
			)
		)
	) 
	10
)




(define (f x) 
	(define (even? n)
		(if (= n 0) true (odd? (- n 1)))) 
	(define (odd? n)
		(if (= n 0) false (even? (- n 1)))) 
	(even? x))


(define (f x)
	((lambda (even? odd?) (even? even? odd? x))

		(lambda (ev? od? n)
			(if (= n 0) true (od? ⟨??⟩ ⟨??⟩ ⟨??⟩)))

		(lambda (ev? od? n)
			(if (= n 0) false (ev? ⟨??⟩ ⟨??⟩ ⟨??⟩))))

)



enen?  		(lambda (ev? od? n)
				(if (= n 0) true (od? ⟨??⟩ ⟨??⟩ ⟨??⟩)))


odd?        (lambda (ev? od? n)
				(if (= n 0) false (ev? ⟨??⟩ ⟨??⟩ ⟨??⟩)))


(even? even? odd? x)
ev? enen?
od? odd? 
n x


(od? en? od? (- n 1))


(ev? ev? od? (- n 1))





























