(put 'project 'rational 
      (lambda (x) (make-scheme-number (round (/ (numer x) (denom x)))))) 

(put 'project 'real (lambda (x) )) 

 (put 'project 'complex 
      (lambda (x) (make-real (real-part x)))) 

(define (drop x)
	(let ((proc (get 'project (type-tage x))))
  		(if proc
  			(let ((project-to (proc (contents x))))
  				(if (equal? project-to (raise project-to))
  					(drop project-to)
  					x

  				)
  			)
  			x 
  		)
	)

)


 (drop (apply proc (map contents args)))