#lang racket/base

(provide zad1)

(define-syntax cons-stream
    (syntax-rules () ((cons-stream h t) (cons h (delay t))) )
)
(define (head s) (car s))
(define (tail s) (force (cdr s)))

(define (zad1 ls)
    (define ops (cons-stream + (cons-stream - ops)))
    (define op +)
    (foldr
        (lambda (a b)
            (set! op (head ops))
            (set! ops (tail ops))
            (op a b)
        )
        0
        ls
    )
)