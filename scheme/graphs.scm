; (list nodes edges)

(define (make-graph v e)
    (list v e)
)

(define empty-graph (make-graph '() '()))

(define (empty-graph? graph)
    (and (null? (car graph)) (null? (cadr graph)))
)

(define (contains? l a)
    (> (length (filter (lambda (x) (equal? a x)) l)) 0)
)

(define (graph-nodes graph)
    (car graph)
)

(define (graph-edges graph)
    (cadr graph)
)

(define (nodeInV? node graph)
    (contains? (graph-nodes graph) node)
)

(define (edge? x y graph)
    (contains? (graph-edges graph) (list x y))
)

(define (nodeInEdge? node edge)
    (or (equal? node (car edge)) (equal? node (cadr edge)))
)

(define (insert-node node graph)
    (if (nodeInV? node graph)
        graph
        (make-graph (cons node (graph-nodes graph)) (graph-edges graph))
    )
)

(define (insert-edge edge graph)
    (make-graph (graph-nodes graph) (cons edge (graph-edges graph) ))
)

(define (remove-node node graph)
    (make-graph
        (filter (lambda (v) (not (equal? v node))) (graph-nodes graph))
        (filter (lambda (e) (not (nodeInEdge? node e))) (graph-edges graph))
    )
)

(define (remove-edge edge graph)
    (make-graph
        (graph-nodes graph)
        (filter (lambda (x) (not (equal? x edge))) (graph-edges graph))
    )
)

(define V '(1 2 3 4 5 6))
(define E '((1 2) (1 3) (3 4) (4 5) (5 6)))
(define G (make-graph V E))
;(display G)
;(newline)
;(define G (insert-node 5 G))
;(display G)
;(newline)
;(define G (insert-edge '(2 5) G))
;(display G)
;(newline)
;(define G (remove-node 5 G))
;(display G)
;(newline)

; find a path from a to b

(define (path-to? x y g)
    (let* 
        (
            (neighEdges (filter
                (lambda (e) (and 
                    (equal? x (car e))
                    (not (equal? x (cadr e)))))
                (graph-edges g))
            )
        )
        (cond 
            ((null? neighEdges) #f)
            ((edge? x y g) #t)
            (else
                (foldr
                    (lambda (a b) (or a b))
                    #f
                    (map (lambda (e) (path-to? (cadr e) y (remove-node x g) )) neighEdges)
                )
            )
        )
    )
)

;(path-to? 1 4 G)

(define (path-to? x y g)
    (let* 
        (
            (neighEdges (filter
                (lambda (e) (and 
                    (equal? x (car e))
                    (not (equal? x (cadr e)))))
                (graph-edges g))
            )
        )
        (cond 
            ((null? neighEdges) #f)
            ((edge? x y g) #t)
            (else
                (foldr
                    (lambda (a b) (or a b))
                    #f
                    (map (lambda (e) (path-to? (cadr e) y (remove-node x g) )) neighEdges)
                )
            )
        )
    )
)

(define (path-length x y G)
    (define MAX (+ (length (graph-edges G)) 1))
    (define (helper x y graph)
        (if (edge? x y graph)
            1
            (let*
                (
                    (path-from-x
                        (filter
                            (lambda (e) (eq? x (car e)))
                            (graph-edges graph)
                        )
                    )
                    (nodes (map cadr path-from-x))
                    (new-graph (remove-node x graph))
                    (path-to-y (lambda (node) (+ (helper node y new-graph) 1) ) )
                )
                (if (null? nodes)
                    MAX
                    (foldr
                        (lambda (x y) (min x y))
                        MAX
                        (map
                            path-to-y
                            nodes
                        )
                    )
                )
            )
        )
    )

    (define result (helper x y G))
    (if (>= result MAX)
        #f
        result    
    )
)

(path-length 1 4 G)

(define (path-path x y graph)
    (if (edge? x y graph)
        (list x y)
        (let*
            (
                (path-from-x
                    (filter
                        (lambda (e) (eq? x (car e)))
                        (graph-edges graph)
                    )
                )
                (nodes (map cadr path-from-x))
                (new-graph (remove-node x graph))
                (path-to-y (lambda (node) 
                    (let
                        (
                            (path (path-path node y new-graph))
                        )
                        (if (null? path)
                            '()
                            (cons x path)    
                        )
                    )
                ))
            )
            (if (null? nodes)
                '()
                (foldr
                    (lambda (x y)
                        (cond
                            ((and (> (length x) 0) (> (length y) 0) (< (length y) (length x))) y )
                            ((and (= (length x) 0) (> (length y) 0)) y)
                            (else x)
                        )
                    )
                    '()
                    (map
                        path-to-y
                        nodes
                    )
                )
            )
        )
    )
)

(path-path 1 6 G)