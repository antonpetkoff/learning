(define (range a b)
    (define (helper list iter)
        (if (> iter b)
            list
            (helper (cons iter list) (+ iter 1))
        )
    )
    (reverse (helper '() a))
)

(define (meetTwice? f g a b)
    (define numbers (range a b))
    (define l1 (map f numbers) )
    (define l2 (map g numbers) )
    (define len (length numbers))

    (define (helper iter cnt)
        (if (>= iter len)
            cnt
            (if (= (list-ref l1 iter) (list-ref l2 iter))
                (helper (+ iter 1) (+ cnt 1))
                (helper (+ iter 1) cnt)
            )
        )
    )
    (> (helper 0 0) 1)
)

;(meetTwice? (lambda (x) x) (lambda (x) (- x)) -3 1)
;(meetTwice? (lambda (x) x) sqrt 0 8)

(define (checkMatrix? m k)
    (let*
        (
            (kratni (map (lambda (row) (filter (lambda (x) (= 0 (remainder x k))) row)) m))
            (counts (filter (lambda (x) (> x 0)) (map length kratni)))        
        )
        (= (length counts) (length m))
    )
)

;(define M1 '((1 2 6) (3 8 9) (10 12 11)) )
;(define M2 '((1 2 4) (3 8 9) (10 12 11)) )

;(checkMatrix? M1 3)
;(checkMatrix? M2 3)


(define (count elem list)
    (define (counter list cnt)
        (if (null? list)
            cnt
            (if (= (car list) elem)
                (counter (cdr list) (+ cnt 1))
                (counter (cdr list) cnt)
            )
        )
    )
    (counter list 0)
)

;(count 3 '(1 2 3 4 5 3 3))

(define (reduce op nv l)
    (define (helper list accum)
        (if (null? list)
            accum
            (helper (cdr list) (op accum (car list)))
        )
    )
    (helper l nv)
)

(define (larger a b) (if (> a b) a b))

(define (maxElem list)
    (if (null? list)
        #f
        (reduce larger (car list) list)
    )
)

;(maxElem '(1 2 38 4 5))
;(maxElem '())

(define (maxDuplicate ll)
    (let* 
        (
            (duplicates (map (lambda (l) ( filter (lambda (x) (> (count x l) 1)) l )) ll))
            (singleList (reduce append '() duplicates))
        )
        (maxElem singleList)
    )
)

;(define ll1 '((1 2 3 2) (-4 -4) (5)) )
;(define ll2 '((1 2 3) (-4 -5 -6) ()) )

;(maxDuplicate ll1)
;(maxDuplicate ll2)

; given a list (at least one element) return the first descending sublist
(define (firstDesc l)
    (define (helper source desc)
        (if (and
                (not (null? source))
                (<= (car source) (car desc))
            )
            (helper (cdr source) (cons (car source) desc))
            desc
        )
    )
    (reverse (helper (cdr l) (list (car l))))
)

;(firstDesc '(4 3 2 9))

(define (longestDescending l)
    (define (generateAll ls)
        (define (helper remaining result)
            (if (null? remaining)
                result
                (helper (cdr remaining) (cons (firstDesc remaining) result) )
            )
        )
        (reverse (helper ls '()))
    )

    (let* 
        (
            (all (generateAll l))
            (maxLen (maxElem (map length all)))
            (candidates (filter (lambda (sublist) (= maxLen (length sublist))) all))
        )
        (car candidates)
    )
)

(longestDescending '(5 3 8 6 4 2 6 7 1))
(longestDescending '(1 2 3 4 5 6))