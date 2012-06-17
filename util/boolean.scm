; Boolean Procedures

(define (and@ xs)
  (cond ((null? xs) #t)
        ((not (car xs)) #f)
        (else (and@ (cdr xs)))))

(define (or@ xs)
  (cond ((null? xs) #f)
        ((car xs) #t)
        (else (or@ (cdr xs)))))

