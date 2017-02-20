#lang racket/base

(define (gcd a b)
    (cond
        ((eq? a b) a)
        ((> a b) (gcd (- a b) b))
        (else (gcd a (- b a)))
    )
)

; it would be better for the else to return #f
; useful for example when top and bot are not numbers
(define (make-rat top bot)
    (cond 
        ((or 
            (and (< top 0) (< bot 0))
            (and (> top 0) (< bot 0))
        ) (cons (- top) (- bot)))
        ((= bot 0) #f)
        (else (cons top bot) )
    )
)

(define (sum-rat a b)
    (make-rat
        (+
            (* (car a) (cdr b))
            (* (car b) (cdr a))
        )
        (* 
            (cdr a)
            (cdr b)
        )
    )
)

(define (subt-rat a b)
    (sum-rat
        a
        (make-rat (- (car b)) (cdr b))
    )
)

(define (multi-rat a b)
    (make-rat
        (* (car a) (car b))
        (* (cdr a) (cdr b))
    )
)

(define (div-rat a b)
    (multi-rat
        a
        (make-rat (cdr b) (car b))
    )
)

(define (nth L n)
    (define (helper l iter)
        (if (and (< iter n ) (not (null? (cdr l))) )
            (helper (cdr l) (+ iter 1))
            (car l)
        )
    )
    (helper L 0)
)

(define (len L)
    (define (iter accum l)
        (if (null? l)
            accum
            (iter (+ accum 1) (cdr l))
        )
    )
    (iter 0 L)
)

(define a (make-rat 2 10))
(define b (make-rat 5 3))
(define c (make-rat 0 4))