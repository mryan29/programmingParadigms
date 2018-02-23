;; equaltree.scm
;; Meg Ryan
;; Feb20

(define xor
	(lambda (a b)
		(cond
			((eq? a b) #f)
			(else #t)
		)
	)
)

(define atom?
	(lambda (x)
		(and (not (pair? x)) (not (null? x)))))

(define equaltree
	(lambda (l1 l2)
		(cond
			((and (null? l1) (null? l2)) #t)
			((xor (null? l1) (null? l2)) #f) 
			((and (atom? (car l1)) (atom? (car l2)))
				(cond
					((eq? (car l1) (car l2)) (equaltree (cdr l1) (cdr l2)))
					(else #f)
				)
			)
			(else #f)
		)
	)
)

;; test
(display 
	(equaltree 
		'( (turkey) ((bacon)) ((cheese)) (((cheddar))) ) 
		'( (turkey) ((bacon)) ((cheese)) (((cheddar))) )
	)
)

(display "\n")
