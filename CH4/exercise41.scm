


(baker (amb 1 2 3 4))
(cooper (amb 2 3 4 5))
(fletcher (amb 2 3 4))
(miller (amb 1 2 3 4 5))
(smith (amb 1 2 3 4 5))

(require (> miller cooper))  ; 这条语句排除1/2的选择
(require (not (= (abs (- smith fletcher)) 1)))  ; 这条语句排除1/5的选择
(require (not (= (abs (- fletcher cooper)) 1))) ; 这条语句排除1/5的选择
(require (distinct? (list baker cooper fletcher miller smith))) ;这条语句排除601/625的选择


(define (multiple-dwelling)
  (let ((miller (amb 1 2 3 4 5))
        (cooper (amb 2 3 4 5)))
    (require (> miller cooper))
      (let ((fletcher (amb 2 3 4)))
        (require (not (= (abs (- cooper fletcher)) 1)))
          (let ((smith (amb 1 2 3 4 5)))
            (require (not (= (abs (- smith fletcher)) 1)))
              (let ((baker (amb 1 2 3 4)))
                (require (distinct? (list baker cooper fletcher miller smith)))
                  (list (list 'baker baker)
                  (list 'cooper cooper)
                  (list 'fletcher fletcher)
                  (list 'miller miller)
                  (list 'smith smith))
              )
          )
      )

  )
)

(define (multiple-dwelling)
  (define (assign-miller miller)
    (if (<= miller 5)
      (begin 
        (define (assign-cooper cooper)
          (if (and (<= cooper 5) ((> miller cooper)))
            (begin
              (define (assign-fletcher fletcher)
                (if (and (<= fletcher 4) (not (= (abs (- cooper fletcher)) 1)))
                  (begin 
                    (define (assign-smith smith)
                      (if (and (<= smith 5) (require (not (= (abs (- smith fletcher)) 1))))
                        (begin
                          (define (assign-baker baker)
                            (if (and (<= baker 4) (distinct? (list baker cooper fletcher miller smith)))
                                (list (list 'baker baker)
                                (list 'cooper cooper)
                                (list 'fletcher fletcher)
                                (list 'miller miller)
                                (list 'smith smith))
                            )

                          )
                          (assign-baker 1)
                          (assign-smith (+ 1 smith))
                        )


                      )


                    )
                    (assign-smith 1)
                    (assign-fletcher (+ 1 fletcher))


                  )


                )

              )
              (assign-fletcher 2)
              (assign-cooper (+ 1 cooper))


            )


          )

        )
        (assign-cooper 2)
        (assign-miller (+ 1 miller))
      )
    )
  )

  (assign-miller 1)
)