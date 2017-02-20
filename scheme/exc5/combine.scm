#lang racket/base

(provide combine)

(define (combine f g)
  (lambda (x) (f (g x)))
)

((combine sqrt sqrt) 4)
