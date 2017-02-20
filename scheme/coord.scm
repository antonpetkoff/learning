#lang scheme

(define (quord x y)
  (cond
    ((and (> x 0) (> y 0)) "TOP R")
    ((and (< x 0) (< y 0)) "BOT L")
    ((and (> x 0) (< y 0)) "BOT R")
    ((and (< x 0) (> y 0)) "TOP L")
    ("CENTER")
  )
)