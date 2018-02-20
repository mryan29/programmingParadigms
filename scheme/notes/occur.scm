;; scheme occur* function
;; Meg Ryan
;; Feb 20

(load-from-path "/afs/nd.edu/user37/cmc/Public/paradigms/scheme/d7/paradigms_d7.scm")
(use-modules (ice-9 paradigms_d7))

(define atom?
	(lambda (x)
		(and (not (pair? x)) (not (null? x)))))
		;; what does pair, and, not do???

;; this works WITHOUT counting inner list elements
(define occur_non
	(lambda (a lat)
		(cond
			((null? lat) 0)
			((eq? a (car lat)) (add1 (occur_non a (cdr lat))))
			(else (occur_non a (cdr lat)))
		)
	)
)

;; WITH RECURSING on inner lists
(define occur*
	(lambda (a lat)
		(cond
			((null? lat) 0)
			((atom? (car lat))
			(cond
				((eq? (car lat) a)
				(add1 (occur* a (cdr lat))))
				(else (occur* a (cdr lat)))))
			(else (+ (occur* a (car lat)) (occur* a (cdr lat)))))))


;; tests
(display (occur_non 1 '(3 4 5 12 (1) 2 1 4 1)))
(display "\n")

(display (occur* 1 '(3 4 5 12 (1) 2 1 4 1)))
(display "\n")

(display (occur_non 'castle
	'(knight sword
		(armor
			(castle
				(king)
				(horse castle)
				(((castle)))
			)
		)
	)
))
(display "\n")

(display (occur* 'castle 
	'(knight sword 
		(armor 
			(castle 
				(king) 
				(horse castle) 
				(((castle)))
			)
		)
	)
))
(display "\n")
