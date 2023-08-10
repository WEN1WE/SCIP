an-integer-starting-from

; k会一直往后进行，不会有结果
(define (a-pythagorean-triple-between low) 
	(let ((i (an-integer-between low)))
		(let ((j (an-integer-between low)))
			(let ((k (an-integer-between low))) 
				(require (= (+ (* i i) (* j j)) (* k k))) 
				(list i j k)))))


 (define (a-pythagorean-triple low) 
         (let ((k (an-integer-starting-from low))) 
          (let ((j (an-integer-between low k))) 
           (let ((i (an-integer-between low j))) 
             (require (= (+ (* i i) (* j j)) (* k k))) 
                 (list i j k))))) 