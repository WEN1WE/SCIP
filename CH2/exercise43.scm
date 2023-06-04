(flatmap
	(lambda (new-row)
		(map (lambda (rest-of-queens)
				 (adjoin-position new-row k rest-of-queens))
             (queen-cols (- k 1))))
 (enumerate-interval 1 board-size))

#|

(queen-cols k) 执行了太多次数，每次测试new-row就需要计算一次


|#