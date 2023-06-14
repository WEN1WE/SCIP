;将complex中的+ - * / 改为通用型的add sub mul div


 (define (sine x) (apply-generic 'sine x)) 
 (define (cosine x) (apply-generic 'cosine x)) 


 (put 'sine 'scheme-number 
      (lambda (x) (tag (sin x)))) 
 (put 'cosine 'scheme-number 
      (lambda (x) (tag (cos x)))) 	


 (put 'sine 'rational 
      (lambda (x) (tag (sin x)))) 
 (put 'cosine 'rational 
      (lambda (x) (tag (cos x)))) 