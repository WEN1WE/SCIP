 (define (reduce-terms n d) 
   (let ((gcdterms (gcd-terms n d))) 
         (list (car (div-terms n gcdterms)) 
               (car (div-terms d gcdterms))))) 
  
 (define (reduce-poly p1 p2) 
   (if (same-variable? (variable p1) (variable p2)) 
     (let ((result (reduce-terms (term-list p1) (term-list p2)))) 
       (list (make-poly (variable p1) (car result)) 
             (make-poly (variable p1) (cadr result)))) 
     (error "not the same variable--REDUCE-POLY" (list p1 p2)))) 



 (define (reduce-integers n d) 
 	(let ((g (gcd n d)))
       (list (/ n g) (/ d g))))


 (define p1 (make-polynomial 'x '((1 1) (0 1)))) 
 (define p2 (make-polynomial 'x '((3 1) (0 -1)))) 
 (define p3 (make-polynomial 'x '((1 1)))) 
 (define p4 (make-polynomial 'x '((2 1) (0 -1)))) 
 (define rf1 (make-rational p1 p2))
(define rf2 (make-rational p3 p4))