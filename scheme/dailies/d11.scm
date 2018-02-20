;; scheme 7 - daily 11
;; name: Meg Ryan
;; date: Feb 16th, 2018

;(load-from-path "paradigms_d11.scm")
;(use-modules (ice-9 paradigms_d11))

(include "paradigms_d11.scm")

;; greatest
;; return the greatest value in a tup, e.g., (1 3 2) -> 3
(define greatest		;; working
  (lambda (tup)											;; take list as an input
  	(cond
  		((null? tup) 0)									;; check for null list and return 0 if yes
 ;;		((> (car tup) (car (cdr tup))) (car tup))		;; check if 1st list elmt > next elmt and return 1st elmt if yes -- issues w this but idk why
  		((> (car tup) (greatest (cdr tup))) (car tup))	;; check if 1st list elmt > greatest of remaning list and return 1st elmt if yes (process car, recurse cdr)
  		(else (greatest (cdr tup))))))					;; ^ if not, throw out 1st elmnt and recurse on remaining list

;; positionof
;; you may assume that the given tup actually contains n
;; e.g., (positionof 23 (1 52 23 9)) -> 3
(define positionof
  (lambda (n tup)								
	(cond
		((eq? n (car tup)) 1)						;; check if n=1st list elmt and return 1 if yes
		(else (+ (positionof n (cdr tup)) 1)))))	;; else, recurse on cdr (shift to next elmt)  and add 1 to final position value

;; value
;; given a game state, return the value of that state:
;; 10 if it's a win
;; -10 if it's a loss
;; 0 if it is either a draw or not an ending state
(define value
  (lambda (p gs)
  	(cond								;; utilizes win? function from helper file paradigms_d11.scm and corresponding info
  		((win? p gs) 10)				;; check if player1 has won and return 10 if so
  		((win? (other p) gs) -10)		;; check if player2 has won (implying player1 lost) and return -10 if so
  		(else 0))))						;; if none of the above, must be a draw or not an ending state and therefore return 0

;; tests for greatest
(display (greatest '(1 9 2)))
(display "\n")

(display (greatest '(143 8 31324 24)))
(display "\n")

;; tests for positionof
(display (positionof 23 '(1 52 23 9)))
(display "\n")

(display (positionof 50 '(50 45 1 52 23 9 102)))
(display "\n")

;; tests for value
(display (value 'x '(x o e o x e e e x)))
(display "\n")

(display (value 'x '(o o o x x e e e e)))
(display "\n")

(display (value 'x '(o o e x x e e e e)))
(display "\n")

;; correct output:
;;   $ guile d11.scm
;;   9
;;   31324
;;   3
;;   1
;;   10
;;   -10
;;   0

