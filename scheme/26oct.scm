#lang racket/base

(define (automorph? n)
  (eq? n
     (remainder 
        (* n n) 
        (expt 10 (digitCount n) ) 
     ) 
  )
)

(define (digitCount n)
  (if (<= n 9)
     1
     (+ 1 (digitCount (quotient n 10)))
  )
)

(define (reverse n)
  (define (helper n accum)
    (if (= n 0)
        accum
        (helper (quotient n 10) (+ (remainder n 10) (* 10 accum)) )
    )
  )
  (helper n 0)
)

(define (palindrome? n)
  (= n (reverse n))
)

;sum function

(define (sum term a next b)
    (if (>= a b)
        (term a)
        (+
            (term a)
            (sum term (next a) next b)
        )
    )
)

(sum
  (lambda (x) x)
  0
  (lambda (x) (+ x 1))
  3
)

(define (sumIter term a next b)
  (define (helper iter accum)
    (if (>= iter b)
        (+ accum (term iter))
        (helper (next iter) (+ accum (term iter)))
    )
  )
  (helper a 0)
)

(sumIter
  (lambda (x) (* 2 x))
  0
  (lambda (x) (+ x 1))
  3
)

(define (paly-count a b)
  (sumIter
    (lambda (x) (if (palindrome? x) 1 0))
    a
    (lambda (x) (+ x 1))
    b
  )
)

(define (next x) (+ x 1))

(define (automorph-count a b)
  (sumIter
    (lambda (x) (if (automorph? x) 1 0 ))
    a
    next
    b
  )
)

; accumulate function

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

(accumulate
  +
  0
  (lambda (x) x)
  0
  (lambda (x) (+ x 1))
  3
)

(accumulate
  (lambda (a b)
    (if (even? a)
       (+ (* b 10) a)
       b
    )
  )
  0
  (lambda (x) x)
  1
  (lambda (x) (+ x 1))
  9
)
