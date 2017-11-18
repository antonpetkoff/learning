(require rackunit rackunit/text-ui)

; Да се напише функция (average f g), която по две числови функции f : R → R и g : R → R
; намира средно-аритметичната функция (f⊕g)(x)=(f(x)+g(x))/2.
;
; С помощта на average да се напише функция от по-висок ред (calcprod f n), която
; намира произведението ∏ni=1(f⊕gi)(i), където gi(x) = i^x.
;
; Използването на accumulate е позволено, но не е задължително.




(define (identity x) x)
(define (square x) (* x x))
(define (cube x) (* x x x))

(define average-tests
  (test-suite
    "Tests for average"

    (check = ((average identity identity) 3) 3)
    (check = ((average identity square) 4) 10)
    (check = ((average square square) 2) 4)
    (check = ((average cube identity) 2) 5)
    (check = ((average cube square) 2) 6)
))

(define calcprod-tests
  (test-suite
    "Tests for calcprod"

    ; ((1 + 1^1) / 2) * ((2 + 2^2) / 2) = 1 * 3 = 3
    (check = (calcprod identity 2) (* 1 3))

    ; ((1 + 1^1) / 2) * ((2 + 2^2) / 2) * ((3 + 3^3) / 2)
    (check = (calcprod identity 3) (* 1 3 15))

    ; ((1^2 + 1^1) / 2) * ((2^2 + 2^2) / 2) * ((3^2 + 3^3) / 2)
    (check = (calcprod square 3) (* 1 4 18))
))

(run-tests average-tests)
(run-tests calcprod-tests)
