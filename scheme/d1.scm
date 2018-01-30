;; this is how to load external modules in scheme
(load-from-path "/afs/nd.edu/user37/cmc/Public/paradigms/scheme/d1/paradigms_d1.scm")
(use-modules (ice-9 paradigms_d1))

;; Meg Ryan

;; the list q
;; notice it has a ' in front of the list; that tells the interpreter to read
;; the list literally (e.g., as atoms, instead of functions)
(define q '(turkey (gravy) (stuffing potatoes ham) peas))

;; question 1
(display "question 1: ")
(display (atom? (car (cdr (cdr q)))))
(display "\n")
;; output:
;; #f
;;
;; explanation:
;; Beginning with the innermost function and working our way out...
;; The first cdr function (cdr q) creates the list and returns ((gravy) (stuffing potatoes ham) peas)
;; The second cdr function (cdr (cdr q)) returns ((stuffing potatoes ham) peas)
;; The car function (car (cdr (cdr q))) returns (stuffing potatoes ham)
;; Since (stuffing potatoes ham) is a list and not an atom, (atom? (car (cdr (cdr q)))) returns #f for FALSE

;; question 2
(display "question 2: ")
(display (lat? (car (cdr (cdr q)))))
(display "\n")
;; output:
;; #t
;;
;; explanation:
;; The 3 innermost functions are the same as those in question 1, so we can begin there
;; (car (cdr (cdr q))) returns (stuffing potatoes ham) - from q1
;; Since (stuffing potatoes ham)  is a list of atoms, (lat? (car (cdr (cdr q)))) returns #t for TRUE


;; question 3
(display "question 3: ")
(display (cond ((atom? (car q)) (car q)) (else '())))
(display "\n")
;; output:
;; turkey
;;
;; explanation:
;; This checks if the front of the list q is an atom
;; If yes, the front of the list q is printed. Otherwise, an empty list is printed
;; Beginning with the innermost function of the conditional w/ respect to our list q...
;; (car q) returns turkey
;; Since turkey is an atom, ((atom? (car q)) will return #t for TRUE
;; Therefore, the conditional will evaluate to TRUE and return (car q), which we know returns 'turkey'

