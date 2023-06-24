(define (ripple-carry-adder Ak Bk Sk c)
	(let ((Ck (map (lambda (x) (make-wire)) a-list)))
		(set! Ck (cons c Ck))
		(define (iter A B S C)
			(if (null? A)
				'ok
				(begin (full-adder (car A) (car B) (car C) (car S) (cadr C))
					   (iter (cdr A) (cdr B) (cdr S) (cdr C))
			    )
			)
		)
		(iter Ak Bk Sk Ck)
	)
)

; 这道题应该先生成线路，再连线才是对的



#|

一个半加器：
	2 and delay
	1 or delay
	1 not delay

一个全加器：
	2个半加器加一个or delay
	一共
	4 and delay
	3 or delay
	2 not delay

n个全加器
	4n and delay
	3n or delay
	2n not delay

|#