#lang racket/base

(define (sum a b next term)
  (define (helper iter accum)
    (if (>= iter b)
        (+ accum (term iter))
        (helper (next iter) (+ accum (term iter)))
    )
  )
  (helper a 0)
)

(define (1+ x) (+ x 1))

(define (sum-nxn x n) (sum 1 n 1+ (lambda (i) (* i (expt x i))) ))