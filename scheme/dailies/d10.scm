;; scheme 6 - daily homework 10
;; name: Meg Ryan
;; date: February 14th, 2018

;; notice the use of debugging traps finally!!
(use-modules (ice-9 debugging traps) (ice-9 debugging trace))

(define sum*
  (lambda (ttup)
    (cond
		((null? ttup) 0)											;; check null
		((number? (car ttup)) (+ (car ttup) (sum* (cdr ttup))))		;; process car, recurse cdr
		(else (+ (sum* (car ttup)) (sum* (cdr ttup)))))))			;; if you cant process car, recurse on car

;;(install-trap (make <procedure-trap>
  ;;                          #:procedure sum*
    ;;                        #:behaviour (list trace-trap trace-until-exit)))

;; tests!
(display (sum* '((5)) ))
(display "\n")

(display (sum* '((0) ((0) ((5))) ((0) ((10)))) ))
(display "\n")

(display (sum* '((0) ((0) ((5) ((7)))) ((0) ((10) ))) ))
(display "\n")

(display (sum* '((0) ((0) ((5) ((7) ) ((8) ))) ((0) ((10) ))) ))
(display "\n")

;; correct output:
;;   $ guile d10.scm
;;   5
;;   15
;;   22
;;   30

