#lang racket/base

(provide binary-tree-sort)

(define empty-tree '())

(define (make-tree root left right)
    (list root left right)
)

(define (root tree)
    (car tree)
)

(define (left-tree tree)
    (cadr tree)
)

(define (right-tree tree)
    (caddr tree)
)

(define empty-tree? null?)

(define (tree-insert T x)   ; binary search tree insertion
    (cond
        ((empty-tree? T) (make-tree x empty-tree empty-tree))
        ((< x (root T))
            (if (empty-tree? (left-tree T))
                (make-tree (root T) (make-tree x '() '()) (right-tree T))
                (make-tree (root T) (tree-insert (left-tree T) x) (right-tree T))
            )
        )
        (else
            (if (empty-tree? (right-tree T))
                (make-tree (root T) (left-tree T) (make-tree x '() '()))
                (make-tree (root T) (left-tree T) (tree-insert (right-tree T) x))
            )
        )
    )
)

(define (list->tree ls)
    (define (helper ls tree)
        (if (null? ls)
            tree
            (helper (cdr ls) (tree-insert tree (car ls)))    
        )
    )
    (helper ls empty-tree)
)

(define (tree->list tree)    ; in order traversal
    (if (empty-tree? tree)
        '()
        (append
            (tree->list (left-tree tree))
            (list (root tree))
            (tree->list (right-tree tree))
        )
    )
)

(define (binary-tree-sort ls)
    (tree->list (list->tree ls))
)
