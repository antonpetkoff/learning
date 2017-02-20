
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

(define (range a b)
    (define (helper list iter)
        (if (<= iter b)
            (helper (cons iter list) (+ iter 1))
            list
        )
    )
    (reverse (helper '() a))
)

(define (get-divisors-sum n)
    (reduce + (filter (lambda (x) (= 0 (remainder n x))) (range 1 n)) 0)
)

(define (prod-sum-div a b k)
    (let*
        (
            (filtered (filter (lambda (i) (= 0 (remainder (get-divisors-sum i) k))) (range a b)))
            (prod (reduce * filtered 1))
        )
        prod
    )
)

(define (img? l1 l2)
    (define diffs (map (lambda (i) (- (list-ref l2 (- i 1)) (list-ref l1 (- i 1)))) (range 1 (length l1))))
    (= (length l1) (length (filter (lambda (x) (eq? x (list-ref diffs 0))) diffs)))
)

;(img? '(1 2 3) '(4 5 4))

(define (duplicates l1 l2)
    (filter (lambda (i) (> (length (filter (lambda (j) (eq? i j)) l2)) 1)) l1)
)

(duplicates '(1 2 3) '(1 2 1 3 2))