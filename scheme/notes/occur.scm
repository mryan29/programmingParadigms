;; scheme occur* function
;; Meg Ryan
;; Feb 20

(load-from-path "/afs/nd.edu/user37/cmc/Public/paradigms/scheme/d7/paradigms_d7.scm")
(use-modules (ice-9 paradigms_d7))


;; this works WITHOUT counting inner list elements
(define occur*
	(lambda (a lat)
		(cond
			((null? lat) 0)
			((eq? a (car lat)) (add1 (occur* a (cdr lat))))
			(else (occur* a (cdr lat)))
		)
	)
)




;; tests
(display (occur* 1 '(3 4 5 12 (1) 2 1 4 1)))
(display "\n")

;;(display (occur* 'castle 
;;	'(knight sword 
;;		(armor 
;;			(castle 
;;				(king) 
;;				(horse castle) 
;;				(((castle)))
;;			)
;;		)
;;	)
;;))
(display "\n")
