#lang racket/base

(define (sumDigits x)
   (define (helper iter result)
     (if (= 0 iter)
         result
         (helper (quotient iter 10) (+ result (remainder iter 10)))
     )
   )
   (helper x 0)
)

(define (sumDigitsRec x)
  (if (= 0 x)
      0
      (+ (remainder x 10) (sumDigitsRec (quotient x 10)))
  )
)

(define (power base exp)
  (define (helper iter accum)
    (if (= 0 iter)
       accum
       (helper (- iter 1) (* accum base))
    )
  )

  (if (< exp 0)
      (/ 1 (helper (- exp) 1))
      (helper exp 1)
  )
)

(define (powerRec base exp)
  (cond
    ( (= 0 exp) 1)
    ( (> exp 0) (* base (powerRec base (- exp 1))) )
    ( (< exp 0) (/ 1 (powerRec base (- exp))) )
  )
)

(define (fibRec n)
  (cond
    ((<= n 2) 1)
    (else (+ (fibRec (- n 1)) (fibRec (- n 2))) )
  )
)

(define (fibIter n)
  (define (helper n a b)
    (if (= n 1)
        b
        (helper (- n 1) b (+ a b))
    )
  )
  (helper n 0 1)
)

(define (revIter n)
  (define (helper n accum)
    (if (= n 0)
        accum
        (helper (quotient n 10) (+ (remainder n 10) (* 10 accum)) )
    )
  )
  (helper n 0)
)

;TODO
(define (revRec n)
  (if (= n 0)
      0
      (+
        (remainder n 10)
        (* 10 (revRec (quotient n 10)))
      )
  )
)