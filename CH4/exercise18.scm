(lambda ⟨vars⟩
	(let ((u '*unassigned*) 
		  (v '*unassigned*))
		(let ((a ⟨e1⟩) 
			  (b ⟨e2⟩)) 
			(set! u a)
			(set! v b))
		⟨e3⟩))

(lambda ⟨vars⟩
	(let ((u '*unassigned*)
		 (v '*unassigned*)) 
	(set! u ⟨e1⟩)
	(set! v ⟨e2⟩) 
	⟨e3⟩))

(lambda ⟨vars⟩ 
	(define u ⟨e1⟩) 
	(define v ⟨e2⟩) 
	⟨e3⟩)

(define (solve f y0 dt)
	(define y (integral (delay dy) y0 dt)) 
	(define dy (stream-map f y))
	y)      

(let ((a (integral (delay dy) y0 dt)))
	  (b (stream-map f y))   ; 对于b 中 y 没有定义，出现错误
	 )                                            



