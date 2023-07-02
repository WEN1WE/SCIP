(define (stream-enumerate-interval low high) 
	(if (> low high)
      the-empty-stream
      (cons-stream
      	low
       (stream-enumerate-interval (+ low 1) high))))


(define (show x) 
	(display-line x) 
	x)

(define (display-line x) (newline) (display x))

(define x
	(stream-map show
              (stream-enumerate-interval 0 10)))


(stream-ref x 5)
(stream-ref x 7)


#|

1 ]=> (load "exercise51.scm")

;Loading "exercise51.scm"...
0
1
2
3
4
5
;... done
;Value: 5



1 ]=> (load "exercise51.scm")

;Loading "exercise51.scm"...
0
1
2
3
4
5
6
7
;... done
;Value: 7



|#
