#lang scheme

(define (square a) (* a a))
(define (pitagor x y) (+ (square x) (square y)))

(define (belowLine x y)
  (< y (+ (* (/ 2 3) x) 2) ) (#t)
)

(define (aboveLine x y)
  (> y (- (* (/ -2 3) x) 2) ) (#t)
)

(define (center x y)
  (and (= x 0) (= y 0)) #t
)

(define (triTop x y)
  ((and (>= x -3) (<= y 2) (belowLine x y) ) #t)
)

(define (triBot x y)
  ((and (>= x -3) (>= y -2) (aboveLine x y) ) #t)
)

(define (circle x y)
  ((and (> x 0) (<= (pitagor x y) 4) ) #t)
)

(define (inFig x y)
  (or
    (center x y)
    (triBot x y)
    (triTop x y)
    (circle x y)
  )
)

(define (inFigure x y)
  (cond
    ((and (> x 0) (<= (pitagor x y) 4) ) "in circle")
    ((< x 0) "left")
    ((and (< x 2) (> x -2)) "on y-axis")
    ("not inside")
  )
  
)
