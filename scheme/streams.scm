#lang racket/base

(require racket/stream)
(define ones (stream-cons 1 ones))

;ones
;(stream-first ones)
;(stream-rest ones)
;(stream-empty? ones)
;(stream? ones)

(define (first-n s n)
    (define (helper iter ls str)
        (if (< iter n)
            (helper (+ iter 1) (cons (stream-first str) ls) (stream-rest str))
            ls
        )
    )
    (reverse (helper 0 '() s))
)

(define (from n)
    (stream-cons n
                 (from (+ n 1)))
)

(define naturals (from 1))

(define (fibs-from a b)
    (stream-cons a (fibs-from b (+ a b)))
)

(define fibs (fibs-from 1 1))

(first-n fibs 10)

(define (pairs)
    (define (helper iter curr)
        (if (= iter curr)
            (stream-cons (cons iter curr) (helper (+ iter 1) 1))
            (stream-cons (cons iter curr) (helper iter (+ curr 1)))
        )
    )
    (helper 1 1)
)

;(first-n (pairs) 10)

(define (pairs-square)
    (define (helper x y)
        (cond
            ((= x 1) (stream-cons (cons x y) (helper (+ y 1) 1)))
            ((> x y) (stream-cons (cons x y) (helper x (+ y 1))))
            (else  (stream-cons (cons x y) (helper (- x 1) y)) )    ; (<= x y)
        )
    )
    (helper 1 1)
)

(first-n (pairs-square) 16)
