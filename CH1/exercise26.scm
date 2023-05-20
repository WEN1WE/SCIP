(define (expmod base exp m) 
	(cond ((= exp 0) 1)
        ((even? exp)
         (remainder (* (expmod base (/ exp 2) m)
                       (expmod base (/ exp 2) m))
                    m))
		(else
		(remainder (* base
                       (expmod base (- exp 1) m))
                    m))))


#|
按照原来的程序 exp 每缩减一半，只用执行一次expmod

第二种exp 缩减一半，但是expmod执行了2次，这样程序就变成了O(n), 
这也是一个树形递归，高度为log(n),节点数为n


|#