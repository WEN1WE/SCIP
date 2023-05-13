(define (count-change amount) (cc amount 5))



#|
这个凑钱的程序，最难的应该是确定程序什么时候结束，可以取几个简单的例子解释

假设amount = 10, coin 只有一种10， 
(cc 10 1)
(+ (cc 10 0) (cc 0 1))    ;;; amount  = 0 代表已经完成任务了，可以返回，计数加1
(+ 0 1)                   ;;; 如果kinds-of-coins = 0，则选择的方向错误，返回为0
						  ;;; 如果amount < 0, 则当前选择完全错误，返回为0
|#



(define (cc amount kinds-of-coins)
	(cond ((= amount 0) 1)
		  ((or (< amount 0) (= kinds-of-coins 0)) 0)
		  (else (+ (cc amount 
		  	           (- kinds-of-coins 1))
		  		   (cc (- amount (first-denomination kinds-of-coins))
		  			   kinds-of-coins)))))


(define (first-denomination kinds-of-coins)
	(cond ((= kinds-of-coins 1) 1)
		  ((= kinds-of-coins 2) 5)
          ((= kinds-of-coins 3) 10)
          ((= kinds-of-coins 4) 25)
          ((= kinds-of-coins 5) 50)))