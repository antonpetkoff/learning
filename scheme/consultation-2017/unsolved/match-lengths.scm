(require rackunit rackunit/text-ui)

; Задача 4. Да се дефинира предикат (match-lenghts? l1 l2).
; l1 и l2 са непразни списъци от списъци от числа.
; Ако l1 = (a1 a2 … ak), а l2 = (b1 b2 … bk), предикатът да връща истина, когато
; разликите в дължините на всяка двойка съответни списъци ai и bi е еднаква.
;
; Пример:
; (match-lengths? ‘( () (1 2) (3 4 5)) ‘( (1) (2 3 4) (5 6 7 8))) -> #t,
; (match-lengths? ‘( () (1 2) (3 4 5)) ‘( () (2 3 4) (5 6 7))) -> #f



(define match-lengths?-tests
  (test-suite
    "Tests for match-lengths?"

    (check-true (match-lengths? '(() (1 2) (3 4 5)) '((1) (2 3 4) (5 6 7 8))))
    (check-false (match-lengths? '(() (1 2) (3 4 5)) '(() (2 3 4) (5 6 7))))
))

(run-tests match-lengths?-tests)
