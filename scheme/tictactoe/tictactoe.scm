;; scheme tictactoe homework
;; name: Meg Ryan
;; date: Feb 23, 2018

;(load-from-path "/home/scratch/paradigms/scheme_tictactoe/paradigms_ttt.scm")
;(use-modules (ice-9 paradigms_ttt))
(include "paradigms_ttt.scm")

;; REPLACE WITH YOUR FUNCTIONS FROM A PREVIOUS HOMEWORK:
;;  greatest
;;  positionof
;;  value

(define greatest
  (lambda (tup)
		(cond
			((null? tup) 0)											;; check for null list and return 0 if yes
			(
				(> 
					(car tup) 
					(greatest (cdr tup))
				) 
				(car tup)
			)		 
		(else (greatest (cdr tup)))
		)
  )
)							
		     
		       

(define positionof
  (lambda (n tup)
		(cond
			((eq? n (car tup)) 1)						;; check if n=1st list elmt and return 1 if yes
			(else (+ (positionof n (cdr tup)) 1)))))	;; else, recurse on cdr (shift to next elmt)  and add 1 to final position value

(define value
  (lambda (p gs)
		(cond
			((win? p gs) 10)
			((win? (other p) gs) -10)
			(else 0))))

;; helper functions
(define atom?
	(lambda (x) 
		(and (not (null? x)) (not (pair? x)))))

(define lat?
	(lambda (l)
		(cond
			((null? l) #t)
			((atom? (car l)) (lat? (cdr l)))
			(else #f))))




;; MODIFY your sum* function for this assignment...
(define sum*-g
  (lambda (ttup f)
  	(lambda (p)							;; "functions as data": will be the output of the value function defined above
	  	(cond
  			((null? ttup) 0)
			(
				(lat? (car ttup)) 
				(+ 
					(f p (car ttup)) 
					((sum*-g (cdr ttup) f) p)
				)
			)
			(else 
				(+ 
					((sum*-g (car ttup) f) p) 
					((sum*-g (cdr ttup) f) p)
				)
			)
		)
	)
  )
)


;; helper function
(define valslist
	(lambda (p gt)
		(cond
			((null? gt) '())
				(else
					(cons
						((sum*-g (car gt) value) p) ;; edit here, add p gt
						(valslist p (cdr gt))
					)
				)
		)
	)
)


;; MODIFY this function so that given the game tree 
;; (where the current situation is at the root),
;; it returns the recommendation for the next move
(define nextmove
  (lambda (p gt)
	(car 
		(pick 
			(positionof 
				(greatest 
					(valslist p (cdr gt))
				) 
				(valslist p (cdr gt))
			) 
			(cdr gt)
		)
	)
 )
)
	

;; onegametree is defined in paradigms_ttt
;; be sure to look at that file!

;; what is the current game situation?
(display "Current State:     ")
(display (car (onegametree)))
(display "\n")

;; test of nextmove, where should we go next?
(display "Recommended Move:  ")
(display (nextmove 'x (onegametree)))
(display "\n")

;; correct output:
;;   $ guile tictactoe.scm
;;   Current State:     (x o x o o e e x e)
;;   Recommended Move:  (x o x o o x e x e)


