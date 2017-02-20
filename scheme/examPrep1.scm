(define (rcons l x) (append l (list x)))

(define (range a b)
    (define (helper list iter)
        (if (<= iter b)
            (helper (rcons list iter) (+ iter 1))
            list
        )
    )
    (helper '() a)
)

(define (sum-digits n)
    (define (helper iter accum)
        (if (= iter 0)
            accum
            (helper (quotient iter 10) (+ accum (remainder iter 10)))
        )
    )
    (helper n 0)
)

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

(define (min-sum-digit a b k)
    (let* 
        (
            (all (range a b))
            (sums (map sum-digits all))
            (filtered (filter (lambda (s) (= 0 (remainder s k))) sums))

            (less (lambda (x y) (if (< x y) x y) ))
            (minimum (reduce less filtered (car filtered)))
        )
        minimum
    )
)

;(min-sum-digit 5 15 2)

(define (average f g)
    (lambda (x) (/ (+ (f x) (g x)) 2))
)

(define (square x) (* x x))
(define (cube x) (* x x x))
;((average square cube) 2)

(define (calcprod f n)
    (define (exptF base) (lambda (x) (expt base x)) )
    (define functions (map (lambda (i) (average f (exptF i) )) (range 1 n)) )
    ; we return a function
    (lambda (x) (reduce * (map (lambda (f) (f x)) functions) 1) )
)

;((calcprod square 3) 2)

(define (occurrences l1 l2)
    (map 
        (lambda (i) (length (filter (lambda (j) (eq? i j)) l2) ))
        l1
    )
)

;(occurrences '(1 2 3) '( 1 2 4 1 ))

(define (match-lengths? l1 l2)
    (equal? (map length l1) (map length l2))
)

(match-lengths? '( () (1 2) (3 4 5)) '( (1) (2 3 4) (5 6 7)) )
(match-lengths? '( () (1 2) (3 4 5)) '( () (2 3) (5 6 7)) )