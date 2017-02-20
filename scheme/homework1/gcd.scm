#lang racket/base

(define (gcd a b)
    (cond ((eq? a b) a)
          ((> a b) (gcd (- a b) b))
          (else (gcd a (- b a)))
    )
)