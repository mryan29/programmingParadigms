;; scheme homework 4 - daily 8
;; name: Meg Ryan
;; date: Feb 9th, 2018

(include "paradigms_d8.scm")

;; filterN
(define filterN
  (lambda (n m lat)
  	(cond
  		((null? lat) '())	;; if null, return an empty list
  		((number? (car lat))
  			(cond
  				((and (> (car lat)(sub1 n)) (< (car lat)(add1 m)))(cons (car lat)(filterN n m(cdr lat))))
  				(else (filterN n m(cdr lat)))))
  		(else (filterN n m(cdr lat))))))
    ;; currently this function just returns the lat as it is given
    ;; change the function so that it returns /only/ the numbers
    ;; >= n and <= m
    ;; see below for examples...

;; tests!
(display (filterN 4 6 '(1 turkey 5 9 4 bacon 6 cheese)))
(display "\n")

(display (filterN 4 6 '(4 4 4 1 1 bacon 9 9 8 6 6 6 1 4 5)))
(display "\n")

;; correct output:
;;   $ guile d8.scm
;;   (5 4 6)
;;   (4 4 4 6 6 6 4 5)

