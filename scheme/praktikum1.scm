(define (merge-sorted l1 l2 comp)
    (define (helper l1 l2 l)
        (cond ((and (null? l1) (null? l2)) l)
              ((null? l1) (helper l1 (cdr l2) (cons (car l2) l)) )
              ((null? l2) (helper (cdr l1) l2 (cons (car l1) l)) )
              ((comp (car l1) (car l2)) (helper (cdr l1) l2 (cons (car l1) l)) )
              (else (helper l1 (cdr l2) (cons (car l2) l)))
        )
    )
    (reverse (helper l1 l2 '()))
)

;(merge-sorted '(1 3 5 7) '(2 4 6) <)

(define (left-sublist l)
    (define mid (quotient (length l) 2)) ; exclusive right border [..)
    (define (helper source iter accum)
        (if (< iter mid)
            (helper (cdr source) (+ iter 1) (cons (car source) accum))
            accum
        )
    )
    (reverse (helper l 0 '()))
)

(define (right-sublist l)
    (define mid (quotient (length l) 2)) ; exclusive right border [..)
    (define (helper ls iter)
        (if (>= iter mid)
            ls
            (helper (cdr ls) (+ iter 1))    
        )
    )
    (helper l 0)
)

(define L '(3 6 1 -2 5))
(define L2 '(1 2 3 4))

(define (merge-sort l comp)
    (if (< (length l) 2)
        l
        (merge-sorted
            (merge-sort (left-sublist l) <)
            (merge-sort (right-sublist l) <)
            comp
        )
    )
)

(merge-sort L <)