#lang racket/base

(provide derivative)

(define (derivative f dx)
  (lambda (x) (/ (- (f (+ x dx)) (f x) ) dx))
)

(define (cube x) (* x x x))
(define (square x) (* x x))

(square 3)
((derivative square 0.0001) 3)
