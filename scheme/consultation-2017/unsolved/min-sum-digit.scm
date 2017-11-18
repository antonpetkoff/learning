(require rackunit rackunit/text-ui)

; Задача 1. Да се напише функция (min-sum-digit a b k), която
; намира най-малкото от целите числа от a да b,
; чиято сума на цифрите се дели на k





(define min-sum-digit-tests
  (test-suite
    "Tests for min-sum-digit"

    (check = (min-sum-digit 1 5 3) 3)
    (check = (min-sum-digit 1 7 2) 2)
    (check = (min-sum-digit 11 16 3) 12)
))

(run-tests min-sum-digit-tests)
