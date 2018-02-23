;; scheme occur* function
;; Meg Ryan
;; Feb 20

(load-from-path "/afs/nd.edu/user37/cmc/Public/paradigms/scheme/d7/paradigms_d7.scm")
;;(use-modules (ice-9 paradigms_d7))

(define atom?
	(lambda (x)
		(and (not (pair? x)) (not (null? x)))))
		;; what does pair, and, not do???

(display "atom test: ")
(display (atom? '(b)))
(display "\n")

(define +
	(lambda (a b)
		(cond
			((zero? b) a)
			( else 
				(add1 (+ a (sub1 b)))
			)
		)
	)
)

(define -
	(lambda (a b)
		(cond
			((zero? b) a)
			( else (sub1 (- a (sub1 b))) )
		)
	)
)
			

(define or
	(lambda (a b)
		(cond
			( (eq? a #t) #t)
			(else b)
		)
	)
)

(display "or test: ")
(display (or #f #t))
(display "\n")

(define and
	(lambda (l)
		(cond
			( (eq? (car l) #t) (and (cdr l)) )
			(else #f)
		)
	)
)

(display "and test: ")
(display (and #t #t #t #f))
(display "\n")

;; count num occurences WITHOUT counting inner list elements
(define occur
	(lambda (a lat)
		(cond
			((null? lat) 0)
			((eq? a (car lat)) (add1 (occur a (cdr lat))))
			(else (occur a (cdr lat)))
		)
	)
)

(display "occur test: ")
(display (occur 1 '(3 4 5 12 (1) 2 1 4 1)))
(display "\n")

;; count num occurences WITH RECURSING on inner lists
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

(display "occur* test: ")
(display (occur* 1 '(3 4 5 12 (1) 2 1 4 1)))
(display "\n")

;; x: multiplies two numbers
(define x
	(lambda (a b)
		(cond
			( (or (zero? a) (zero? b)) 0)
			(else
				(+ (x (sub1 b) a) a)
			)
		)
	)
)

;; double: returns double given number
(define double
	(lambda (a)
		(cond
			((zero? a) 0)
			(else (add1 (add1 (double (sub1 a)))))
		)
	)
)

(display "double test: ")
(display (double 4))
(display "\n")

;; member?: returns true if given atom is in the lat
(define member?
	(lambda (a lat)
		(cond
			( (null? lat) #f)
			(else
				(cond
					( (eq? a (car lat)) #t)
					(else
						(member? a (cdr lat))
					)
				)
			)
		)
	)
)

(display "member? test: ")
(display (member? 'b '(a c)))
(display "\n")

;; rember: remove first instance of given atom from given list
(define rember
	(lambda (a lat)
		(cond
			((null? lat) '())
			( (eq? a (car lat)) (cdr lat) )
			(else
				(cons
					(car lat)
					(rember a (cdr lat))
				)
			)
		)
	)
)

(display "rember test: ")
(display (rember 'a '(c b a)))
(display "\n")

;; firsts: returns first atoms of arbitrary number of given lists
;; **assumes only one level lower inner lists ( () () ) not ( (()) (()) )
(define firsts
	(lambda (lat)
		(cond
			((null? lat) '())
			(else
				(cons
					(car (car lat))
					(firsts (cdr lat))
				)
			)
		)
	)
)

(display "firsts test: ")
(display (firsts '((a z) (b y) (c x))))
(display "\n")

;; filterN: returns only numbers >= n and <= m
(define filterN
	(lambda (n m lat)
		(cond
			((null? lat) '())
			(number? (car lat))
		)
	)
)

;; replacefirst: return a lat w/ first instance of a replaced w/ b
(define replacefirst
	(lambda (a b lat)
		(cond
			((null? lat) '())
			( (eq? a (car lat)) (cons b (cdr lat)) )
			(else
				(cons
					(car lat)
					(replacefirst (a b (cdr lat)))
				)
			)
		)
	)
)

(define testlist1 '(turkey gravy stuffing yams ham peas))
(display "replacefirst test: ")
(display (replacefirst 'turkey 'cheese testlist1))
(display "\n")

(display "x test: ")
(display (x 5 4))
(display "\n")

;; insertR*: insert new atom to right of first instance of old atom in list
;; not working bc of type error?
(define insertR*
	(lambda (new old lat)
		(cond
			((null? lat) '())
			(else
				(cond
					( (eq? old (car lat)) (cons (cons new (cdr lat)) old ) )
					(else 
						(cons 
							(car lat) 
							(insertR* (new old (cdr lat)))
						)
					)
				)
			)
		)
	)
)

(define testlist3 '(bacon turkey beef))
(display "insertR* test: ")
(display (insertR* 'carrots 'beef testlist3))
(display "\n")
