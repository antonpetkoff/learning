#lang racket/base

(provide sub-tree)

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

(define (tree-height tree)
    (newline)
    (display tree)
    (newline)
    (if (null? tree)
        0
        (+ 1 (max 
                (tree-height (left-tree tree)) 
                (tree-height (right-tree tree))
             )
        )    
    )
)

(define (sub-tree T root-val is-min)
    (define min-tree empty-tree)
    (define max-tree empty-tree)
    (define (helper tree)
        (if (and (equal? (empty-tree? tree) #f) (equal? (root tree) root-val))
            (if (equal? #f is-min)
                (if (> (tree-height tree) (tree-height max-tree))
                    (set! max-tree tree)
                    empty-tree  ; noop
                )
                (if (or (empty-tree? min-tree)
                        (< (tree-height tree) (tree-height min-tree)))
                    (set! min-tree tree)
                    empty-tree  ; noop
                )
            )
            empty-tree  ; noop
        )

        (if (empty-tree? tree) empty-tree (helper (left-tree tree)))
        (if (empty-tree? tree) empty-tree (helper (right-tree tree)))
    )
    (helper T)
    (if (equal? #f is-min)
        max-tree
        min-tree
    )
)

(define T
    '(1
        (2
            (2
                (8 () ())
                (7 () ())
            )
            (4 () ())
        )
        (3
            (5 () ())
            (6 () ())
        )
    )
)
