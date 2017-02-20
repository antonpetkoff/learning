#lang racket/base

(provide calculate-list)

(define (reduce op nv L)
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

(define (calculate-list ls)
    (define iter 0)
    (define vars '())
    (define ops '())
    (define op +)

    (map
        (lambda (x)
            (if (odd? iter)
                (set! ops (cons x ops))
                (set! vars (cons (if (list? x) (calculate-list x) x) vars))
            )
            (set! iter (+ iter 1))
        )
        ls
    )

    (set! ops (cons + (reverse ops)))   ; the plus at the start is for the null value
    (set! vars (reverse vars))

    (reduce
        (lambda (a b)
            (set! op (car ops))
            (set! ops (cdr ops))
            ((eval op) a b)
        )
        0
        vars
    )
)