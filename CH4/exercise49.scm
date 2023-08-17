(define (parse-word2 word-list) 
   (require (not (null? *unparsed*))) 
   (set! *unparsed* (cdr *unparsed*)) 
   (list (car word-list) (amb (cdr word-list)))) 