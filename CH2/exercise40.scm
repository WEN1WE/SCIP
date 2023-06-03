(define nil '())


(define (accumulate op initial sequence) 
	(if (null? sequence)
    	initial
    	(op (car sequence)
        	(accumulate op initial (cdr sequence)))))

; (op x1 (op x2 (op x3...(op xn init))))



(define (map proc items) 
	(if (null? items)
		nil
        (cons (proc (car items))
            (map proc (cdr items)))))

#|

(accumulate
	append nil (map (lambda (i)
		(map (lambda (j) (list i j)) 
			(enumerate-interval 1 (- i 1))))
       (enumerate-interval 1 n)))
|#

(define (enumerate-interval low high) 
	(if (> low high)
		nil
        (cons low (enumerate-interval (+ low 1) high))))

(define (flatmap proc seq)
	(accumulate append nil (map proc seq)))

(define (prime-sum? pair)
	(prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
	(list (car pair) (cadr pair) (+ (car pair) (cadr pair))))


#|
(define (prime-sum-pairs n) 
	(map make-pair-sum
		(filter prime-sum? (flatmap 
							(lambda (i)
							(map (lambda (j) (list i j)) 
								(enumerate-interval 1 (- i 1))))
                           (enumerate-interval 1 n)))))
|#

(define (permutations s)
	(if (null? s)                ; empty set?
		(list nil)               ; sequence containing empty set 
		(flatmap (lambda (x)
			(map (lambda (p) (cons x p)) 
				(permutations (remove x s))))
			s)))


(define (remove item sequence)
	(filter (lambda (x) (not (= x item)))
			sequence))

(define (unique-pairs n)
	(flatmap 
		 (lambda (i)
		 	(map (lambda (j) (list i j)) 
				 (enumerate-interval 1 (- i 1))
			)
		 )
         (enumerate-interval 1 n)
    )
)

(define (prime-sum-pairs n)
	(map make-pair-sum (filter prime-sum? (unique-pairs n)))
) 



(define (smallest-divisor n) (find-divisor n 2))
(define (find-divisor n test-divisor) 
	(cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
		(else (find-divisor n (+ test-divisor 1))))) 

(define (divides? a b) (= (remainder b a) 0))

(define (prime? n)
	(= n (smallest-divisor n)))









