(define nil '())

(define (accumulate op initial sequence) 
	(if (null? sequence)
    	initial
    	(op (car sequence)
        	(accumulate op initial (cdr sequence)))))


(define (accumulate-n op init seqs) 
	(if (null? (car seqs))
		nil
		(cons (accumulate op init (get-first seqs))
			  (accumulate-n op init (get-last seqs)))))


(define (get-first seqs)
	(if (null? seqs)
		nil
		(cons (car (car seqs)) 
			  (get-first (cdr seqs))
		)  
	)
)

(define (get-last seqs)
	(if (null? seqs)
		nil
		(cons (cdr (car seqs))
			  (get-last (cdr seqs))
		)
	)
)

(define test (list (list 1 2 3) (list 4 5 6) (list 7 8 9) (list 10 11 12)))


#|
本题使用map做更加简单



|#