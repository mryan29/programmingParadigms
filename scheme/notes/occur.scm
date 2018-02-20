;; scheme occur* function
;; Meg Ryan
;; Feb 20


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
(display (occur* 1 '(3 4 5 1 2 4)))
(display "\n")
