(define nil '())

#|
(define (even-fibs n) 
	(define (next k)
		(if (> k n) 
			nil
			(let ((f (fib k))) 
				(if (even? f)
              		(cons f (next (+ k 1)))
              		(next (+ k 1))))))
	(next 0))


(define (fib n) 
	(cond ((= n 0) 0) 
		  ((= n 1) 1)
		  (else (+ (fib (- n 1)) (fib (- n 2))))))



(define (sum-odd-squares tree) 
	(cond ((null? tree) 0)
		((not (pair? tree))
		(if (odd? tree) (square tree) 0))
		(else (+ (sum-odd-squares (car tree)) 
				 (sum-odd-squares (cdr tree))))))


|#

(map square (list 1 2 3 4 5))

(define (fib n) 
	(cond ((= n 0) 0) 
		  ((= n 1) 1)
		  (else (+ (fib (- n 1)) (fib (- n 2))))))


(define (filter predicate sequence) 
	(cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
			(filter predicate (cdr sequence)))) 
        (else (filter predicate (cdr sequence)))))


(define (accumulate op initial sequence) 
	(if (null? sequence)
    	initial
    	(op (car sequence)
        	(accumulate op initial (cdr sequence)))))


(define (enumerate-interval low high) 
	(if (> low high)
		nil
        (cons low (enumerate-interval (+ low 1) high))))

(define (enumerate-tree tree) 
	(cond ((null? tree) nil)
		((not (pair? tree)) (list tree))
		(else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))


(define (sum-odd-squares tree) 
	(accumulate + 0 (map square (filter odd? (enumerate-tree tree)))))

(define (even-fibs n) 
	(accumulate
		cons
   		nil
   		(filter even? (map fib (enumerate-interval 0 n)))))


(define (list-fib-squares n) 
	(accumulate
		cons
		nil
		(map square (map fib (enumerate-interval 0 n)))))

(define (product-of-squares-of-odd-elements sequence) 
	(accumulate * 1 (map square (filter odd? sequence))))

(define (salary-of-highest-paid-programmer records) 
	(accumulate max 0 (map salary (filter programmer? records))))

#|

(even-fibs 20)

;Value: (0 2 8 34 144 610 2584)
|#


(define (map1 p sequence)
	(accumulate (lambda (x y) (cons (p x) y)) nil sequence))


(define (append1 seq1 seq2) 
	(accumulate cons seq2 seq1))

(define (length1 sequence) 
	(accumulate (lambda (x y) (+ 1 y)) 0 sequence))



























