(define genericlat
  (lambda (seq a lat)
      (cond
            ((null? lat) '())
            ((eq? a (car lat)) (seq (genericlat seq a (cdr lat))))
            (else (cons (car lat) (genericlat seq a (cdr lat)))))))


		;; below passed into sequence
		;; (cond
		;;	((null? '(turkey bacon cheese)) '())
		;;

(define seqrepl				
  (lambda (b)					;; b = beef
      (lambda (lat)
            (cons b lat))))
            
            ;; returns funciton:
            ;; (lambda (lat)
            ;;		(cons beef lat)
            ;; )
          
            
(define seqrem
  (lambda (lat)
      lat))

(display (genericlat (seqrepl 'beef) 'turkey '(turkey bacon cheese)))
(display "\n")

(display (genericlat seqrem 'turkey '(turkey cheese)))
(display "\n")
