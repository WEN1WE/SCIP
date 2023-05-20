#|

(define (expmod base exp m) 
	(remainder (fast-expt base exp) m))

|#

#|
fast-expt 会先得到一个很大的数，然后再remainder，程序就会很慢

|#


(define (expmod base exp m) 
	(cond ((= exp 0) 1)
          ((even? exp) (remainder (square (expmod base (/ exp 2) m)) m)) 
          (else (remainder (* base (expmod base (- exp 1) m)) m)))
)

#|

可以看出，remainder每次的输入都比较小， 输入为余数，则肯定比m小

1 ]=> (expmod 23 1000003 1000003)

[Entering #[compound-procedure 1 expmod]
    Args: 23
          1000003
          1000003]
[Entering #[compound-procedure 1 expmod]
    Args: 23
          1000002
          1000003]
[Entering #[compound-procedure 1 expmod]
    Args: 23
          500001
          1000003]
[Entering #[compound-procedure 1 expmod]
    Args: 23
          500000
          1000003]
[Entering #[compound-procedure 1 expmod]
    Args: 23
          250000
          1000003]
[Entering #[compound-procedure 1 expmod]
    Args: 23
          125000
          1000003]
[Entering #[compound-procedure 1 expmod]
    Args: 23
          62500
          1000003]
[Entering #[compound-procedure 1 expmod]
    Args: 23
          31250
          1000003]
[Entering #[compound-procedure 1 expmod]
    Args: 23
          15625
          1000003]
[Entering #[compound-procedure 1 expmod]
    Args: 23
          15624
          1000003]
[Entering #[compound-procedure 1 expmod]
    Args: 23
          7812
          1000003]
[Entering #[compound-procedure 1 expmod]
    Args: 23
          3906
          1000003]
[Entering #[compound-procedure 1 expmod]
    Args: 23
          1953
          1000003]
[Entering #[compound-procedure 1 expmod]
    Args: 23
          1952
          1000003]
[Entering #[compound-procedure 1 expmod]
    Args: 23
          976
          1000003]
[Entering #[compound-procedure 1 expmod]
    Args: 23
          488
          1000003]
[Entering #[compound-procedure 1 expmod]
    Args: 23
          244
          1000003]
[Entering #[compound-procedure 1 expmod]
    Args: 23
          122
          1000003]
[Entering #[compound-procedure 1 expmod]
    Args: 23
          61
          1000003]
[Entering #[compound-procedure 1 expmod]
    Args: 23
          60
          1000003]
[Entering #[compound-procedure 1 expmod]
    Args: 23
          30
          1000003]
[Entering #[compound-procedure 1 expmod]
    Args: 23
          15
          1000003]
[Entering #[compound-procedure 1 expmod]
    Args: 23
          14
          1000003]
[Entering #[compound-procedure 1 expmod]
    Args: 23
          7
          1000003]
[Entering #[compound-procedure 1 expmod]
    Args: 23
          6
          1000003]
[Entering #[compound-procedure 1 expmod]
    Args: 23
          3
          1000003]
[Entering #[compound-procedure 1 expmod]
    Args: 23
          2
          1000003]
[Entering #[compound-procedure 1 expmod]
    Args: 23
          1
          1000003]
[Entering #[compound-procedure 1 expmod]
    Args: 23
          0
          1000003]
[1
      <== #[compound-procedure 1 expmod]
    Args: 23
          0
          1000003]
[23
      <== #[compound-procedure 1 expmod]
    Args: 23
          1
          1000003]
[529
      <== #[compound-procedure 1 expmod]
    Args: 23
          2
          1000003]
[12167
      <== #[compound-procedure 1 expmod]
    Args: 23
          3
          1000003]
[35445
      <== #[compound-procedure 1 expmod]
    Args: 23
          6
          1000003]
[815235
      <== #[compound-procedure 1 expmod]
    Args: 23
          7
          1000003]
[111407
      <== #[compound-procedure 1 expmod]
    Args: 23
          14
          1000003]
[562355
      <== #[compound-procedure 1 expmod]
    Args: 23
          15
          1000003]
[197299
      <== #[compound-procedure 1 expmod]
    Args: 23
          30
          1000003]
[778623
      <== #[compound-procedure 1 expmod]
    Args: 23
          60
          1000003]
[908278
      <== #[compound-procedure 1 expmod]
    Args: 23
          61
          1000003]
[450386
      <== #[compound-procedure 1 expmod]
    Args: 23
          122
          1000003]
[940458
      <== #[compound-procedure 1 expmod]
    Args: 23
          244
          1000003]
[596390
      <== #[compound-procedure 1 expmod]
    Args: 23
          488
          1000003]
[965063
      <== #[compound-procedure 1 expmod]
    Args: 23
          976
          1000003]
[799940
      <== #[compound-procedure 1 expmod]
    Args: 23
          1952
          1000003]
[398566
      <== #[compound-procedure 1 expmod]
    Args: 23
          1953
          1000003]
[379794
      <== #[compound-procedure 1 expmod]
    Args: 23
          3906
          1000003]
[49707
      <== #[compound-procedure 1 expmod]
    Args: 23
          7812
          1000003]
[778439
      <== #[compound-procedure 1 expmod]
    Args: 23
          15624
          1000003]
[904046
      <== #[compound-procedure 1 expmod]
    Args: 23
          15625
          1000003]
[718228
      <== #[compound-procedure 1 expmod]
    Args: 23
          31250
          1000003]
[912437
      <== #[compound-procedure 1 expmod]
    Args: 23
          62500
          1000003]
[781355
      <== #[compound-procedure 1 expmod]
    Args: 23
          125000
          1000003]
[804486
      <== #[compound-procedure 1 expmod]
    Args: 23
          250000
          1000003]
[782611
      <== #[compound-procedure 1 expmod]
    Args: 23
          500000
          1000003]
[1000002
      <== #[compound-procedure 1 expmod]
    Args: 23
          500001
          1000003]
[1
      <== #[compound-procedure 1 expmod]
    Args: 23
          1000002
          1000003]
[23
      <== #[compound-procedure 1 expmod]
    Args: 23
          1000003
          1000003]
;Value: 23

|#