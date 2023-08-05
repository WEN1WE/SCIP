
; unless ----> if 

(define (unless? exp)
  (tagged-list? exp 'unless))

(define (unless-predicate exp) (cadr exp))
(define (unless-consequent exp) (caddr exp))
(define (unless-alternative exp) (cadddr exp))

(define (unless->if exp)
  (make-if (unless-predicate exp)
  		   (unless-alternative exp)
           (unless-consequent exp)
           ))




; 第二问

但在使用 map 函数时，由于 if 表达式是一个特殊形式，它需要显式地通过一个 lambda 函数进行包装，
以便正确地在每对元素上执行条件判断和选择。这是因为 map 函数会将 lambda 函数应用于列表中的每一对元素，
然后返回结果列表。

(define select-y '(#t #f #t #t))
(define xs '(1 3 5 7))
(define ys '(2 4 6 8))

(map if select-y xs ys)  ; 错误


(define result
  (map (lambda (cond x y)
         (if cond x y))
       select-y
       xs
       ys))

(display result)


(define (test op x1 x2 x3)
	(op x1 x2 x3)
)


特殊符号不是程序，没发当做程序传给另一个程序
下面例子中，if当作符号处理，

#|
;Loading "exercise14.scm"...

;;; M-Eval input:
(define (test op x1 x2 x3)
	(op x1 x2 x3)
)

;;; M-Eval value:
ok

;;; M-Eval input:
(if 1 -1 -2)     

;;; M-Eval value:
-1

;;; M-Eval input:
(test if 1 -1 -2)
;Unbound variable if




|#














