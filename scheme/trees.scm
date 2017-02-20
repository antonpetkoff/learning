; sum-tree, max-num, tree-height

; kolkoto poveche samoubiici, tolkova po-malko ubiici

; triplet list :: (rootValue, leftTree, rightTree)

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

(define (leaf? tree)
    (and
        (null? (left-tree tree))
        (null? (right-tree tree))
    )
)

(define (empty-tree? tree)
    (null? tree)
)

(define (sum-tree tree)
    (if (null? tree)
        0
        (+ (root tree) (sum-tree (left-tree tree)) (sum-tree (right-tree tree)))
    )
)

(define (max-element tree)
    (if (leaf? tree)
        (root tree)
        (max
            (root tree) 
            (if (null? (left-tree tree)) (root tree) (max-element (left-tree tree)) )    
            (if (null? (right-tree tree)) (root tree) (max-element (right-tree tree)) )
        )
    )
)

(define (tree-height tree)
    (if (null? tree)
        0
        (+ 1 (max 
                (tree-height (left-tree tree)) 
                (tree-height (right-tree tree))
             )
        )    
    )
)

(define ET '())

(define T5 (make-tree 5 ET ET))
(define T8 (make-tree 8 ET ET))
(define T6 (make-tree 6 T8 ET))
(define T3 (make-tree 3 T5 T6))

(define T1 (make-tree 1 ET ET))
(define T2 (make-tree 2 ET ET))
(define T7 (make-tree 7 T2 T1))
(define T9 (make-tree 9 ET T7))

(define T (make-tree 1 T3 T9))

(sum-tree T)
(tree-height T)
(max-element T)

(define (max-num tree)
    (if (null? tree)
        0
        (let*
            (
                (left-num (max-num (left-tree tree)))
                (right-num (max-num (right-tree tree)))
                (max-lr (max left-num right-num))
            )
            (+ (* 10 max-lr) (root tree))
        )    
    )
)

(max-num T)

(define (map-tree f tree)
    (if (null? tree)
        ET
        (make-tree
            (f (root tree))
            (map-tree f (left-tree tree))
            (map-tree f (right-tree tree))
        )
    )
)

(define (square x)
    (* x x)
)

(map-tree square T)