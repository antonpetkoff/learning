#lang racket/base

(define L '(1 2 3 4 5 6 7 8 9))

(define (reverse L)
    (define (helper current-list reversed)
        (if (null? current-list)
            reversed
            (helper (cdr current-list) (cons (car current-list) reversed))
        )
    )
    (helper L '())
)

; recursion may be better
(define (filter f L)
    (define (helper current-list result)
        (cond 
            ((null? current-list) result)
            (
                (f (car current-list))  ; if the predicate is true for the current element
                (helper
                    (cdr current-list)  ; give the remaining elements
                    (cons (car current-list) result)
                )
            )
            (else (helper (cdr current-list) result))
        )
    )
    (reverse (helper L '()))
)

(filter odd? L)

(define (map f L)
    (define (helper current-list result)
        (if (null? current-list)
            result
            (helper
                (cdr current-list)
                (cons (f (car current-list)) result)
            )
        )
    )
    (reverse (helper L '()))
)

(map (lambda (x) (/ x 2)) L)

(define (reduce op L nv)
    (define (helper current-list accum)
        (if (null? current-list)
            accum
            (helper
                (cdr current-list)
                (op accum (car current-list))
            )
        )
    )
    (helper L nv)
)

(reduce + L 0)

(define (zad1 L v)
    (let* 
        ( ; variables
            (filtered (filter (lambda (x) (even? x)) L))
            (mapped (map (lambda (x) (+ (* x x) v)) filtered))
            (reduced (reduce + mapped 0))
        )
        reduced
    )
)

(zad1 L 1)
