#lang racket/base

(provide repeat)

(define (accumulate comb null-val term a next b)
  (if (>= a b)
      (comb (term a) null-val)
      (comb   ; the order of the arguments of comb matters here
        (term a)
        (accumulate
          comb
          null-val
          term
          (next a)
          next
          b
        )
      )
  )
)

(define (combine f g)
  (lambda (x) (f (g x)))
)

(define (id x) x)
(define (1+ x) (+ x 1))

(define (repeat f n)
  (accumulate
    combine
    id
    (lambda (iter) f)
    1
    1+
    n
  )
)

(define (square x) (* x x))
(define (quad x) ((combine square square) x))

((repeat square 3) 2)

(define (derivative f dx)
  (lambda (x) (/ (- (f (+ x dx)) (f x) ) dx))
)

(define (derivative-n-rec f dx n)
  (if (= n 0)
      f
      (derivative (derivative-n-rec f dx (- n 1)) dx)
  )
)

;(define (derivative-n f dx n)
;  (
;    (repeat
;      (lambda (f) (derivative f dx))
;      n)
;    f
;  )
;)

(define (derivative-n f dx n)
  (define (der x) (derivative x dx))
  ((repeat der n) f)
)

((derivative-n-rec quad 0.0001 2) 2)
((derivative-n quad 0.0001 2) 2)