 (define (first-term term-list) 
     (make-term (- (len term-list) 1) (car term-list))) 
  

 ;加入的项比原来的列表高阶
 (define (adjoin-term term term-list) 
   (cond ((=zero? term) term-list) 
         ((equ? (order term) (length term-list)) (cons (coeff term) term-list)) 
         (else (adjoin-term term (cons 0 term-list))))) 


 (define (the-empty-termlist) '())