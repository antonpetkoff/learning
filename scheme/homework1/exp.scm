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

(define (fact n)
  (define (helper iter accum)
    (if (<= iter 1)
        accum
        (helper (- iter 1) (* accum iter))
    )
  )
  (helper n 1)
)

(define (1+ x) (+ x 1))

(define (exp x n) (sum 0 n 1+ (lambda (k) (/ (expt x k) (fact k))) ))