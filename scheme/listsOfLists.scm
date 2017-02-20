#lang racket/base

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

(define (len L)
    (define (iter accum l)
        (if (null? l)
            accum
            (iter (+ accum 1) (cdr l))
        )
    )
    (iter 0 L)
)

(define M '((1 2 3 ) (4 5 6) (7 8 9)) )

(define (matrixSum matrix)
    (reduce + (map (lambda (l) (reduce + l 0)) matrix) 0)
)

(matrixSum M)

(define (rowsCounts matrix)
    (map len matrix)
)

(rowsCounts M)

(define (listMax list)
    (define (larger x y)
        (if (> x y) x y)
    )
    (define (helper list max)
        (if (null? list)
            max
            (helper (cdr list) (larger max (car list)) )
        )
    )
    (if (null? list)
        #f
        (helper (cdr list) (car list))
    )
)

(define (matrixMax matrix)
    (listMax (map listMax matrix))
)

(matrixMax M)

(define (transpose m) (apply map list m))

(transpose M)