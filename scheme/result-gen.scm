#lang racket/base

;goes right!
(define (accumulate-while comb null init cond next term)
  (define (step accum iter)
    (if (cond iter)
        (step (comb accum (term iter)) (next iter))
        accum
    )
  )
  (step null init)
)

(define (result-gen start end op term)
  (define (id x) x)
  (define (next x) (+ x term))
  (define (until x) (<= x end))
  (define (append a b) (string-append a "+" (number->string b)))
  
  (define sum (accumulate-while + start start until next id))
  
  (define expr
    (accumulate-while 
      append
      (number->string start)
      (next start)
      until
      next
      id
    )
  )
  
  (display (string-append expr " = " (number->string sum) ))
)

(result-gen -2 9 + 3)