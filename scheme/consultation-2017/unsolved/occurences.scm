(require rackunit rackunit/text-ui)

; Задача 3. Да се дефинира функция (occurrences l1 l2).
; l1 и l2 са списъци от числа.
; Функцията да конструира списък с броя на срещанията на всеки от елементите на l1 в l2.
; Пример: (occurrences ‘(1 2 3) ‘( 1 2 4 1 )) -> (2 1 0)



(define occurrences-tests
  (test-suite
    "Tests for occurrences"

    (check-equal? (occurrences '(1 2 3) '(1 2 4 1)) '(2 1 0))
    (check-equal? (occurrences '(2 9 8) '(1 8 7 3 9 2 8 8 1 2)) '(2 1 3))
))

(run-tests occurrences-tests)
