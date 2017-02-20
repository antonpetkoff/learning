#lang racket/base

(define (accumulate-while comb null init cond next term)
  (define (step accum iter)
    (if (cond iter)
        (step (comb accum (term iter)) (next iter))
        accum
    )
  )
  (step null init)
)

(define (decreasing? twoDigits)
  (>= (quotient twoDigits 10) (remainder twoDigits 10))
)
(define (lastTwoDecreasing? x) (decreasing? (remainder x 100)))
(define (_and a b) (and a b))
(define (hasTwoDigits x) (> x 9))
(define (removeLastDigit x) (quotient x 10))

(define (progr n)
  (accumulate-while _and #t n hasTwoDigits removeLastDigit lastTwoDecreasing?)
)
