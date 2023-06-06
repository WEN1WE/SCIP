(define (memq item x) 
	(cond ((null? x) false)
		((eq? item (car x)) x) 
		(else (memq item (cdr x)))))


1 ]=> (list 'a 'b 'c)

;Value: (a b c)

1 ]=>  (list (list 'george))

;Value: ((george))

1 ]=> (cdr '((x1 x2) (y1 y2)))

;Value: ((y1 y2))

1 ]=> (cadr '((x1 x2) (y1 y2)))

;Value: (y1 y2)

1 ]=> (pair? (car '(a short list)))

;Value: #f

1 ]=> (memq 'red '((red shoes) (blue socks)))

;Value: #f

1 ]=> (memq 'red '(red shoes blue socks))

;Value: (red shoes blue socks)
