#lang racket/base

(define (make-tree root left right)
    (list root left right)
)

(define (value tree)
    (car tree)
)

(define (left tree)
    (cadr tree)
)

(define (right tree)
    (caddr tree)
)

(define (leaf? tree)
    (and
        (null? (left tree))
        (null? (right tree))
    )
)

(define (make-leaf value)
    (make-tree value '() '())
)

(define (bloom tree)
    (if (leaf? tree)
        (make-tree
            (value tree)
            (make-leaf (value tree))
            (make-leaf (value tree))
        )
        (make-tree
            (value tree)
            (bloom (left tree))
            (bloom (right tree))
        )
    )
)

(define T
    (make-tree 1
        (make-leaf 2)
        (make-tree 3
            (make-leaf 4)
            (make-leaf 5)
        )
    )
)

(bloom T)